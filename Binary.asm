# Header: Binary Game in MIPS
# Author: Aakrist Godar
# Date: Nov-18-2025
# Description: An interactive game where the user can practice their binary to decimal converstion or decimal to binary converstion

.include "SysCalls.asm"

.data
    welcome:    .asciiz "=== WELCOME TO THE BINARY GAME (MIPS) ===\n"
    menu:       .asciiz "Press ENTER to start the game"
    newline:    .asciiz "\n"
    binary:     .asciiz "Convert this binary to decimal"
    decimal:    .asciiz "Convert this decimal to binary"
    incorrect:  .asciiz "Wrong answer. The correct answer was: "
    score:      .asciiz "\n Your total score is: "
    seperation: .asciiz "\n------------------------------\n"
    mode_pick:  .asciiz "Pick your mode:\n Mode 1: Binary to Decimal\n Mode 2: Decimal to Binary\n"
    hor_border: .asciiz "+---+---+---+---+---+---+---+---+---+\n"
    ver_border: .asciiz "|\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n|"
    empty_box:  .asciiz "|   |   |   |   |   |   |   |   |   |"
    lvl_msg:    .asciiz "\nLevel "
    inv_mode:   .asciiz "Invalid mode. Please enter 1 or 2.\n"
    end:        .asciiz "End of the game\n"



.text


.main
    li $v0, SysPrintString # call the print string syscall
    la $a0, welcome # load address of the welcome message
    syscall # print the welcome

    li $v0, SysPrintString # call the print string syscall
    la $a0, menu # load address of the menu message
    syscall # print the menu

    li $t0, 0 # score variable
    li $t1, 1 # level variable

startGame:
    li $v0, SysPrintString
    la $a0, mode_pick

    li $v0, SysReadInt
    li $a0, 1
    li $a1, 2
    syscall
    move $t2, $v0

   beq $t2, 1, mode_binary_to_decimal
   beq $t2, 2, mode_decimal_to_binary


loop_level:
    bgt $t1, 10, endGame # stops the game after 10 levels

    li $v0, SysPrintString
    la $a0, lvl_msg
    syscall

    li $v0, SysPrintInt
    move $a0, $t1
    syscall

    li $v0, SysPrintString
    la $a0, newline
    syscall

mode_binary_to_decimal:
    

mode_decimal_to_binary:


endGame:
    li $v0, SysPrintString
    la $a0, score
    la $a0, end
    syscall

    li $v0, SysPrintInt
    move $a0, $t0
    syscall

    li $v0, SysPrintString
    la $a0, newline
    syscall

    li $v0, SysExit
    syscall


    
