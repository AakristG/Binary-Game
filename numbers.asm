# CS2340 Term Project
# Author: Aakrist Godar
# Date: 10-24/25
# Description: This file handles random numbers, generating binary, conversion to decimal
.text
	start_binary_process:
		addi $sp, $sp, -4	# allocate 4 bytes for the stack
		sw $ra, 0($sp) 		# store the returna ddress into the stack

		li $t0, 0
		la $t1, 8

	generation_loop:	# this generates each bit
		beq $t0, $t1, binary_done # stop after 8 bits
		jal generateNumber

		move $t6, $v0
		
		beqz $t6, store_zero
		li $t3, '1'
		j store_bit

	store_zero:
		li $t3, '0'

	store_bit:
		la $t4, bin_str			# get base address of binary string
		add $t4, $t4, $t0		# move pointer to correct position
		sb $t3, 0($t4)			# store ASCII bit

		addi $t0, $t0, 1		# increment loop counter
		j generation_loop

	binary_done:
		la $t4, bin_str						# Loads binary address into t4
		add $t4, $t4, $t0	
		sb $zero, 0($t4)          # null terminator

		la $a0, bin_str
		jal convert_to_decimal            # convert to decimal
		la $v1, bin_str             # store binary string address

		lw   $ra, 0($sp)
		addi $sp, $sp, 4
		jr   $ra

	generateNumber:
		addi $sp, $sp, -4
		sw $ra, 0($sp)

		li $a0, 0
		li $a1, 2
		li $v0, SysRandIntRange
		syscall
		
		move $v0, $a0

		lw $ra, 0($sp)						# Loads return address back from stack
		addi $sp, $sp, 4					# Restores allocated memory to stack
		jr $ra							# Jumps back to address stored

	convert_to_decimal:
		addi $sp, $sp, -12 # allocate 12 bytes into the stack
		sw $ra, 8($sp)
		sw $s0, 4($sp)
		sw $s1, 0($sp)

		move $s0, $a0	# stores binary string address
		li $s1, 0	# decimal variable
		li $t0, 0	# loop counter
	
	decimal_conversion_loop:
		beq $t0, 8, conversion_done

		lb $t2, 0($s0)
		beqz $t2, conversion_done  # end if null terminator
		beq $t2, 10, conversion_done
		
		li $t4, '0'
		sub $t2, $t2, $t4        # t2 = ASCII - '0'
		bltz $t2, skip_add             # if < 0 -> not a digit, treat as 0 and skip
		bgt  $t2, 1, skip_add          # if > 1 -> not 0/1, treat as 0 and skip

		li   $t3, 7
		sub  $t3, $t3, $t0          # compute exponent position
		sllv $t2, $t2, $t3          # shift bit accordingly
		add  $s1, $s1, $t2          # accumulate value

		addi $s0, $s0, 1            # next bit
		addi $t0, $t0, 1
		j decimal_conversion_loop
	
	skip_add:
		addi $s0, $s0, 1               # next char
		addi $t0, $t0, 1               # next position
		j decimal_conversion_loop

	conversion_done:
		move $v0, $s1

		lw   $s1, 0($sp)
		lw   $s0, 4($sp)
		lw   $ra, 8($sp)
		addi $sp, $sp, 12
		jr   $ra

	

	
		

