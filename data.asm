.data
    welcome:    .asciiz "|\t\t\tWELCOME TO THE BINARY GAME (MIPS)\t\t\t\t\t\t\t\t\t|\n"
    menu:       .asciiz "|\t\t\t\tPress ENTER to start the game\t\t\t\t\t\t\t\t\t|\n"
    newline:    .asciiz "\n"
    binary:     .asciiz "|Convert this binary to decimal: \t\t\t\t\t\t\t\t\t\t\t\t|\n"
    decimal:    .asciiz "|Convert this decimal to binary: "
    correct:    .asciiz "\nRight answer!!\n"
    incorrect:  .asciiz "\nWrong answer. The correct answer was:\t "
    hor_border: .asciiz "+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+\n"
    empty_box:  .asciiz "|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|"

    tabs:       .asciiz "\t\t\t\t\t\t\t\t\t\t\t\t|"
    decimalBox: .asciiz"+- - - - - - - - - - - - - - - -+\n"


    lvl_msg:    .asciiz "|\t\t\t--- WELCOME TO THIS LEVEL -----\t\t\t\t\t\t\t\t\t\t|"
    lose_msg:   .asciiz "\n------- GAME OVER! You failed at this Level "
    game_win:   .asciiz "\n*** CONGRATULATIONS! You have mastered Level 10! ***\n"
    bin_prompt: .asciiz "Enter the answer (8 bits no spaces): "
    dec_prompt: .asciiz "Enter the answer (no spaces): "
    
    #end:        .asciiz "End of the game\n"
    invalid:    .asciiz "Invalid choice. Try Again. \n"
    next_lvl:   .asciiz "Proceeding to next level... \n"
    
    line:	.asciiz "|\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t|\n"

    board: .asciiz " = [?]  [?]  [?]  [?] _ [?]  [?]  [?]  [?]   | \n"	

    buffer:     .space 2
    bin_str:    .space 10
    user_input: .space 32
    board_str:  .space 80
    char_input: .space 4