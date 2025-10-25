.text

  print_header_decimal:
    li $v0, SysPrintString
    la $a0, newline
    syscall

    li $v0, SysPrintString
    la $a0, hor_border
    syscall

    li $v0, SysPrintString
    la $a0, decimal
    syscall


    jr $ra

  print_footer_decimal:
    li $v0, SysPrintString
    la $a0, newline
    syscall

    li $v0, SysPrintString
    la $a0, hor_border
    syscall
    jr $ra

  print_header_binary:

    li $v0, SysPrintString
    la $a0, newline
    syscall

    li $v0, SysPrintString
    la $a0, hor_border
    syscall

    li $v0, SysPrintString
    la $a0, binary
    syscall

    li $v0, SysPrintString
    la $a0, line
    syscall

    li $v0, SysPrintString
    la $a0, hor_border
    syscall

    jr $ra

  print_footer_binary:
    li $v0, SysPrintString
    la $a0, hor_border
    syscall
    jr $ra

  store_in_board:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    move $t0, $a0    # Binary string
    la $t1, empty_box
    la $t2, board_str
    li $t3, 0

  copy_loop:
    lb $t4, 0($t1)
    sb $t4, 0($t2)
    beqz $t4, copy_done
    addi $t1, $t1, 1
    addi $t2, $t2, 1
    j copy_loop

  copy_done:
    li $t3, 0      # Reset digit index
  insert_loop:
    beq  $t3, 8, print_board
    sll  $t4, $t3, 2   # offset = i * 4
    addi $t4, $t4, 2   # center of each slot
    lb $t5, 0($t0)   # get digit
    sb $t5, board_str($t4) # store digit in board
    addi $t0, $t0, 1
    addi $t3, $t3, 1
    j insert_loop

  print_board:
    la $a0, board_str
    li $v0, SysPrintString
    syscall

    la $a0, newline
    li $v0, SysPrintString
    syscall

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra


  