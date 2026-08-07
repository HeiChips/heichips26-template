import serial
from data_gen_and_validation import generate_dna_pair, smith_waterman_impl,seq_to_arr_string_list
import time
import argparse
import threading
import queue


def bitstring_to_bytes(bit_str: str) -> bytes:

    # bit_str = bit_str.replace(" ", "").strip()

    remainder = len(bit_str) % 8
    if remainder != 0:
        bit_str += "0" * (8 - remainder)

    byte_list = []
    for i in range(0, len(bit_str), 8):
        byte_chunk = bit_str[i : i + 8]
        byte_val = int(byte_chunk, 2)
        byte_list.append(byte_val)

    return bytes(byte_list)

def seq2bit_pattern(seq, type ="s"):
    bit_pattern = "00" if type=="s" else "01"
    for i in range(0,len(seq)-1,2):
        bit_pattern += seq[i] + seq[i+1]+ ("00" if type=="s" else "01")
    bit_pattern = bit_pattern[:-2] # trim last two zeros added due to last loop
    return bitstring_to_bytes(bit_pattern)

def receive_continuous_stream(port: str, baudrate: int = 115200):  
    score = 0 
    with serial.Serial(port, baudrate, timeout=1) as ser:
        while True:
            raw_data = ser.read(1) # number of bytes to read
            if len(raw_data) == 1:
                score = int(raw_data.hex(),16)
                print(f"\nMax Alignment Score: {score}")
                break
    return score


def send_and_read_bit_patterns(
    port: str, seq_1: bytes, seq_2: bytes, type:str = "1", first_flag:int =0 , baudrate: int = 115200) -> None:
    # print(f"seq_1 Packed bytes  : {seq_1.hex(' ')}")

    with serial.Serial(port, baudrate= 115200, timeout=1) as ser:
        if(first_flag):
            bytes_written = ser.write(seq_1)
        bytes_written = ser.write(seq_2)
        accel_time_start = time.perf_counter()

        while True:
            raw_data = ser.read(1) # number of bytes to read
            if len(raw_data) == 1:
                accel_time_stop = time.perf_counter()
                score = int(raw_data.hex(),16)
                print(f"\nMax Alignment Score: {score} and time elapsed {accel_time_stop-accel_time_start}")
                break

    return score

def tx_worker(ser: serial.Serial, seqa_queue: queue.Queue, time_queue: queue.Queue,
              stop_event: threading.Event):
    while not stop_event.is_set():
        try:
            # Wait up to 100ms for new data to send
            if(not seqa_queue.empty()):
                payloada = seqa_queue.get()
                if(payloada[1] != " "):
                    ser.write(payloada[1])
                ser.write(payloada[0])
                time_queue.put(time.perf_counter())
            
        except queue.Empty:
            continue

