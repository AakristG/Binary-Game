# Header: Binary Game in MIPS
# Author: Aakrist Godar
# Date: Oct-18-2025
# Description: An interactive game where the user can practice their binary to decimal converstion or decimal to binary converstion

.include "SysCalls.asm"
.include "data.asm"

.text
    .globl main

    main:
    	addi $sp, $sp, -4   # Allocate space for $ra
        sw $ra, 0($sp)      # Save $ra
        
    loop_for_game:
        # Display menu and get input
        la $a0, hor_border
        li $v0, SysPrintString
        syscall
        
        la $a0, welcome
        li $v0, SysPrintString
        syscall
        
    	la $a0, line
        li $v0, SysPrintString
        syscall
        
        la $a0, mode_pick
        li $v0, SysPrintString
        syscall

        la $a0, menu
        li $v0, SysPrintString
        syscall
        
        la $a0, hor_border
        li $v0, SysPrintString
        syscall
        
        la $a0, char_input   # $a0 = address of buffer
        li $a1, 4              # $a1 = max length to read
        li $v0, SysReadString  # SysCall code 8
        syscall
        
        la $t0, char_input   # $t0 = address of input_buffer
        lb $t1, 0($t0)         # $t1 = the ASCII value of the first character

        lb $t2, 1($t0) # load byte at t2

        li $t3, 10
        bne $t2, $t3, check_null

        j check_char

    # Validate input length and char
	check_null:
        beqz $t2, check_char   # If second char IS '\0', input length is 1.
        j invalid_input

    check_char:
        li $t3, '1'
        beq $t1, $t3, modeOne  # If char is 1, go to Mode 1

        li $t3, '2'
        beq $t1, $t3, modeTwo  # If char is 2, go to Mode 2

    invalid_input:
        la $a0, invalid
        li $v0, SysPrintString
        syscall
        j loop_for_game

    # binary to decimal (Mode 1 runs the full game until win/loss)
    modeOne:
        jal b_to_d_mode
        j loop_for_game # Go back to menu after game ends

    # decimal to binary (Mode 2 runs the full game until win/loss)
    modeTwo:
        jal d_to_b_mode
        j loop_for_game # Go back to menu after game ends
        
    exit_program:
        la $a0, end
        li $v0, SysPrintString
        syscall
        
        li $v0, SysExit
        syscall
        
        lw $ra, 0($sp)
        addi $sp, $sp, 4
        jr $ra
        
.include "display.asm" 
.include "binary_to_decimal.asm"
.include "decimal_to_binary.asm"
