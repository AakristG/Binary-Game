# CS2340 Term Project
# Author: Aakrist Godar
# Date: 10/24/2025
# Description: This file handles all game features that has to do with numbers

.text
    initate_questioning:
        li $t1, 1
        li $t2, 2
        addi $sp, $sp, -12
        sw   $ra, 8($sp)
        sw   $a1, 4($sp)
        sw   $a2, 0($sp)

        beq  $a0, $t1, binary_to_decimal
        beq  $a0, $t2, decimal_to_binary
        j  restore

    decimal_to_binary:
        jal print_header_decimal


        lw $a0, 4($sp)  
        li $v0, SysPrintInt
        syscall

        li $v0, SysPrintString
        la $a0, tabs
        syscall

        jal print_footer_decimal
        jal input_binary
        j restore

    binary_to_decimal:
        jal print_header_binary

        lw $a0, 0($sp)            # binary string address
        jal store_in_board        # formats and prints the binary visually

        jal print_footer_binary
        jal input_decimal
        j restore

    restore:
        lw $a2, 0($sp)
        lw   $a1, 4($sp)
        lw   $ra, 8($sp)
        addi $sp, $sp, 12
        jr   $ra

    input_decimal:
        addi $sp, $sp, -4
        sw   $ra, 0($sp)

        li   $v0, SysPrintString
        la   $a0, dec_prompt
        syscall

        li $v0, SysReadInt
        syscall
        move $a1, $v0

        lw   $a0, 8($sp)       
        jal  verify_decimal
        
        move $t0, $v1  

        lw   $ra, 0($sp)
        addi $sp, $sp, 4
        jr   $ra

    input_binary:
        addi $sp, $sp, -4
        sw   $ra, 0($sp)

        li   $v0, SysPrintString
        la   $a0, bin_prompt
        syscall

        li   $v0, SysReadString
        la   $a0, user_input
        li   $a1, 32
        syscall

        lw   $a0, 4($sp)              # correct binary address
        jal  verify_binary

        move $t0, $v1  

        lw   $ra, 0($sp)
        addi $sp, $sp, 4
        jr   $ra

