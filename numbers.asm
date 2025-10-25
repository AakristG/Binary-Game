# CS2340 Term Project
# Author: Aakrist Godar
# Date: 10-24/25
# Description: This file handles random numbers, generating binary, conversion to decimal

.text
	start_binary_process:
		addi $sp, $sp, -4	# allocate 4 bytes for the stack
		sw $ra, 0($sp) 		# store the returna ddress into the stack

		li $t0, 0
		la $t1, bin_str

	generation_loop:	# this generates each bit
		beq $t0, 8, binary_done # stop after 8 bits
		jal generateNumber
		addi $v0, $v0, '0'
		sb $v0, 0($t1)
		addi $t1, $t1, 1
		j generation_loop

	binary_done:
		sb   $zero, 0($t1)          # null terminator
		la   $a0, bin_str
		jal  convert_to_decimal            # convert to decimal
		la   $v1, bin_str             # store binary string address


		lw   $ra, 0($sp)
		addi $sp, $sp, 4
		jr   $ra

	generateNumber:
		li $a1, 2
		li $v0, SysRandIntRange
		syscall
		
		move $v0, $v0
		jr $ra

	convert_to_decimal:
		addi $sp, $sp, -12 # allocate 12 bytes into the stack
		sw $ra, 8($sp)
		sw $s0, 4($sp)
		sw $s1, 0($sp)

		move $s0, $a0	# stores binary string address
		li $s1, 0	# decimal variable
		li $t0, 0	# loop counter
	
	decimal_conversion_loop:
		lb $t2, 0($s0)
		beq  $t2, $zero, conversion_done  # end if null terminator
		sub  $t2, $t2, '0'          # convert ASCII to bit (0/1)

		li   $t3, 7
		sub  $t3, $t3, $t0          # compute exponent position
		sllv $t2, $t2, $t3          # shift bit accordingly
		add  $s1, $s1, $t2          # accumulate value

		addi $s0, $s0, 1            # next bit
		addi $t0, $t0, 1
		j    decimal_conversion_loop
	
	conversion_done:
		move $v0, $s1
		lw   $s1, 0($sp)
		lw   $s0, 4($sp)
		lw   $ra, 8($sp)
		addi $sp, $sp, 12
		jr   $ra

	

	
		

