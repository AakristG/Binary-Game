# CS2340 Term Project
# Author: Aakrist Godar
# Date: 10/24/2025
# Description: This file handles all utils that are used in the project

verify_binary:
    addi $sp, $sp, -8          # allocate 8 bytes on stack
    sw   $ra, 0($sp)           # save return address
    sw   $a0, 4($sp)           # save argument a0 (correct binary)

    move $t0, $a0              # move correct binary string to t0
    la   $t1, user_input       # load user input string address to t1

binary_loop:
    lb $t2, 0($t0)             # load byte from correct binary
    lb $t3, 0($t1)             # load byte from user input

    beqz $t2, binary_end       # if correct string ended, go to binary_end
    bne $t2, $t3, binary_wrong # if mismatch, go to binary_wrong

    addi $t0, $t0, 1           # move to next char in correct string
    addi $t1, $t1, 1           # move to next char in user input
    j binary_loop              # repeat loop

binary_end:
    beq  $t3, 10, binary_right # if user input ends with newline, correct
    beqz $t3, binary_right     # if null terminator, correct
    j    binary_wrong          # otherwise wrong

binary_right:  
    li $v1, 1                  # set v1 = 1 (correct)
    jal print_correct          # call print_correct
    j binary_finished          # jump to finish

binary_wrong:
    li $v1, 0                  # set v1 = 0 (incorrect)
    jal print_incorrect        # call print_incorrect
    lw $a0, 4($sp)             # load correct binary to a0
    li $v0, SysPrintString     # syscall to print string
    syscall                    # print correct answer

    li   $v0, SysPrintString   # syscall to print string
    la   $a0, newline          # load newline
    syscall                    # print newline

binary_finished:
    lw   $ra, 0($sp)           # restore return address
    addi $sp, $sp, 8           # restore stack
    jr   $ra                   # return

verify_decimal:
    addi $sp, $sp, -8          # allocate 8 bytes on stack
    sw   $ra, 0($sp)           # save return address
    sw   $a0, 4($sp)           # save argument a0 (correct decimal)

    beq  $a0, $a1, decimal_right # if equal, correct
    j    decimal_wrong          # otherwise wrong

decimal_right:
    li $v1, 1                  # set v1 = 1 (correct)
    jal  print_correct          # call print_correct
    j    decimal_done           # jump to done

decimal_wrong:
    li $v1, 0                  # set v1 = 0 (incorrect)
    jal  print_incorrect        # call print_incorrect

    lw   $a0, 4($sp)           # load correct decimal value
    li   $v0, SysPrintInt      # syscall to print integer
    syscall                    # print correct integer

    li   $v0, SysPrintString   # syscall to print string
    la   $a0, newline          # load newline
    syscall                    # print newline

decimal_done:
    lw   $ra, 0($sp)           # restore return address
    addi $sp, $sp, 8           # restore stack
    jr   $ra                   # return

print_correct:
    li   $v0, SysPrintString   # syscall to print string
    la   $a0, correct          # load correct message
    syscall                    # print correct message
    jr   $ra                   # return

print_incorrect:
    li   $v0, SysPrintString   # syscall to print string
    la   $a0, incorrect        # load incorrect message
    syscall                    # print incorrect message
    jr   $ra                   # return
