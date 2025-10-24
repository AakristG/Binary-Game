.include "SysCalls.asm"

.text
.globl print_string # make print
.globl print_int
.globl board


print_string:
    li $v0, SysPrintString # call the print string
    syscall # print the string
    jr $ra # jump to return register

# a default method for the board
board:
    la $t0, ($a0)
    la $a1, hor_border
    jal print_string

    la $a1, empty_box
    jal print_string

    li $t1, 0

loop:
    lb $t2, 0($t0)
    beqz $t2, end
    move $a0, $t2
    li $v0, SysPrintChar
    syscall
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    b loop

end:
    la $a1, newLine
    jal print_string
    jr $ra