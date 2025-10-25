.text
    .globl b_to_d_mode

    # b_to_d_mode is the entry point for the B->D game mode.
    b_to_d_mode:
        # Save registers for game state: $s0 (Level), $s1 (Score), $s2 (Target)
        addi $sp, $sp, -16
        sw $ra, 12($sp)
        sw $s0, 8($sp)
        sw $s1, 4($sp)
        sw $s2, 0($sp)

        # Initialize Game State
        li $s0, 1  # Current Level = 1
        
        j b_to_d_game_loop

    b_to_d_game_loop:
        # Check for Win Condition (Level > 10)
        li $t5, 11
        bge $s0, $t5, b_to_d_game_win

        # 1. Setup New Level: Target Score ($s2) equals Current Level ($s0)
        move $s2, $s0       
        li $s1, 0           # Reset current score

        # 2. Display Level Info 
        la $a0, lvl_msg
        li $v0, SysPrintString
        syscall
        move $a0, $s0 # Print current level
        li $v0, SysPrintInt
        syscall
        la $a0, score_msg # Print " (Score: "
        li $v0, SysPrintString
        syscall
        move $a0, $s1 # Print current score (0)
        li $v0, SysPrintInt
        syscall
        la $a0, slash_msg # Print " / Required: "
        li $v0, SysPrintString
        syscall
        move $a0, $s2 # Print target score
        li $v0, SysPrintInt
        syscall
        la $a0, colon_space # Print "): \n"
        li $v0, SysPrintString
        syscall

        # Start asking questions for this level
        j b_to_d_question_loop

    b_to_d_question_loop:
        # Check for Level Up Condition ($s1 == $s2)
        beq $s1, $s2, b_to_d_level_up
        
        # 3. Ask a single question (Binary to Decimal)

        la $a0, binary
        li $v0, SysPrintString
        syscall

        # Generate random number [0,255]
        li $a0, 0
        li $a1, 256
        li $v0, SysRandIntRange
        syscall
        move $t0, $v0             # $t0 = correct decimal answer

        # Convert to binary string
        move $a0, $t0
        la $a1, bin_str
        jal convert

        # Display binary string as board
        la $a0, bin_str
        jal board

        # Read user decimal input
        li $v0, SysReadInt
        syscall
        move $t1, $v0             # $t1 = user input

        # Compare answer
        beq $t0, $t1, b_to_d_correct_ans

        # gam over
        j b_to_d_game_over

    b_to_d_correct_ans:
        la $a0, correct
        li $v0, SysPrintString
        syscall

        # Increment score ($s1++)
        addi $s1, $s1, 1

        # Print current score status
        la $a0, score_msg
        li $v0, SysPrintString
        syscall
        move $a0, $s1 # Print current score
        li $v0, SysPrintInt
        syscall
        la $a0, slash_msg
        li $v0, SysPrintString
        syscall
        move $a0, $s2 # Print target score
        li $v0, SysPrintInt
        syscall
        la $a0, colon_space # Print "): \n"
        li $v0, SysPrintString
        syscall
        
        # Continue asking questions in this level
        j b_to_d_question_loop

    b_to_d_level_up:
        # Display Level Up message
        la $a0, level_up
        li $v0, SysPrintString
        syscall

        # Print the new level number
        addi $t5, $s0, 1 # $t5 = next level (for display)
        move $a0, $t5
        li $v0, SysPrintInt
        syscall
        
        li $a0, '\n' # Print newline
        li $v0, SysPrintChar
        syscall

        # Increment Level ($s0++) and go to next game loop iteration
        addi $s0, $s0, 1
        j b_to_d_game_loop

     convert:
        # Save registers (t-registers are caller-saved, but saving them for simplicity)
        addi $sp, $sp, -24
        sw $t2, 20($sp)
        sw $t3, 16($sp)
        sw $t4, 12($sp)
        sw $t5, 8($sp)
        sw $t6, 4($sp)
        sw $ra, 0($sp)

        move $t5, $a0   # Use $t5 to hold the number to shift
        move $t6, $a1   # Use $t6 to hold the string base address

        addi $t2, $t6, 8    # $t2 = pointer to index 8 (start of reverse fill)
        li $t3, 8           # Bit counter

    b_to_d_loop_convert:
        beqz $t3, null_term
        
        # Get the least significant bit (0 or 1)
        andi $t4, $t5, 1
        # Convert 0/1 to ASCII '0'/'1'
        addi $t4, $t4, '0'   
        
        addi $t2, $t2, -1   # Move pointer back one position
        sb $t4, 0($t2)      # Store the bit character
        
        srl $t5, $t5, 1     # Shift the number right
        addi $t3, $t3, -1   # Decrement bit counter
        b b_to_d_loop_convert

    null_term:
        sb $zero, 8($t6)    # Null terminate the string (at index 8)

        # Restore registers and return
        lw $ra, 0($sp)
        lw $t6, 4($sp)
        lw $t5, 8($sp)
        lw $t4, 12($sp)
        lw $t3, 16($sp)
        lw $t2, 20($sp)
        addi $sp, $sp, 24
        jr $ra


    b_to_d_game_win:
        # Display Win message
        la $a0, game_win
        li $v0, SysPrintString
        syscall
        
        li $v0, SysExit
        syscall

    b_to_d_return:
        # Restore saved registers
        lw $s2, 0($sp)
        lw $s1, 4($sp)
        lw $s0, 8($sp)
        lw $ra, 12($sp)
        addi $sp, $sp, 16
        jr $ra
    
     b_to_d_game_over:

        # Print the correct answer for the failed question ($t0 holds the correct answer)
        la $a0, incorrect
        li $v0, SysPrintString
        syscall
        move $a0, $t0
        li $v0, SysPrintInt
        syscall

         # Display Game Over message
        la $a0, game_over
        li $v0, SysPrintString
        syscall

        # Print the level they were on ($s0)
        move $a0, $s0
        li $v0, SysPrintInt
        syscall

        li $a0, '\n' # Print newline
        li $v0, SysPrintChar
        syscall

        li $v0, SysExit
        syscall
