.text
.globl main

main:

    li		$t0, 0		    # $t1 = 0, loop counter
    li		$v0, 4          ##
    la		$a0, Intro      #Printing Intro
    syscall                 ##
    li      $t4, 1          #Start with Player 1
    li      $s0, 9
    li      $s1, 1


Play:
    li      $v0, 4          ##
    la		$a0, Positions  #Printing the positions
    syscall                 ##

    la		$a0, Board      #Print the standings of the board at that moment
    syscall                 ##
    
    beq		$t4, 1, p1      #if $t4= 1, go to player 1
    j		p2              #else player 2
    

p1:
    li      $v0, 4          ##
    la		$a0, Player1    #Asking player 1 for position to put X
    syscall                 ##
    
    li		$v0, 5          #Taking input
    syscall                 ##
    move 	$t2, $v0        #moving value to $t2

    slt     $t6, $s0, $t2
    beq     $t6, 1, ErrMsg1

    slt     $t6, $t2, $s1
    beq		$t6, 1, ErrMsg1
    

    mul     $t2, $t2, 2     #for getting the position on board
    sub 	$t2, $t2, 2		
    
    la		$t1, Board		#Address of Board in $t1
    add		$t1, $t1, $t2	#Getting the correct position to put X
    lb		$t5, 0($t1)		# 
    
    
    beq		$t5, 88, errorMsg	# if that position already contain X or O, print error msg
    beq		$t5, 79, errorMsg	##
    
    addi	$t5, $t5, 56		# else put X at that Position
    sb		$t5, 0($t1)		# 
    

    li		$t4, 2              #pointer for specifying that next destination is player 2
    
    add		$t0, $t0, 1

    j		Check				# jump to Check
    


p2:
    
    li      $v0, 4          ##
    la		$a0, Player2    #Asking player 2 for position to put O
    syscall                 ##
    
    li		$v0, 5          #Taking input
    syscall                 ##
    move 	$t2, $v0        #moving value to $t2

    slt     $t6, $s0, $t2
    beq     $t6, 1, ErrMsg1

    slt     $t6, $t2, $s1
    beq		$t6, 1, ErrMsg1

    mul     $t2, $t2, 2     #for getting the position on board
    sub 	$t2, $t2, 2			# 2 = $t1 - 0
    
    la		$t1, Board		#Address of Board in $t1
    add		$t1, $t1, $t2	#Fetting the correct position to put O
    lb		$t5, 0($t1)		#Value at the user entered position
    
    
    beq		$t5, 88, errorMsg	# if that position already contain X or O, print error msg
    beq		$t5, 79, errorMsg	##
    
    addi	$t5, $t5, 47		# else put O at that Position
    sb		$t5, 0($t1)		# 
    

    li		$t4, 1              #pointer for specifying that next destination is player 1
    
    add		$t0, $t0, 1
    
    j		Check




errorMsg:
    li		$v0, 4
    la      $a0, EMsg
    syscall

    j		Play



ErrMsg1:
    li      $v0, 4
    la      $a0, errMsg1
    syscall

    j		Play
    



P1Wins:
    li      $v0, 4
    la		$a0, Board
    syscall
    
    la      $a0, Win1
    syscall

    li      $v0, 10
    syscall



P2Wins:
    li      $v0, 4
    la		$a0, Board
    syscall
    
    la      $a0, Win2
    syscall

    li      $v0, 10
    syscall


draw:
    li      $v0, 4
    la      $a0, Board
    syscall

    la      $a0, Draw
    syscall

    li      $v0, 10
    syscall




####################################################   Checking Part   ######################################################

#####################   Row 1 checking starts   #########################
Check:
    la		$t1, Board
    lb		$t7, 0($t1)
    beq		$t7, 88, c1
    beq		$t7, 79, c3
    j       c5
    

c1:
    la		$t1, Board
    lb		$t7, 2($t1)
    beq		$t7, 88, c2
    j		c5
    



c2:
    la      $t1, Board
    lb      $t7, 4($t1)
    beq     $t7, 88, P1Wins
    j		c5
    



c3:
    la      $t1, Board
    lb      $t7, 2($t1)
    beq     $t7, 79, c4
    j		c5
    


c4:
    la      $t1, Board
    lb      $t7, 4($t1)
    beq     $t7, 79, P2Wins
    j		c5
    
    

##########################   Row 2 checking starts   #############################
c5:
    la      $t1, Board
    lb      $t7, 6($t1)
    beq     $t7, 88, c6
    beq     $t7, 79, c8
    j		c10	
    



c6:
    lb      $t7, 8($t1)
    beq     $t7, 88, c7
    j		c10
    

c7:
    lb      $t7, 10($t1)
    beq     $t7, 88, P1Wins
    j		c10	
    
    

c8:
    lb      $t7, 8($t1)
    beq     $t7, 79, c9
    j		c10
    


c9:
    lb      $t7, 10($t1)
    beq     $t7, 79, P2Wins
    j		c10
    


