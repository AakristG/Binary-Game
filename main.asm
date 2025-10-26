# CS2340 Term Project
# Author: Aakrist Godar
# Date: 10/24/2025
# Description: This file is the main class which runs the entire project

.include "SysCalls.asm"           # include system call definitions
.include "data.asm"               # include data section containing strings and variables

.text
	.globl main                   # declare main label as global entry point
	
	main: 
		li $v0, SysPrintString     # load print string syscall
		la $a0, hor_border         # load horizontal border address
		syscall                    # print border

		li $v0, SysPrintString     # load print string syscall
		la $a0, welcome            # load welcome message
		syscall                    # print welcome message

		li $v0, SysPrintString     # load print string syscall
		la $a0, menu               # load menu string
		syscall                    # print menu

		li $v0, SysPrintString     # load print string syscall
		la $a0, hor_border         # load horizontal border again
		syscall                    # print border

		li $t1, 1                  # initialize current level = 1
		li $t2, 11                 # set level limit (level 10 + 1)

	press_enter:
		li $v0, SysReadString      # syscall to read user input
		la $a0, buffer             # load buffer address
		li $a1, 2                  # read 2 characters max (for Enter)
		syscall                    # wait for user to press Enter

		j game_loop                # jump to game loop

	game_loop:
		sub $t3, $t1, $t2          # compute t1 - t2
		beqz $t3, end              # if result == 0, all levels done → end game

		addi $sp, $sp, -8          # allocate 8 bytes on stack
		sw $t1, 4($sp)             # store current level
		sw $t2, 0($sp)             # store level limit

		move $a1, $t1              # move current level to argument register
		jal current_level          # call procedure to print level info

		lw $t1, 4($sp)             # restore t1 (level number)
		move $t5, $t1              # set question counter = current level

	questions_loop:
		beqz $t5, finish_loop      # if no questions left, go to finish_loop

		addi $sp, $sp, -12         # allocate 12 bytes for local variables
		sw $t5, 8($sp)             # store remaining question count

		jal start_binary_process   # generate random binary and its decimal form

		sw $v0, 4($sp)             # save decimal value
		sw $v1, 0($sp)             # save binary string
		move $s0, $v1              # copy binary string address to s0

		li $a0, 0                  # lower bound for random mode
		li $a1, 2                  # upper bound (exclusive)
		li $v0, SysRandIntRange    # syscall for random integer
		syscall                    # generate random integer
		addi $a0, $a0, 1           # mode = 1 or 2

		lw $a1, 4($sp)             # load decimal value
		lw $a2, 0($sp)             # load binary string
		jal initate_questioning     # call to ask question based on mode
		move $s1, $t0              # store correctness flag (1 = correct)

		li $v0, SysPrintString     # syscall to print string
		la $a0, newline            # print newline
		syscall                    # run syscall

		beqz $s1, game_over        # if incorrect, go to game_over

		lw $t5, 8($sp)             # restore question counter
		addi $sp, $sp, 12          # free stack space
		addi $t5, $t5, -1          # decrement remaining questions
		j questions_loop           # repeat until all questions done

	finish_loop:
		lw $t2, 0($sp)             # restore level limit
		lw $t1, 4($sp)             # restore current level
		addi $sp, $sp, 8           # restore stack space

		addi $t1, $t1, 1           # increment level
		j game_loop                # repeat for next level

	game_over:
		li $v0, SysPrintString     # syscall to print string
		la $a0, lose_msg           # load lose message
		syscall                    # print lose message
		
		li $v0, SysExit            # syscall to exit
		syscall                    # terminate program
		
	end:
		li $v0, SysPrintString     # syscall to print string
		la $a0, game_win           # load win message
		syscall                    # print win message
		
		li $v0, SysExit            # syscall to exit
		syscall                    # terminate program

	current_level:
		li $v0, SysPrintString     # syscall to print string
		la $a0, hor_border         # print horizontal border
		syscall                    # run syscall

		li $v0, SysPrintString     # syscall to print string
		la $a0, lvl_msg            # print level message
		syscall                    # run syscall

		li $v0, SysPrintString     # syscall to print string
		la $a0, newline            # print newline
		syscall                    # run syscall

		li $v0, SysPrintString     # syscall to print string
		la $a0, hor_border         # print horizontal border
		syscall                    # run syscall

		jr $ra                     # return to caller

.include "numbers.asm"            # include number generation and conversion logic
.include "user.asm"               # include question logic and input handling
.include "utils.asm"              # include validation and feedback functions
.include "display.asm"            # include display and board printing functions