def rx_worker(ser: serial.Serial, comp_queue: queue.Queue, time_queue: queue.Queue, stop_event: threading.Event):
    while True:
        try:
            if ser.in_waiting:
                accel_time_stop = time.perf_counter()
                raw_data = ser.read(1) # number of bytes to read
                val = int(raw_data.hex(),16)
                expected = comp_queue.get()
                if val !=expected[0] :
                    print(f"\033[31mAlignment Mismatched received: {val}, expected: {expected[0]}\033[0m")
                    stop_event.set()
                    break
                else:
                    print(f"\033[32mAlignment Matched {val} and time for software is {expected[1]} and accel time is {accel_time_stop-time_queue.get()}\033[0m")
        except queue.Empty or AttributeError:
            continue


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="--type 1/2 --N 5 --v 1/2")
    parser.add_argument("--type", type=str, help="1 or 2, 1 is the normal s-t seq and 2 is s-tttt seq", required=True, choices=["1", "2"])
    parser.add_argument("--N", help="Numeric values for number of string paterns", required=True)
    parser.add_argument("--v", help="Numeric values for number of string paterns", required=True, choices=["1", "2"])
    args = parser.parse_args()
    N = int(args.N)
    v = int(args.v)
    if(v==1):
        seq1_len = 16
        seq2_len = 16
        prev_seq = ""
        first_flag = 1
        number_of_seq2 = N
        while True:
            if(N==0):
                first_flag = 1
                N = number_of_seq2
            seq_a, seq_b = generate_dna_pair(seq1_len, seq2_len,0.5)
            if(args.type=="2" and len(prev_seq) and (first_flag == 0)):
                seq_a = prev_seq
            else:
                prev_seq = seq_a
            sw_time_start = time.perf_counter()
            results = smith_waterman_impl(
                seq1=seq_a,
                seq2=seq_b,
                match=2,
                mismatch=-1,
                alpha=-2,
                beta=-1
            )
            sw_time_stop = time.perf_counter()
            # print("Seq A: ", seq_a)
            # print("Seq B: ", seq_b)

            print(f"\nLocal Alignment Score: {results['max_alignment_score']} and software time {sw_time_stop-sw_time_start}")
            for idx, align in enumerate(results["aligned_sequences"], 1):
                a1 = align["seq1_align"]
                a2 = align["seq2_align"]
                match_bar = "".join("|" if c1 == c2 else " " for c1, c2 in zip(a1, a2))
                print(f"  Seq 1: {a1}")
                print(f"  Match: {match_bar}")
                print(f"  Seq 2: {a2}")
            if(first_flag):
                encoded_seq_a_arr = seq_to_arr_string_list(seq_a[len(seq_a)::-1])
            encoded_seq_b_arr = seq_to_arr_string_list(seq_b) #reversing the string of seq_b before encoding and generating bit patterns
            # print(encoded_seq_a_arr)
            # print(encoded_seq_b_arr)
            if(first_flag):
                seq_a_bit_pattern = seq2bit_pattern(encoded_seq_a_arr,"s")
            seq_b_bit_pattern = seq2bit_pattern(encoded_seq_b_arr,"t")
            # print(f"{seq_a_bit_pattern}")
            # print(seq_b_bit_pattern)

            port_name = "/dev/ttyUSB1"

            score = send_and_read_bit_patterns(port=port_name, seq_1=seq_a_bit_pattern, seq_2=seq_b_bit_pattern, type=args.type, first_flag = first_flag, baudrate=115200)
            if (results['max_alignment_score'] == score):
                print("\033[32mAlignment Matched\033[0m")
            else:
                print(f"\033[31mAlignment Mismatched. Received: {score}, Expected: {results['max_alignment_score']}\033[0m")
            print("\n######################\n")
            if(args.type=="2"):
                first_flag = 0
            N=N-1
            time.sleep(1)
    else: # multi threaded version
        tx_seq_queue = queue.Queue()
        comp_queue = queue.Queue()
        time_queue = queue.Queue()
        stop_event = threading.Event()
        port ="/dev/ttyUSB1"
        with serial.Serial(port, baudrate = 115200, timeout=0.1) as ser:
            ser.reset_input_buffer()
            ser.reset_output_buffer()
            seq1_len = 64
            seq2_len = 32
            prev_seq = ""
            first_flag = 1
            number_of_seq2 = N

            rx_thread = threading.Thread(
            target=rx_worker, args=(ser,comp_queue, time_queue,  stop_event), daemon=True
            )
            tx_thread = threading.Thread(
                target=tx_worker, args=(ser,tx_seq_queue,time_queue, stop_event), daemon=True
            )
            rx_thread.start()
            tx_thread.start()
            while True:
                if(N==0):
                    first_flag = 1
                    N = number_of_seq2
                seq_a, seq_b = generate_dna_pair(seq1_len, seq2_len,0.5)
                if(args.type=="2" and len(prev_seq) and (first_flag == 0)):
                    seq_a = prev_seq
                else:
                    prev_seq = seq_a
                sw_time_start = time.perf_counter()
                results = smith_waterman_impl(
                    seq1=seq_a,
                    seq2=seq_b,
                    match=2,
                    mismatch=-1,
                    alpha=-2,
                    beta=-1
                )
                sw_time_stop = time.perf_counter()
                # print("Seq A: ", seq_a)
                # print("Seq B: ", seq_b)

                print(f"\nLocal Alignment Score: {results['max_alignment_score']}\n")
                # for idx, align in enumerate(results["aligned_sequences"], 1):
                #     a1 = align["seq1_align"]
                #     a2 = align["seq2_align"]
                #     match_bar = "".join("|" if c1 == c2 else " " for c1, c2 in zip(a1, a2))
                #     print(f"  Seq 1: {a1}")
                #     print(f"  Match: {match_bar}")
                #     print(f"  Seq 2: {a2}")
                if(first_flag):
                    encoded_seq_a_arr = seq_to_arr_string_list(seq_a[len(seq_a)::-1])
                encoded_seq_b_arr = seq_to_arr_string_list(seq_b) #reversing the string of seq_b before encoding and generating bit patterns
                seq_b_bit_pattern = seq2bit_pattern(encoded_seq_b_arr,"t")
                if(first_flag):
                    seq_a_bit_pattern = seq2bit_pattern(encoded_seq_a_arr,"s")
                else:
                    seq_a_bit_pattern = " "
                tx_seq_queue.put((seq_b_bit_pattern, seq_a_bit_pattern))
                comp_queue.put((results['max_alignment_score'], sw_time_stop-sw_time_start))
                print("Seq B: ", seq_b_bit_pattern)
                print("Seq A: ", seq_a_bit_pattern)
                # if (results['max_alignment_score'] == score):
                #     print("\033[32mAlignment Matched\033[0m")
                # else:
                #     print("\033[31mAlignment Mismatched\033[0m")
                print("\n######################\n")
                if(args.type=="2"):
                    first_flag = 0
                N=N-1
                if(stop_event.is_set()):
                    break
                # time.sleep(2)
