.include "SysCalls.asm"

d_to_b_mode:
    li $a0, 0
    li $a1, 256
    li $v0, SysRandIntRange
    syscall
    move $t0, $v0

    la $a0, lvl_msg
    jal print_string
    move $a0, $t0
    jal print_int
    la $a0, newline
    jal print_string

    la $a0, binary
    jal print_string

    la $a0, bin_str
    li $a1, 9
    li $v0, SysReadString
    syscall

    la $a0, user_binary
    jal convert_to_int
    move $t1, $v0

    beq $t0, $t1, dec_to_bin
    la $a0, incorrect
    jal print_string
    move $a0, $t0
    jal print_int
    jr $ra

dec_to_bin:
    la $a0, correct
    jal print_string

convert_to_int:
    move $t0, $a0
    li $v0, 0

loop:
    lb $t1, 0($t0)
    beqz $t1, done
    sll $v0, $v0, 1
    addi $t1, $t1, -48
    or $v0,  $v0, $t1
    addi $t0, $t0, 1
    b loop

done:
    jr $ra
