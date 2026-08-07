import random
import os
import argparse


global seq_a
def random_dna_sequence(len: int):
    base = ['A', 'C', 'G', 'T'] # DNA bases
    return ''.join(random.choices(base, k=len))


def seq_to_arr_string(dna_str: str):
    encoding = { # encode macros from macros.svh
        'A': '100',
        'C': '101',
        'G': '110',
        'T': '111',
        'a': '100',
        'c': '101',
        'g': '110',
        't': '111'
    }
    encoded_list = []
    for base in dna_str:
        if base in encoding:
            encoded_list.append(encoding[base])
    return "[" + ",".join(encoded_list) + "]"    
    
def seq_to_arr_string_list(dna_str: str):
    encoding = { # encode macros from macros.svh
        'A': '100',
        'C': '101',
        'G': '110',
        'T': '111',
        'a': '100',
        'c': '101',
        'g': '110',
        't': '111'
    }
    encoded_list = []
    for base in dna_str:
        if base in encoding:
            encoded_list.append(encoding[base])
    return encoded_list

def save_sequences(seq_a: str, seq_b: str, file1="seq1.txt", file2="seq2.txt"):
    encoded_a = seq_to_arr_string(seq_a)
    encoded_b = seq_to_arr_string(seq_b)
    op_dir = "output"
    os.makedirs(op_dir, exist_ok=True)
    with open(op_dir+"/"+file1, "a") as f1:
        f1.write(encoded_a)
        f1.write("\n")
        
    with open(op_dir+"/"+file2, "a") as f2:
        f2.write(encoded_b)
        f2.write("\n")

def generate_dna_pair(seqa_len: int, seqb_len: int, mutation_rate: float = 0.0) -> tuple[str, str]:
    global seq_a
    if mutation_rate <= 0.0:
        if(seqa_len<=0):
            return seq_a, random_dna_sequence(seqb_len)
        else:
            return random_dna_sequence(seqa_len), random_dna_sequence(seqb_len)
    
    if(seqa_len):
        seq_a = random_dna_sequence(seqa_len)
    bases = ['A', 'C', 'G', 'T']
    seq_b_list = list(seq_a) #copy seq to seqb for mutation (string to list conversion)
    
    num_mutations = int(len(seq_a) * mutation_rate)
    # print("The number of mutation is ",num_mutations )
    selected_idx = []
    for _ in range(num_mutations):
        #radomly select to either delete, insert new seq or replace
        mutation_type = random.choice(['replace', 'insert', 'delete'])

        idx = random.randint(0, len(seq_b_list) - 1)
        while idx in selected_idx:
            idx = random.randint(0, len(seq_b_list)-1)
        selected_idx.append(idx) # this makes sure no two same index are selected again 
        if mutation_type == 'replace':
            current_base = seq_b_list[idx]
            other_bases = [base for base in bases if base != current_base]
            seq_b_list[idx] = random.choice(other_bases)
            
        elif mutation_type == 'insert':
            seq_b_list.insert(idx, random.choice(bases)) #randomly select base to insert
            
        elif mutation_type == 'delete':
            if len(seq_b_list) > 1:
                seq_b_list.pop(idx) # remove it from the base

        seq_b = "".join(seq_b_list)
        if len(seq_b) < seqb_len: # with too much deletion, len might be shorter then requested
            seq_b += random_dna_sequence(abs(seqb_len - len(seq_b)))
        elif len(seq_b) > seqb_len: # with too much deletion, len might be longer then requested
            seq_b = seq_b[:seqb_len]
    return seq_a, seq_b