#########################   Row 3 checking starts   ########################
c10:
    la      $t1, Board
    lb      $t7, 12($t1)
    beq     $t7, 88, c11
    beq     $t7, 79, c13
    j		c15
    



c11:
    lb      $t7, 14($t1)
    beq     $t7, 88, c12
    j		c15
    

c12:
    lb      $t7, 16($t1)
    beq     $t7, 88, P1Wins
    j		c15
    
    

c13:
    lb      $t7, 14($t1)
    beq     $t7, 79, c14
    j		c15
    


c14:
    lb      $t7, 16($t1)
    beq     $t7, 79, P2Wins
    j		c15
    


#####################   Column 1 checking starts   ########################
c15:

    la      $t1, Board
    lb      $t7, 0($t1)
    beq     $t7, 88, c16
    beq     $t7, 79, c18
    j		c20
    



c16:
    lb      $t7, 6($t1)
    beq     $t7, 88, c17
    j		c20
    

c17:
    lb      $t7, 12($t1)
    beq     $t7, 88, P1Wins
    j		c20
    
    

c18:
    lb      $t7, 6($t1)
    beq     $t7, 79, c19
    j		c20
    


c19:
    lb      $t7, 12($t1)
    beq     $t7, 79, P2Wins
    j		c20
    

################   Column 2 checking starts   ###################
c20:
    la      $t1, Board
    lb      $t7, 2($t1)
    beq     $t7, 88, c21
    beq     $t7, 79, c23
    j		c25
    



c21:
    lb      $t7, 8($t1)
    beq     $t7, 88, c22
    j		c25
    

c22:
    lb      $t7, 14($t1)
    beq     $t7, 88, P1Wins
    j		c25
    
    

c23:
    lb      $t7, 8($t1)
    beq     $t7, 79, c24
    j		c25
    


c24:
    lb      $t7, 14($t1)
    beq     $t7, 79, P2Wins
    j		c25
    


############################   Column 3 checking starts   ################################
c25:
    la      $t1, Board
    lb      $t7, 4($t1)
    beq     $t7, 88, c26
    beq     $t7, 79, c28
    j		c30
    



c26:
    lb      $t7, 10($t1)
    beq     $t7, 88, c27
    j		c30
    

c27:
    lb      $t7, 16($t1)
    beq     $t7, 88, P1Wins
    j		c30
    
    

c28:
    lb      $t7, 10($t1)
    beq     $t7, 79, c29
    j		c30
    


c29:
    lb      $t7, 16($t1)
    beq     $t7, 79, P2Wins
    j		c30
    

###############################   Diagonal 1 checking starts   #################################
c30:
    la      $t1, Board
    lb      $t7, 0($t1)
    beq     $t7, 88, c31
    beq     $t7, 79, c33
    j		c35
    



c31:
    lb      $t7, 8($t1)
    beq     $t7, 88, c32
    j		c35
    

c32:
    lb      $t7, 16($t1)
    beq     $t7, 88, P1Wins
    j		c35
    
    

c33:
    lb      $t7, 8($t1)
    beq     $t7, 79, c34
    j		c35
    


c34:
    lb      $t7, 16($t1)
    beq     $t7, 79, P2Wins
    j		c35
    

####################################   Diagonal 2 checking starts   ##########################################
c35:
    la      $t1, Board
    lb      $t7, 4($t1)
    beq     $t7, 88, c36
    beq     $t7, 79, c38
    j		c40
    



c36:
    lb      $t7, 8($t1)
    beq     $t7, 88, c37
    j		c40
    

c37:
    lb      $t7, 12($t1)
    beq     $t7, 88, P1Wins
    j		c40
    
    

c38:
    lb      $t7, 8($t1)
    beq     $t7, 79, c39
    j		c40
    


c39:
    lb      $t7, 12($t1)
    beq     $t7, 79, P2Wins
    j		c40
    


c40:
    beq		$t0, 9, draw
    j		Play
    


.end main




.data

Intro:      .ascii      "Welcome to Shubham's Tic-Tac-Toe.\n"
            .ascii      "The position grid always printed before each user input. Kindly refer to it for giving your input.\n"
            .ascii      "Current status of the game(grid) is also printed after the position grid. Keep an eye on that.\n"
            .ascii      "All set??? Let's start!!\n"
            .asciiz     "~~~~~~~~~~~~~~~~~~~~~~~~\n"
Positions:  .asciiz     "\n\n1|2|3\n4|5|6\n7|8|9\n\n"
Player1:    .asciiz     "Player A: "
Player2:    .asciiz     "Player B: "
EMsg:       .asciiz     "\n~~~~~Error: Position already filled, please enter some other position.\n"

errMsg1:    .asciiz     "\n~~~~~Error: Please enter a valid position.\n"

Win1:       .ascii      "Player A wins!!!\n"
            .asciiz     "Better luck next time Player B:("
Win2:       .ascii      "Player B wins!!!\n"
            .asciiz     "Better luck next time Player A:("
Draw:       .asciiz     "Uffff!!! It's a draw."

Board:      .asciiz     " | | \n | | \n | | \n\n"
