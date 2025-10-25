.data
    welcome:    .asciiz "|\t\t\tWELCOME TO THE BINARY GAME (MIPS)\t\t\t\t\t\t\t\t\t|\n"
    menu:       .asciiz "|\t\t\t\tPress ENTER to start the game\t\t\t\t\t\t\t\t\t|\n"
    newline:    .asciiz "\n"
    binary:     .asciiz "\nConvert this binary to decimal: \n"
    decimal:    .asciiz "\nConvert this decimal to binary:"
    correct:    .asciiz "\nRight answer!!\n"
    incorrect:  .asciiz "\nWrong answer. The correct answer was:\t "
    score:      .asciiz "\n Your total score is: "
    seperation: .asciiz "\n------------------------------\n"
    hor_border: .asciiz "+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+\n"
    empty_box:  .asciiz "|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|"
    question:   .asciiz "?"

    # NEW GAME MESSAGES
    lvl_msg:    .asciiz "|\t\t\t--- CURRENT LEVEL -----\t\t\t\t\t\t\t\t\t\t\t|\n"
    score_msg:  .asciiz " Score: "
    slash_msg:  .asciiz " / Required: "
    level_up:   .asciiz "\n*** LEVEL UP! Advancing to Level "
    game_over:  .asciiz "\n------- GAME OVER! You failed at Level "
    game_win:   .asciiz "\n*** CONGRATULATIONS! You have mastered Level 10! ***\n"
    
    inv_mode:   .asciiz "Invalid mode. Please enter 1 or 2.\n"
    #end:        .asciiz "End of the game\n"
    invalid:    .asciiz "Invalid choice. Try Again. \n"
    next_lvl:   .asciiz "Proceeding to next level... \n"
    quit:	.asciiz "Enter 3 if you want to quit\n"
    
    line:	.asciiz "|\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t|\n"

    buffer:     .space 2
    bin_str:    .space 10
    board_str:  .space 34
    char_input: .space 4