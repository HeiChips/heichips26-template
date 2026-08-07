#!/usr/bin/env python3
"""Generate the test vectors used by testbenches/verilog/top_module_tb.sv.

Writes four files into the output directory:

  vectors.hex    UART bytes, one hex byte per line: S bytes then T bytes per case
  expected.txt   golden score per case, one per line
  sequences.txt  human readable dump of the sequences and their score
  num_cases.txt  number of cases in the files

By default the sequence lengths and scoring constants are read from
rtl/macros.svh, so the vectors always match the RTL. Every value can be
overridden on the command line, e.g.

  python3 scripts/gen_vectors.py --cases 3 --seed 7
  python3 scripts/gen_vectors.py --n 30 --m 30 --cases 5
"""

import argparse
import os
import random
import re

HERE = os.path.dirname(os.path.abspath(__file__))
MACROS = os.path.join(HERE, "..", "rtl", "macros.svh")
TV_DIR = os.path.join(HERE, "..", "testbenches", "verilog", "tv")

BASES = {"A": 0b100, "C": 0b101, "G": 0b110, "T": 0b111}
SYMBOL_BITS = 3
DATA_BITS = 6          # payload bits per UART byte (byte_router framing)
DIR_S = 0b00           # byte[7:6] tag for S
DIR_T = 0b01           # byte[7:6] tag for T
IDLE_SYMBOL = 0b000    # `BASE_IDLE from macros.svh


def read_macros(path):
    """Pull the `define values the generator cares about out of macros.svh."""
    text = open(path).read()
    out = {}
    for name in ("N", "M", "MATCH", "MISMATCH"):
        m = re.search(r"^`define\s+%s\s+(-?\d+)" % name, text, re.M)
        if m:
            out[name] = int(m.group(1))
    for name in ("ALPHA", "BETA"):
        m = re.search(r"parameter\s+signed.*\b%s\s*=\s*(-?\d+)" % name, text)
        if m:
            out[name] = int(m.group(1))
    return out


def score(s_seq, t_seq, match, mismatch, alpha, beta):
    """Smith-Waterman with affine gaps, mirroring the PE recurrence.

    Every intermediate is clamped at zero (that is what max_pos2 does), a gap
    open costs ALPHA and each further gap symbol costs BETA. S is walked in
    reverse: the first symbol shifted in ends up in the last PE of the chain.
    """
    s = list(reversed(s_seq))
    n, m = len(s), len(t_seq)

    v = [[0] * (m + 1) for _ in range(n + 1)]
    e = [[0] * (m + 1) for _ in range(n + 1)]
    f = [[0] * (m + 1) for _ in range(n + 1)]
    best = 0

    for i in range(1, n + 1):
        for j in range(1, m + 1):
            sub = match if s[i - 1] == t_seq[j - 1] else mismatch
            e[i][j] = max(0, e[i][j - 1] - beta, v[i][j - 1] - alpha)
            f[i][j] = max(0, f[i - 1][j] - beta, v[i - 1][j] - alpha)
            v[i][j] = max(0, v[i - 1][j - 1] + sub, e[i][j], f[i][j])
            best = max(best, v[i][j])

    return best


def to_bytes(seq, direction):
    """Pack a symbol sequence into the word the assembler rebuilds, then split
    it into tagged UART bytes (first byte carries the most significant chunk).
    The accelerator consumes the word LSB first, so symbol 0 sits in bits[2:0].

    A byte carries exactly two symbols, so an odd length is rounded up with a
    trailing BASE_IDLE: st_lut scores a symbol with MSB 0 as 0 against every
    base, and a zero-scoring column at the end of the sequence cannot raise the
    local-alignment maximum, so the golden score is unaffected. Rounding down
    instead would drop a base and leave the assembler one byte short of a word,
    where it would block waiting for a byte that never arrives.
    """
    seq = list(seq)
    if len(seq) % 2:
        seq.append(IDLE_SYMBOL)

    word = 0
    for k, sym in enumerate(seq):
        word |= sym << (SYMBOL_BITS * k)

    num_bytes = len(seq) * SYMBOL_BITS // DATA_BITS
    chunks = []
    for b in range(num_bytes):
        chunk = (word >> (DATA_BITS * (num_bytes - 1 - b))) & 0x3F
        chunks.append((direction << 6) | chunk)
    return chunks


