.text
    .globl board

    # $a0: address of the binary string (e.g., "10101010\0")
    board:
    	addi $sp, $sp, -4   # Save $ra
        sw $ra, 0($sp)
        
        move $t0, $a0       # $t0 = address of the input binary string (e.g., "10101010")
        la $t1, board_str   # $t1 = address of the writable board buffer (in data.asm)
        li $t2, 0           # $t2 = loop counter (i=0 to 7)

        # 1. Print Top Border
        la $a0, hor_border
        li $v0, SysPrintString
        syscall

        # use the empty_box to set the structure in board_str
        la $a0, empty_box
        la $a1, board_str
        li $a2, 34          # Length of empty_box + 1 for null
        li $v0, 9           # SysCall to allocate or copy (assuming your assembler supports copy-like behavior or using a manual copy)
        # Assuming a manual copy here since standard MIPS syscalls are limited:
        li $t3, 0           # Copy counter

    copy_loop:
        lb $t4, 0($a0)      # Load byte from empty_box
        sb $t4, 0($a1)      # Store byte to board_str
        addi $a0, $a0, 1    # Next source byte
        addi $a1, $a1, 1    # Next destination byte
        addi $t3, $t3, 1    # Increment counter
        blt $t3, 34, copy_loop # Loop until 34 bytes copied (including null)

        # 3. Insert '1's and '0's into board_str
        
    insert_loop:
        # Check for loop termination (8 digits processed)
        beq $t2, 8, display_final_board
        
        # Calculate offset in board_str: Offset = (i * 4) + 2
        # i=0 (digit 1): offset = (0*4)+2 = 2. Writes to '|' ' ' [x] ' ' '|'
        # i=1 (digit 2): offset = (1*4)+2 = 6. Writes to '|' ' ' '1' ' ' '|' ' ' [x] ' ' '|'
        sll $t3, $t2, 2     # $t3 = i * 4
        addi $t3, $t3, 2    # $t3 = (i * 4) + 2 (the center space index)
        
        # Load the binary digit from input string
        lb $t4, 0($t0)      # $t4 = '1' or '0'
        
        # Store the digit into the board_str buffer at the calculated offset
        sb $t4, board_str($t3)
        
        addi $t0, $t0, 1    # Advance input string pointer
        addi $t2, $t2, 1    # Increment digit counter
        b insert_loop

    display_final_board:
        # Print the formatted board string
        la $a0, board_str
        li $v0, SysPrintString
        syscall

        la $a0, newline
        li $v0, SysPrintString
        syscall

        # Print bottom border (assuming it's a hor_border)
        la $a0, hor_border
        li $v0, SysPrintString
        syscall
        
        # Restore $ra and stack pointer
        lw $ra, 0($sp)
        addi $sp, $sp, 4
        jr $ra