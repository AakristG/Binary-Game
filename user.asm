# CS2340 Term Project
# Author: Aakrist Godar
# Date: 10/24/2025
# Description: This file handles all game features that has to do with numbers

.text
    initate_questioning:
        li $t1, 1                 # load immediate 1 into t1
        li $t2, 2                 # load immediate 2 into t2
        addi $sp, $sp, -12        # allocate 12 bytes on stack
        sw   $ra, 8($sp)          # save return address
        sw   $a1, 4($sp)          # save a1 (decimal)
        sw   $a2, 0($sp)          # save a2 (binary string)

        beq  $a0, $t1, binary_to_decimal # if a0 == 1, jump to binary_to_decimal
        beq  $a0, $t2, decimal_to_binary # if a0 == 2, jump to decimal_to_binary
        j  restore                # otherwise restore and return

    decimal_to_binary:
        jal print_header_decimal  # call to print header for decimal question

        lw $a0, 4($sp)            # load decimal value
        li $v0, SysPrintInt       # syscall to print integer
        syscall                   # print decimal number

        li $v0, SysPrintString    # syscall to print string
        la $a0, tabs              # load tab spacing
        syscall                   # print tabs

        jal print_footer_decimal  # print footer
        jal input_binary          # call to input_binary
        j restore                 # jump to restore section

    binary_to_decimal:
        jal print_header_binary   # call to print binary header

        lw $a0, 0($sp)            # load binary string address
        jal store_in_board         # call to visually display binary

        jal print_footer_binary   # print footer
        jal input_decimal         # call input_decimal
        j restore                 # jump to restore

    restore:
        lw $a2, 0($sp)            # restore a2 (binary)
        lw $a1, 4($sp)            # restore a1 (decimal)
        lw $ra, 8($sp)            # restore return address
        addi $sp, $sp, 12         # restore stack pointer
        jr $ra                    # return to caller

    input_decimal:
        addi $sp, $sp, -4         # allocate 4 bytes on stack
        sw   $ra, 0($sp)          # save return address

        li   $v0, SysPrintString  # syscall to print string
        la   $a0, dec_prompt      # load decimal prompt
        syscall                   # print prompt

        li $v0, SysReadInt        # syscall to read integer
        syscall                   # read input from user
        move $a1, $v0             # move input to a1

        lw   $a0, 8($sp)          # load correct decimal from stack
        jal  verify_decimal       # call verify_decimal
        
        move $t0, $v1             # store result in t0 (correctness flag)

        lw   $ra, 0($sp)          # restore return address
        addi $sp, $sp, 4          # restore stack pointer
        jr   $ra                  # return

    input_binary:
        addi $sp, $sp, -4         # allocate 4 bytes on stack
        sw   $ra, 0($sp)          # save return address

        li   $v0, SysPrintString  # syscall to print string
        la   $a0, bin_prompt      # load binary prompt
        syscall                   # print prompt

        li   $v0, SysReadString   # syscall to read string
        la   $a0, user_input      # load address of user input buffer
        li   $a1, 32              # max length 32
        syscall                   # read binary input

        lw   $a0, 4($sp)          # load correct binary address
        jal  verify_binary        # call verify_binary

        move $t0, $v1             # store result in t0 (correctness flag)

        lw   $ra, 0($sp)          # restore return address
        addi $sp, $sp, 4          # restore stack pointer
        jr   $ra                  # return
