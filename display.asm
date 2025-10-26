# CS2340 Term Project
# Author: Aakrist Godar
# Date: 10/24/2025
# Description: This file is all the display features of the program

.text

  print_header_decimal:
    li $v0, SysPrintString       # syscall to print string
    la $a0, newline              # load newline string
    syscall                      # print newline

    li $v0, SysPrintString       # syscall to print string
    la $a0, hor_border           # load horizontal border
    syscall                      # print horizontal border

    li $v0, SysPrintString       # syscall to print string
    la $a0, decimal              # load "convert decimal" text
    syscall                      # print decimal header

    jr $ra                       # return

  print_footer_decimal:
    li $v0, SysPrintString       # syscall to print string
    la $a0, newline              # load newline
    syscall                      # print newline

    li $v0, SysPrintString       # syscall to print string
    la $a0, hor_border           # load horizontal border
    syscall                      # print border
    jr $ra                       # return

  print_header_binary:
    li $v0, SysPrintString       # syscall to print string
    la $a0, newline              # load newline
    syscall                      # print newline

    li $v0, SysPrintString       # syscall to print string
    la $a0, hor_border           # load horizontal border
    syscall                      # print border

    li $v0, SysPrintString       # syscall to print string
    la $a0, binary               # load "convert binary" text
    syscall                      # print binary header

    li $v0, SysPrintString       # syscall to print string
    la $a0, line                 # load separator line
    syscall                      # print line

    li $v0, SysPrintString       # syscall to print string
    la $a0, hor_border           # load horizontal border
    syscall                      # print bottom border

    jr $ra                       # return

  print_footer_binary:
    li $v0, SysPrintString       # syscall to print string
    la $a0, hor_border           # load horizontal border
    syscall                      # print border
    jr $ra                       # return

  store_in_board:
    addi $sp, $sp, -4            # allocate 4 bytes on stack
    sw $ra, 0($sp)               # save return address

    move $t0, $a0                # t0 = binary string
    la $t1, empty_box            # load empty box template
    la $t2, board_str            # load board string address
    li $t3, 0                    # initialize counter

  copy_loop:
    lb $t4, 0($t1)               # load byte from empty_box
    sb $t4, 0($t2)               # store byte into board_str
    beqz $t4, copy_done          # stop at null terminator
    addi $t1, $t1, 1             # move to next byte in empty_box
    addi $t2, $t2, 1             # move to next byte in board_str
    j copy_loop                  # repeat copy

  copy_done:
    li $t3, 0                    # reset digit index
  insert_loop:
    beq  $t3, 8, print_board     # stop after 8 digits
    sll  $t4, $t3, 2             # offset = i * 4
    addi $t4, $t4, 2             # adjust to slot center
    lb $t5, 0($t0)               # load binary digit
    sb $t5, board_str($t4)       # place digit in correct board slot
    addi $t0, $t0, 1             # move to next digit
    addi $t3, $t3, 1             # increment counter
    j insert_loop                # repeat

  print_board:
    la $a0, board_str            # load board string
    li $v0, SysPrintString       # syscall to print string
    syscall                      # print board

    la $a0, newline              # load newline
    li $v0, SysPrintString       # syscall to print string
    syscall                      # print newline

    lw $ra, 0($sp)               # restore return address
    addi $sp, $sp, 4             # restore stack space
    jr $ra                       # return



  