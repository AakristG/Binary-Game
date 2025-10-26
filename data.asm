# CS2340 Term Project
# Author: Aakrist Godar
# Date: 1024/2025
# Description: This file contains all data for the program

.data
    # normal displays
    welcome:    .asciiz "|\t\t\tWELCOME TO THE BINARY GAME (MIPS)\t\t\t\t\t\t\t\t\t|\n"   # welcome message
    menu:       .asciiz "|\t\t\t\tPress ENTER to start the game\t\t\t\t\t\t\t\t\t|\n"   # start prompt
    newline:    .asciiz "\n"                                                                # newline character
    binary:     .asciiz "|Convert this binary to decimal: \t\t\t\t\t\t\t\t\t\t\t\t|\n"     # binary question text
    decimal:    .asciiz "|Convert this decimal to binary: "                                 # decimal question text
    correct:    .asciiz "\nRight answer!!\n"                                                # correct answer message
    incorrect:  .asciiz "\nWrong answer. The correct answer was:\t "                        # incorrect answer message
    lvl_msg:    .asciiz "|\t\t\t--- WELCOME TO THIS LEVEL -----\t\t\t\t\t\t\t\t\t\t|"      # level message
    lose_msg:   .asciiz "\n------- GAME OVER! You failed at this Level "                    # game over message
    game_win:   .asciiz "\n*** CONGRATULATIONS! You have mastered Level 10! ***\n"          # final win message
    bin_prompt: .asciiz "Enter the answer (8 bits no spaces): "                             # binary input prompt
    dec_prompt: .asciiz "Enter the answer (no spaces): "                                    # decimal input prompt
    next_lvl:   .asciiz "Proceeding to next level... \n"                                    # next level message

    # graphics
    tabs:       .asciiz "\t\t\t\t\t\t\t\t\t\t\t\t|"                                        # tab spacing
    decimalBox: .asciiz "+- - - - - - - - - - - - - - - -+\n"                              # decorative box
    line:	    .asciiz "|\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t|\n"                             # line separator
    hor_border: .asciiz "+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+\n"  # horizontal border
    empty_box:  .asciiz "|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|"               # empty board template

    # space allocation
    buffer:     .space 2           # buffer for small input (like ENTER)
    bin_str:    .space 10          # stores generated binary string
    user_input: .space 32          # stores user input string
    board_str:  .space 80          # stores visual binary board
