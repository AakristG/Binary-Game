.include "SysCalls.asm"

b_to_d_mode:
    la $a0, decimal
    jal print_string


    li $a0, 0
    li $a1, 256 # load max 8 bit binary number
    li $v0, SysRandIntRange
    syscall
    move $t0, $v0 # store random number 

    # converting to binary
    la $a0, bin_str
    jal convert
    la $a0, bin_str
    jal board

    li $v0, SysReadInt
    syscall
    move $t1, $v0

    beq $t0, $t1, compare # compares input with the correct decimal

    # if the user gets wrong answer
    la $a0, incorrect
    jal print_string
    move $a0, $t0
    jal print_int
    jr $ra # TODO: might be error here

compare:
    la $a0, correct
    jal print_string


convert:
    addi $t2, $a0, 8
    li $t3, 8

loop:
    beqz $t3, null_term
    andi $t4, $t0, 1
    addi $t4, $t4, 48
    sb $t4, -1($t2)
    srl $t0, $t2, -1
    addi $t2, $t2, -1
    addi $t3, $t3, -1
    b loop # branch back to the loop

null_term:
    sb $zero, 8($a0)
    jr $ra
