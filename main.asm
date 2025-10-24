# Header: Binary Game in MIPS
# Author: Aakrist Godar
# Date: Nov-18-2025
# Description: An interactive game where the user can practice their binary to decimal converstion or decimal to binary converstion

.include "SysCalls.asm"
.include "data.asm"
.include "display.asm"
.include "binary_to_decimal.asm"
.include "deciaml_to_binary.asm"

.text


.main
    li $v0, SysPrintString # call the print string syscall
    la $a0, welcome # load address of the welcome message
    jal print_string # print the welcome by jumping to print_string link

loop_for_game:
    la $a0, menu
    jal print_string

    li $v0, SysReadInt
    syscall
    move $t0, $v0

    beq $t0, 1, modeOne
    beq $t0, 2, modeTwo

    la $a0, invalid
    jal print_string
    j loop_for_game

# binary to decimal
modeOne:
    jal b_to_d_mode
    j continue

# decimal to binary
modeTwo:
    jal d_to_b_mode
    j continue

continue:
    la $a0, next_lvl
    jal print_string

    addi $s0, $s0, 1
    li $t1, 10
    blt $s0, $t1, game_loop

    la $a0, game_over
    jal print_string

    li $v0, SysExit
    syscall

