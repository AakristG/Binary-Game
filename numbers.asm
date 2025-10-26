# CS2340 Term Project
# Author: Aakrist Godar
# Date: 10/24/2025
# Description: This file handles random numbers, generating binary, conversion to decimal

.text
	start_binary_process:
		addi $sp, $sp, -4          # allocate 4 bytes on stack
		sw $ra, 0($sp)             # save return address

		li $t0, 0                  # loop counter = 0
		li $t1, 8                  # total bits to generate = 8

	generation_loop:               # loop to generate 8 random bits
		beq $t0, $t1, binary_done  # if 8 bits generated, exit loop
		jal generateNumber         # call random number generator

		move $t6, $v0              # store random value (0 or 1) in t6
		
		beqz $t6, store_zero       # if 0, jump to store_zero
		li $t3, '1'                # ASCII value for '1'
		j store_bit                # jump to store_bit

	store_zero:
		li $t3, '0'                # ASCII value for '0'

	store_bit:
		la $t4, bin_str            # load base address of binary string
		add $t4, $t4, $t0          # move to correct bit position
		sb $t3, 0($t4)             # store ASCII bit at position

		addi $t0, $t0, 1           # increment bit counter
		j generation_loop           # repeat until done

	binary_done:
		la $t4, bin_str             # load binary string base address
		add $t4, $t4, $t0           # move to null terminator position
		sb $zero, 0($t4)            # store null terminator

		la $a0, bin_str             # load binary string address
		jal convert_to_decimal      # convert binary to decimal
		la $v1, bin_str             # store binary string address in v1

		lw $ra, 0($sp)              # restore return address
		addi $sp, $sp, 4            # restore stack space
		jr $ra                      # return

	generateNumber:
		addi $sp, $sp, -4           # allocate 4 bytes on stack
		sw $ra, 0($sp)              # save return address

		li $a0, 0                   # lower bound for random range
		li $a1, 2                   # upper bound for random range
		li $v0, SysRandIntRange     # syscall for random integer in range
		syscall                     # execute syscall
		
		move $v0, $a0               # move random result to v0

		lw $ra, 0($sp)              # restore return address
		addi $sp, $sp, 4            # restore stack pointer
		jr $ra                      # return to caller

	convert_to_decimal:
		addi $sp, $sp, -12          # allocate 12 bytes on stack
		sw $ra, 8($sp)              # save return address
		sw $s0, 4($sp)              # save s0
		sw $s1, 0($sp)              # save s1

		move $s0, $a0               # store binary string address in s0
		li $s1, 0                   # decimal result accumulator = 0
		li $t0, 0                   # loop counter = 0
	
	decimal_conversion_loop:
		beq $t0, 8, conversion_done # stop after 8 bits

		lb $t2, 0($s0)              # load current character
		beqz $t2, conversion_done   # stop if null terminator
		beq $t2, 10, conversion_done # stop if newline
		
		li $t4, '0'                 # ASCII value for '0'
		sub $t2, $t2, $t4           # convert ASCII to numeric (0 or 1)
		bltz $t2, skip_add          # if < 0, skip
		bgt $t2, 1, skip_add        # if > 1, skip 

		li $t3, 7                   # exponent base (for bit shift)
		sub $t3, $t3, $t0           # calculate shift based on position
		sllv $t2, $t2, $t3          # shift bit accordingly
		add $s1, $s1, $t2           # add to total decimal value

		addi $s0, $s0, 1            # move to next char
		addi $t0, $t0, 1            # increment counter
		j decimal_conversion_loop   # continue loop
	
	skip_add:
		addi $s0, $s0, 1            # move to next char
		addi $t0, $t0, 1            # increment counter
		j decimal_conversion_loop   # continue loop

	conversion_done:
		move $v0, $s1               # move decimal result to v0

		lw $s1, 0($sp)              # restore s1
		lw $s0, 4($sp)              # restore s0
		lw $ra, 8($sp)              # restore return address
		addi $sp, $sp, 12           # restore stack pointer
		jr $ra                      # return
