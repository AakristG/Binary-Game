# CS2340 Term Project
# Author: Aakrist Godar
# Date: 10/24/2025
# Description: This file is the main class which runs the entire project

.include "SysCalls.asm"
.include "data.asm"

.text
	.globl main
	
	main: 
		li $v0, SysPrintString	# print the string 
		la $a0, hor_border # load the address of the horizontal border
		syscall	# run the syscall

		li $v0, SysPrintString # print the string
		la $a0, welcome # load address of welcome 
		syscall # run the syscall

		li $v0, SysPrintString
		la $a0, menu
		syscall

		li $v0, SysPrintString
		la $a0, hor_border
		syscall

		li $t1, 1
		li $t2, 11

	press_enter:
		# wait for Enter key press
		li $v0, SysReadString
		la $a0, buffer
		li $a1, 2              # only need to read up to newline
		syscall

		j game_loop

	game_loop:
		sub $t3, $t1, $t2
		beqz $t3, end # if $t1 != $t2 then go to end

		addi $sp, $sp, -8 # allocating 8 bytes
		sw $t1, 4($sp)	# store value of $t2 in sp
		sw $t2, 0($sp)	# store value of $t2 in sp

		move $a1, $t1
		jal current_level

		lw $t1, 4($sp) 
		move $t5, $t1

		
	questions_loop:
		beqz $t5, finish_loop

		addi $sp, $sp, -12 # allocate 12 bytes of stack space
		sw $t5, 8($sp)

		jal start_binary_process

		sw $v0, 4($sp)
		sw $v1, 0($sp)

		move $s0, $v1

		li $a0, 0
		li $a1, 2
		li $v0, SysRandIntRange
		syscall
		addi $a0, $a0, 1  # mode = 1 or 2


		lw $a1, 4($sp)
		lw $a2, 0($sp)

		jal initate_questioning
		move $s1, $t0    # correctness flag

		li $v0, SysPrintString
		la $a0, newline
		syscall

		beqz $s1, game_over

		lw $t5, 8($sp)    # restore the value of $t5 at byte location 8
		addi $sp, $sp, 12 # restore the storage
		addi $t5, $t5, -1 # decrement the counter 
		
		j questions_loop  # run the loop again until beqz is triggered

	finish_loop:
		lw $t2, 0($sp)	# load value of t2 at 0 offset
		lw $t1, 4($sp)	# load value of t1 at 4 offset
		addi $sp, $sp, 8	# saves the stack storage  

		addi $t1, $t1, 1	# adds one to the level
		j game_loop		# jumps back to game loop which keeps track of levels

	game_over:
		li $v0, SysPrintString # syscall method to print string
		la $a0, lose_msg # load address of game_win string 
		syscall	# run the system call
		
		li $v0, SysExit # syscall method to exit
		syscall	# run the syscall
		
	end:
		li $v0, SysPrintString # syscall method to print string
		la $a0, game_win # load address of game_win string 
		syscall	# run the system call
		
		li $v0, SysExit # syscall method to exit
		syscall	# run the syscall

	current_level:
		li $v0, SysPrintString
		la $a0, hor_border
		syscall

		li $v0, SysPrintString
		la $a0, lvl_msg
		syscall

		li $v0, SysPrintString
		la $a0, newline
		syscall

		li $v0, SysPrintString
		la $a0, hor_border
		syscall

		jr $ra



# I could have branched out to the main method skipping all the imports but this is easier and legal
.include "numbers.asm"
.include "user.asm"
.include "utils.asm"
.include "display.asm"
