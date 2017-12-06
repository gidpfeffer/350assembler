noop                        # Cho-Han Game

addi $1,    $0,      1      # init_dice = 1;
addi $2,    $0,      6      # end_dice  = 6;

noop                        # Make dice roll
addi $3,    $0,      0      # i = 0;
addi $4,    $0,      7      # j = 7;
addi $5,    $0,      6      # roundLimit = 7
addi $6,    $0,      1      # odd_bitmask = 0x00000001 = 1
addi $7,    $0,      0      # old_input1 = 0
addi $10,   $0,      0      # counter = 0
addi $12,   $0,      2      # 2nd bit mask
addi $14,   $0,      0      # score = 0;

lss  $0,    $31,     0      # seed lfsr to PC

#---------- Start Game Round ----------#

DiceRollRound:

#------------ Prompt input ------------#
wli                  0      # clear display
jal printGuessPrompt
guessLoop:

waitInputG: noop            # wait for user input
wp   $25                    # update(input)
and  $11,   $25,    $6      # get last bit from input
noop
noop
noop
bne  $25,   $7,     1       # if (input != old_input) break
j    waitInputG             # else continue loop
add  $7,    $25,    $0      # old_input = new_input

noop
wli                 0
jal printGuessPrompt

bne  $11,   $1,     1
jal printCho
bne  $11,   $0,     1
jal printHan

wp   $25                    # get user input
and  $13,   $25,    $12     # get second bit
noop
noop
noop
beq  $13,   $12,    1       # if second button high, then break
j guessLoop                 # else continue loop

#------- Get Random Dice values -------#
lrs  $3,    $0,      0
noop
noop
noop
lrs  $4,    $0,      0
noop
noop
noop
sll  $3,    $3,      29     
sll  $4,    $3,      29
noop
noop
noop      
srl  $3,    $3,      29
srl  $4,    $4,      29   
noop
noop
noop

#-------- Calculate sum parity --------#
add  $8,    $4,     $3      # sum = i + j;
noop
noop
noop
and  $9,    $8,     $6      # par = sum & odd_bitmask
noop 
noop
noop

#----------- Print sum info -----------#
wli                 0
wli                 S
wli                 u
wli                 m
wli                 :
add  $22,   $8,     $0      # print sum!
jal printNumber
noop
wli                 !       
wli                 32

bne  $9,    $1,     1       # if (par == 1) then odd
jal printHan                # disp("Han")
bne  $9,    $0,     1       # if (par == 0) then even
jal printCho                # disp("Cho")


#---------- Print score info ----------#
waitInputA: noop            # wait for user input
wp   $25                    # update(input)
and  $25,   $25,     $6
noop
noop
noop
bne  $25,   $7,     1       # if (input != old_input) break
j    waitInputA             # else continue loop
add  $7,    $25,    $0      # old_input = new_input

wli                 0

bne  $11,   $9,     1       # print fail or print win with score ++
jal printBadGuess

bne  $11,   $0,     2
jal printGoodGuess
add  $14,   $14,    1       # score++

addi $10,   $10,    1       # counter++

waitInputB: noop            # wait for user input
wp 	 $25					# update(input)
and  $25,   $25,    $6      
noop
noop
noop
bne  $25,   $7,     1       # if (input != old_input) break
j    waitInputB             # else continue loop
add  $7,    $25,    $0      # old_input = new_input


beq  $10,    $5,     1      # if (counter == roundLimit) break
j DiceRollRound             # else continue

END: j END                  # end program

#-------------------------------- Print ChoHan --------------------------------#

LCDnewline:
wli                  35
wli                  35
wli                  35
wli                  35
wli                  35
wli                  35
wli                  35
wli                  35
wli                  35
wli                  35
wli                  35
wli                  35
wli                  35
wli                  35
wli                  35
wli                  35
jr $31

printGuessPrompt:
wli                  G
wli                  u
wli                  e
wli                  s
wli                  s
wli                  58
jr $31

printGoodGuess:
wli                  W
wli                  i
wli                  n
wli                  !
jr $31

printBadGuess:
wli                  F
wli                  a
wli                  i
wli                  l
wli                  !
jr $31

printCho:
wli                 C       # disp("Cho")
wli                 h
wli                 o
jr  $31

printHan:
wli                 H       # disp("Han")
wli                 a
wli                 n
jr  $31


#-------------------------------- Print Number --------------------------------#
printNumber: noop			# args <22>, uses <23> 
addi	$23, 	$0, 	0
bne		$22, 	$23, 	2	# if arg = 0
noop
wli 					423	# disp('0')

addi	$23, 	$0, 	1
bne		$22, 	$23, 	2	# if arg = 1
noop
wli 					49	# disp('1')

addi	$23, 	$0, 	2
bne		$22, 	$23, 	2	# if arg = 2
noop
wli 					50	# disp('2')

addi	$23, 	$0, 	3
bne		$22, 	$23, 	2	# if arg = 3
noop
wli 					51	# disp('3')

addi	$23, 	$0, 	4
bne		$22, 	$23, 	2	# if arg = 4
noop
wli 					52	# disp('4')

addi	$23, 	$0, 	5
bne		$22, 	$23, 	2	# if arg = 5
noop
wli 					53	# disp('5')

addi	$23, 	$0, 	6
bne		$22, 	$23, 	2	# if arg = 6
noop
wli 					54	# disp('6')

addi	$23, 	$0, 	7
bne		$22, 	$23, 	2	# if arg = 7
noop
wli 					55	# disp('7')

addi	$23, 	$0, 	8
bne		$22, 	$23, 	2	# if arg = 8
noop
wli 					56	# disp('8')

addi	$23, 	$0, 	9
bne		$22, 	$23, 	2	# if arg = 9
noop
wli 					522	# disp('9')

addi	$23, 	$0, 	10
bne		$22, 	$23, 	3	# if arg = 10
noop
wli 					49	# disp('10')
wli 					423

addi	$23, 	$0, 	11
bne		$22, 	$23, 	3	# if arg = 11
noop
wli 					49	# disp('11')
wli 					49 

addi	$23, 	$0, 	12
bne		$22, 	$23, 	3	# if arg = 12
noop
wli 					49	# disp('12')
wli 					50

jr $31 	