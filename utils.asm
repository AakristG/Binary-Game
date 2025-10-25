# CS2340 Term Project
# Author: Aakrist Godar
# Date: 10/24/2025
# Description: This file handles all utils that are used in the project

verify_binary:
    addi $sp, $sp, -8
    sw   $ra, 0($sp)
    sw   $a0, 4($sp)

    move $t0, $a0                # correct binary string
    la   $t1, user_input          # user's input

binary_loop:
    lb $t2, 0($t0)
    lb $t3, 0($t1)

    beqz $t2, binary_end
    bne $t2, $t3, binary_wrong

    addi $t0, $t0, 1
    addi $t1, $t1, 1
    j binary_loop

binary_end:
    beq  $t3, 10, binary_right
    beqz $t3, binary_right
    j    binary_wrong

binary_right:  
    li $v1, 1    
    jal print_correct
    j binary_finished

binary_wrong:
    li $v1, 0
    jal print_incorrect
    lw $a0, 4($sp)  
    li $v0, SysPrintString
    syscall

    li   $v0, SysPrintString
    la   $a0, newline
    syscall

binary_finished:
    lw   $ra, 0($sp)
    addi $sp, $sp, 8
    jr   $ra

verify_decimal:
    addi $sp, $sp, -8
    sw   $ra, 0($sp)
    sw   $a0, 4($sp)

    beq  $a0, $a1, decimal_right
    j    decimal_wrong

decimal_right:
    li $v1, 1
    jal  print_correct
    j    decimal_done

decimal_wrong:
    li $v1, 0
    jal  print_incorrect

    lw   $a0, 4($sp)       # print correct decimal
    li   $v0, SysPrintInt
    syscall

    li   $v0, SysPrintString
    la   $a0, newline
    syscall

decimal_done:
    lw   $ra, 0($sp)
    addi $sp, $sp, 8
    jr   $ra

print_correct:
    li   $v0, SysPrintString
    la   $a0, correct
    syscall
    jr   $ra

print_incorrect:
    li   $v0, SysPrintString
    la   $a0, incorrect
    syscall
    jr   $ra