.text 
    .globl d_to_b_mode

    # d_to_b_mode is the entry point for the D->B game mode.
    d_to_b_mode:
        # Save registers for game state: $s0 (Level), $s1 (Score), $s2 (Target)
        addi $sp, $sp, -16
        sw $ra, 12($sp)
        sw $s0, 8($sp)
        sw $s1, 4($sp)
        sw $s2, 0($sp)

        # Initialize Game State
        li $s0, 1  # Current Level = 1
        
        j d_to_b_game_loop

    d_to_b_game_loop:
        # Check for Win Condition (Level > 10)
        li $t5, 11
        bge $s0, $t5, d_to_b_game_win

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
        j d_to_b_question_loop

    d_to_b_question_loop:
        # Check for Level Up Condition ($s1 == $s2)
        beq $s1, $s2, d_to_b_level_up
        
        # 3. Ask a single question (Decimal to Binary)
        
        # Generate random number [0,255]
        li $a0, 0
        li $a1, 256
        li $v0, SysRandIntRange
        syscall
        move $t0, $v0           # $t0 holds the random number (correct decimal answer)

        la $a0, decimal
        li $v0, SysPrintString
        syscall

        move $a0, $t0           # Argument is the random number to print
        li $v0, SysPrintInt
        syscall
        
        la $a0, newline
        li $v0, SysPrintString
        syscall
        
        # Read user binary input (string into bin_str)
        la $a0, bin_str
        li $a1, 9
        li $v0, SysReadString
        syscall

        # Convert user's binary string to an integer ($v0)
        la $a0, bin_str
        jal convert_to_int
        move $t1, $v0           # $t1 holds the user's decimal answer

        # Compare correct answer ($t0) with user answer ($t1)
        beq $t0, $t1, d_to_b_correct_ans
        
        # INCORRECT ANSWER (GAME OVER)
        j d_to_b_game_over

    d_to_b_correct_ans:
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
        j d_to_b_question_loop

    d_to_b_level_up:
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
        j d_to_b_game_loop

     convert_to_int:
        addi $sp, $sp, -4 # Save $ra
        sw $ra, 0($sp)
        
        move $t0, $a0
        li $v0, 0
        
    d_to_b_loop_convert:
        lb $t1, 0($t0)
        beqz $t1, done
        sll $v0, $v0, 1
        addi $t1, $t1, -48 # Convert ASCII '0' or '1' to integer 0 or 1
        or $v0,  $v0, $t1
        addi $t0, $t0, 1
        b d_to_b_loop_convert

    done:
        lw $ra, 0($sp)
        addi $sp, $sp, 4
        jr $ra

    d_to_b_game_win:
        # Display Win message
        la $a0, game_win
        li $v0, SysPrintString
        syscall
        
        li $v0, SysExit
        syscall

    d_to_b_return:
        # Restore saved registers
        lw $s2, 0($sp)
        lw $s1, 4($sp)
        lw $s0, 8($sp)
        lw $ra, 12($sp)
        addi $sp, $sp, 16
        jr $ra
        

     d_to_b_game_over:
        # Display Game Over message
        la $a0, game_over
        li $v0, SysPrintString
        syscall

        # Print the level they were on ($s0)
        move $a0, $s0
        li $v0, SysPrintInt
        syscall

        # Print the correct answer for the failed question ($t0 holds the correct answer)
        la $a0, incorrect
        li $v0, SysPrintString
        syscall
        move $a0, $t0
        li $v0, SysPrintInt
        syscall
        
        li $a0, '\n' # Print newline
        li $v0, SysPrintChar
        syscall

        li $v0, SysExit
        syscall