def smith_waterman_impl(seq1, seq2, match=2, mismatch=-1, alpha=-2, beta=-1):
    #alpha is the gap penalty(for first gap) but beta is gap extension penalty
    seq_a_len = len(seq1)
    seq_b_len = len(seq2)

    #H matrix as score matrix 
    H = [[0]*(seq_b_len+1) for _ in range(seq_a_len+1)] # extra row and column is added in the beginning and initialized to zero. But here all the items to 0

    max_alignment_score = 0
    max_i_j = [] # opt for back trace to keep where the highest index is located

    NEG_INF = float('-inf')

    # Horizontal_gap(i,j) =  max(H(i,j-1)+alpha, Horizontal_gap(i,j-1)+beta) # either we open the new gap from H or we extend the gap from horizontal gap
    Horizontal_gap = [[NEG_INF] * (seq_b_len + 1) for _ in range(seq_a_len + 1)]
    
    # Vertical_gap(i,j) =  max(H(i-1,j)+alpha, vertical_gap(i-1,j)+beta) # either we open the new gap from H or we extend the gap from vertical gap
    Vertical_gap = [[NEG_INF] * (seq_b_len + 1) for _ in range(seq_a_len + 1)]

    for i in range(1, seq_a_len+1): # we index the matrix from 1 as first index is always zero in the matrix
        for j in range(1, seq_b_len+1):
            score = match if seq1[i - 1] == seq2[j - 1] else mismatch # seq is index from 0, but i and j are H indexes

            prev_best_diag = max(H[i - 1][j - 1], Horizontal_gap[i - 1][j - 1], Vertical_gap[i - 1][j - 1]) # we are starting to check now from the previous best match state

            H[i][j] = max(0, score + prev_best_diag)

            Horizontal_gap[i][j] = max(H[i][j - 1] + alpha, Vertical_gap[i][j - 1] + alpha, Horizontal_gap[i][j - 1] + beta ) # starting new horizontal gap either from diag or vertical or extending the old gap from horizontal
            
            Vertical_gap[i][j] = max(H[i - 1][j] + alpha, Horizontal_gap[i - 1][j] + alpha, Vertical_gap[i - 1][j] + beta )

            cell_score = max(0, H[i][j], Horizontal_gap[i][j], Vertical_gap[i][j]) # main algorithm 

            if cell_score > max_alignment_score:
                max_alignment_score = cell_score
                max_i_j = [(i, j)] # storing loc of  max score in matrix
            elif cell_score == max_alignment_score and cell_score > 0:
                max_i_j.append((i, j))
        
    # Back trace Implementation
    aligned_sequences = []
    for pos in max_i_j:
        i, j = pos
        seq1_align, seq2_align = "", ""
        while i > 0 and j > 0 and max(H[i][j], Horizontal_gap[i][j], Vertical_gap[i][j]) > 0:
            curr_align_score = max(H[i][j], Horizontal_gap[i][j], Vertical_gap[i][j])
            score = match if seq1[i - 1] == seq2[j - 1] else mismatch
            if curr_align_score == H[i][j]: # or curr_align_score == H[i - 1][j - 1] + score
                seq1_align = seq1[i - 1] + seq1_align
                seq2_align = seq2[j - 1] + seq2_align
                i -= 1 #here we have diagonal match, so we move diagonally
                j -= 1
            elif (curr_align_score == Horizontal_gap[i][j]): # check how we reached here, either from 
                seq1_align ="-" + seq1_align
                seq2_align = seq2[j - 1] + seq2_align
                j -= 1 #here is mismatch and there is gap and we move horizontally. While doing so, we add are checking the same character in seq 1 against the next character in seq2
            else: #curr_align_score == Vertical_gap[i][j]
                seq1_align = seq1[i - 1] + seq1_align
                seq2_align = "-" + seq2_align
                i -= 1
        
        aligned_sequences.append({
            "seq1_align": seq1_align,
            "seq2_align": seq2_align,
        })

    return {
        "max_alignment_score": max_alignment_score,
        "aligned_sequences": aligned_sequences
    }

def generate_seq(prev_seq_a):
    if(not len(prev_seq_a)):
         seq1_len = 16
    else:
        seq1_len = 0
    seq2_len = 16
    seq_a, seq_b = generate_dna_pair(seq1_len, seq2_len,0.5)
    if(len(prev_seq_a)):
         seq_a = prev_seq_a
    # seq_a = "ATGGTGTCCCGTGTGGGGGGCGGTAGGTCGCCACTCTACAACAACCACGAGACAGGTAGGATTC"
    # seq_b = "ATGGGATCGGGTGGGGAGGCATGGTCGAGTGC"
    print("Seq1 :  ", seq_a)
    print("Seq2 :  ", seq_b)
    save_sequences(seq_a, seq_b)
    results = smith_waterman_impl(
        seq1=seq_a, 
        seq2=seq_b, 
        match=2, 
        mismatch=-1, 
        alpha=-2, 
        beta=-1
    )
    print(f"\nLocal Alignment Score: {results['max_alignment_score']}")
    
    for idx, align in enumerate(results["aligned_sequences"], 1):
        a1 = align["seq1_align"]
        a2 = align["seq2_align"]
        match_bar = "".join("|" if c1 == c2 else " " for c1, c2 in zip(a1, a2))
        print(f"  Seq 1: {a1}")
        print(f"  Match: {match_bar}")
        print(f"  Seq 2: {a2}")
	
    with open("output/final_op.txt", "a") as f1:
        f1.write(f"{results['max_alignment_score']}")
        f1.write("\n")
    return seq_a

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="--type 1/2 --N 5")
    parser.add_argument("--type", type=str, help="one or two")
    parser.add_argument("--N", help="Numeric values for number of string paterns")
    args = parser.parse_args()
    N = int(args.N)
    fixed_Seq = ""
    type1 = args.type == "1"
    if os.path.exists("output/seq1.txt"):
        os.remove("output/seq1.txt")
    if os.path.exists("output/seq2.txt"):
        os.remove("output/seq2.txt")
    if os.path.exists("output/final_op.txt"):
        os.remove("output/final_op.txt")
    for _ in range(0,N):
        if(type1):
            fixed_Seq = generate_seq(fixed_Seq)
        else:
            generate_seq(fixed_Seq)