def main():
    mac = read_macros(MACROS)

    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--n", type=int, default=mac.get("N", 30), help="S length in symbols (= number of PEs)")
    p.add_argument("--m", type=int, default=mac.get("M", 30), help="T length in symbols")
    p.add_argument("--cases", type=int, default=5, help="number of test cases")
    p.add_argument("--seed", type=int, default=1, help="random seed")
    p.add_argument("--match", type=int, default=mac.get("MATCH", 2))
    p.add_argument("--mismatch", type=int, default=mac.get("MISMATCH", -1))
    p.add_argument("--alpha", type=int, default=mac.get("ALPHA", 2), help="gap open penalty")
    p.add_argument("--beta", type=int, default=mac.get("BETA", 1), help="gap extend penalty")
    p.add_argument("--out", default=TV_DIR, help="output directory")
    args = p.parse_args()

    # An odd length is fine here (to_bytes pads it with BASE_IDLE), but the RTL
    # itself cannot be built for one: S_LEN = N*3 must divide into 6-bit
    # payloads, so an odd `N in macros.svh silently loses 3 bits in the
    # assembler's WORD_BITS/DATA_BITS. Check the byte count we emit against the
    # one the RTL will sit waiting for, or the assembler just blocks forever.
    for name, length, macro in (("S", args.n, "N"), ("T", args.m, "M")):
        if macro not in mac:
            continue
        rtl_len = mac[macro]
        if (rtl_len * SYMBOL_BITS) % DATA_BITS:
            p.error("macros.svh has `%s = %d; the RTL needs an even length "
                    "(%s_LEN = %d bits does not split into %d-bit payloads)"
                    % (macro, rtl_len, name, rtl_len * SYMBOL_BITS, DATA_BITS))
        emitted = (length + 1) // 2
        wanted = rtl_len * SYMBOL_BITS // DATA_BITS
        if emitted != wanted:
            p.error("%s length %d packs into %d byte(s) but macros.svh `%s = %d "
                    "makes the RTL wait for %d; the assembler would stall"
                    % (name, length, emitted, macro, rtl_len, wanted))

    random.seed(args.seed)
    letters = list(BASES)

    vectors, expected, described = [], [], []
    for c in range(args.cases):
        s_letters = [random.choice(letters) for _ in range(args.n)]
        t_letters = [random.choice(letters) for _ in range(args.m)]
        s_seq = [BASES[x] for x in s_letters]
        t_seq = [BASES[x] for x in t_letters]

        result = score(s_seq, t_seq, args.match, args.mismatch, args.alpha, args.beta)

        vectors += to_bytes(s_seq, DIR_S) + to_bytes(t_seq, DIR_T)
        expected.append(result)
        described.append("case %d: seq_a=%s seq_b=%s score=%d"
                         % (c, "".join(s_letters), "".join(t_letters), result))

    os.makedirs(args.out, exist_ok=True)
    with open(os.path.join(args.out, "vectors.hex"), "w") as fh:
        fh.write("".join("%02x\n" % b for b in vectors))
    with open(os.path.join(args.out, "expected.txt"), "w") as fh:
        fh.write("".join("%d\n" % s for s in expected))
    with open(os.path.join(args.out, "sequences.txt"), "w") as fh:
        fh.write("".join(line + "\n" for line in described))
    with open(os.path.join(args.out, "num_cases.txt"), "w") as fh:
        fh.write("%d\n" % args.cases)

    print("wrote %d case(s) to %s (N=%d, M=%d, %d bytes per case)"
          % (args.cases, os.path.normpath(args.out), args.n, args.m,
             (args.n + 1) // 2 + (args.m + 1) // 2))
    for line in described:
        print("  " + line)


if __name__ == "__main__":
    main()
