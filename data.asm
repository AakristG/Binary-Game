.data
    welcome:    .asciiz "|\tWELCOME TO THE BINARY GAME (MIPS)\t\t\t\t\t\t\t\t\t\t\t|\n"
    menu:       .asciiz "|\tThen press ENTER to start the game\t\t\t\t\t\t\t\t\t\t\t|\n"
    newline:    .asciiz "\n"
    binary:     .asciiz "\nConvert this binary to decimal: \n"
    decimal:    .asciiz "\nConvert this decimal to binary:"
    correct:    .asciiz "\nRight answer!!\n"
    incorrect:  .asciiz "\nWrong answer. The correct answer was:\t "
    score:      .asciiz "\n Your total score is: "
    seperation: .asciiz "\n------------------------------\n"
    mode_pick:  .asciiz "|\tPICK YOUR MODE:\t\t\t\t\t\t\t\t\t\t\t\t\t\t|\n|\t\t------ Mode 1: Binary to Decimal -------  \t\t\t\t\t\t\t\t\t|\n|\t\t------ Mode 2: Decimal to Binary -------  \t\t\t\t\t\t\t\t\t| \n"
    hor_border: .asciiz "+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+\n"
    ver_border: .asciiz "|\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n|\n"
    empty_box:  .asciiz "|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|\t|"
    
    # NEW GAME MESSAGES
    lvl_msg:    .asciiz "\n--- CURRENT LEVEL "
    score_msg:  .asciiz " (Score: "
    slash_msg:  .asciiz " / Required: "
    colon_space:.asciiz "): \n"
    level_up:   .asciiz "\n*** LEVEL UP! Advancing to Level "
    game_over:  .asciiz "\n------- GAME OVER! You failed at Level "
    game_win:   .asciiz "\n*** CONGRATULATIONS! You have mastered Level 10! ***\n"
    
    inv_mode:   .asciiz "Invalid mode. Please enter 1 or 2.\n"
    end:        .asciiz "End of the game\n"
    invalid:    .asciiz "Invalid choice. Try Again. \n"
    next_lvl:   .asciiz "Proceeding to next level... \n"
    quit:	.asciiz "Enter 3 if you want to quit\n"
    
    line:	.asciiz "|\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t|\n"

    bin_str:    .space 9
    board_str:  .space 34
    char_input: .space 4
