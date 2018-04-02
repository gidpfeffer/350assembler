noop                        # Cho-Han Game

addi $1,    $0,      1      # init_dice = 1;
addi $2,    $0,      5      # end_dice  = 6;

noop                        # Make dice roll
addi $3,    $0,      0      # i = 0;
addi $4,    $0,      7      # j = 7;
addi $5,    $0,      6      # roundLimit = 7
addi $6,    $0,      1      # odd_bitmask = 0x00000001 = 1
addi $7,    $0,      0      # old_input1 = 0
addi $10,   $0,      0      # counter = 0
addi $11,   $0,      0      # choice input = 0
addi $12,   $0,      2      # 2nd bit mask
addi $13,   $0,      0      # execute input = 0
addi $14,   $0,      0      # score = 0;
addi $15,   $0,      0      # saved user guess

lss  $0,    $31,     0      # seed lfsr to PC

#---------- Start Game Round ----------#

DiceRollRound:

#------------ Prompt input ------------#
guessLoop:
wli                 0      # clear display
jal printGuessPrompt

bne  $11,   $1,     1
jal printHan
bne  $11,   $0,     1
jal printCho

waitInputG: noop            # wait for user input
wp   $25                    # update(input)
noop
noop
and  $11,   $25,    $6      # get zeroeth bit from input
and  $13,   $25,    $12     # get first bit from input
noop
noop
bne  $11,   $7,     1       # if (input != old_input) break
j    waitInputG             # else continue loop
add  $7,    $11,    $0      # old_input  = new_input
add  $15,   $11,    $0      # save_input = new_input

noop
beq  $13,   $12,    1       # if second button high, then break
j guessLoop                 # else continue loop

draw:
wli                  0
#------- Get Random Dice values -------#
lrs  $3,    $0,      0
noop
noop
noop
rem  $22,   $3,     $2      # $22 = $3 % 5
rem  $22,   $3,     $2
rem  $22,   $3,     $2
rem  $22,   $3,     $2
rem  $22,   $3,     $2
rem  $22,   $3,     $2
noop
noop
noop
add  $3,    $22,    $0
#jal printNumber

lrs  $4,    $0,      0
noop
noop
noop
rem  $22,   $4,     $2      # $22 = $4 % 5
rem  $22,   $4,     $2
rem  $22,   $4,     $2
rem  $22,   $4,     $2
rem  $22,   $4,     $2
rem  $22,   $4,     $2
noop
noop
noop
add  $4,    $22,    $0
#jal printNumber

#-------------- Draw Dice -------------#
# args  $3 - w | $4 - h | $5 - x | $6 - y | $12 - p_start
# uses  $1, $2, $7, $8, $9, $10, $11

sw      $1,     1000($0)
sw      $2,     1001($0)
sw      $3,     1002($0)
sw      $4,     1003($0)
sw      $5,     1004($0)
sw      $6,     1005($0)
sw      $7,     1006($0)
sw      $8,     1007($0)
sw      $9,     1008($0)
sw      $10,    1009($0)
sw      $11,    1010($0)
sw      $12,    1011($0)
sw      $13,    1012($0)
sw      $14,    1013($0)
sw      $15,    1014($0)
sw      $31,    1015($0)

#------------- Roll Dice --------------#

addi    $13,    $0,     0       # roll_i = 0;
addi    $14,    $0,     10      # roll_lim = 0;
rollDice:
addi    $23,    $0,     5000
jal Sleep
lw      $2,     1001($0)
noop
noop
noop
rem     $22,    $13,    $2      # dn = roll_i % 5
rem     $22,    $13,    $2
rem     $22,    $13,    $2
rem     $22,    $13,    $2
rem     $22,    $13,    $2
rem     $22,    $13,    $2

addi    $3,     $0,     22      # img_w = 20
addi    $4,     $0,     22      # img_h = 20
addi    $5,     $0,     280     # img_x = 100
addi    $6,     $0,     220     # img_y = 100
lw      $12,    400($22)          # p_addr = dmem(400)
jal DrawFunction

addi    $3,     $0,     22      # img_w = 20
addi    $4,     $0,     22      # img_h = 20
addi    $5,     $0,     360     # img_x = 100
addi    $6,     $0,     220     # img_y = 100
lw      $12,    400($22)          # p_addr = dmem(400)
jal DrawFunction

addi    $13,    $13,    1       # i++
beq     $14,    $13,    1       # if i == lim break
j  rollDice                     # else continue loop


#----------- Draw Final Dice ----------#
lw      $3,     1002($0)
lw      $4,     1003($0)

addi    $13,    $3,     400     # get dice lookup
addi    $14,    $4,     400      

addi    $3,     $0,     22      # img_w = 20
addi    $4,     $0,     22      # img_h = 20
addi    $5,     $0,     280     # img_x = 100
addi    $6,     $0,     220     # img_y = 100
lw      $12,    0($13)          # p_addr = dmem(400)
jal DrawFunction

addi    $3,     $0,     22      # img_w = 20
addi    $4,     $0,     22      # img_h = 20
addi    $5,     $0,     360     # img_x = 100
addi    $6,     $0,     220     # img_y = 100
lw      $12,    0($14)          # p_addr = dmem(400)
jal DrawFunction

lw      $1,     1000($0)
lw      $2,     1001($0)
lw      $3,     1002($0)
lw      $4,     1003($0)
lw      $5,     1004($0)
lw      $6,     1005($0)
lw      $7,     1006($0)
lw      $8,     1007($0)
lw      $9,     1008($0)
lw      $10,    1009($0)
lw      $11,    1010($0)
lw      $12,    1011($0)
lw      $13,    1012($0)
lw      $14,    1013($0)
sw      $15,    1014($0)
sw      $31,    1015($0)

#-------- Calculate sum parity --------#
add  $8,    $4,     $3      # sum = i + j;
noop
noop
noop
and  $9,    $8,     $6      # par = sum & odd_bitmask
noop 
noop
noop
addi $8,    $8,     2       # add 2 to "1 index" dice

wli                 0
wli                 S
wli                 u
wli                 m
wli                 58      # colon

add  $22,   $8,     $0      # print sum!
jal printNumber
noop
wli                 32

bne  $9,    $1,     1       # if (par == 1) then odd
jal printHan                # disp("Han")
bne  $9,    $0,     1       # if (par == 0) then even
jal printCho                # disp("Cho")

noop
wli                 !

waitInputB: noop            # wait for user input
wp 	 $25					# update(input)
and  $11,   $25,    $6      
noop
noop
noop
bne  $11,   $7,     1       # if (input != old_input) break
j    waitInputB             # else continue loop
add  $7,    $11,    $0      # old_input = new_input

#---------- Print good guest ----------#
wli                 0       # clear lcd

beq  $15,   $9,     2       # if guess != par
jal printBadGuess           # print printBadGuess
j   waitInputA

jal printGoodGuess          # else print goodGuess and 
addi  $14,   $14,    1       # increment score

waitInputA: noop            # wait for user input
wp   $25                    # update(input)
and  $11,   $25,     $6     
noop
noop
noop
bne  $11,   $7,     1       # if (input != old_input) break
j    waitInputA             # else continue loop
add  $7,    $11,    $0      # old_input = new_input

addi $10,   $10,    1       # counter++
beq  $10,    $5,    1       # if (counter == roundLimit) break
j DiceRollRound             # else continue

#------------- Print score -------------#
wli                 0
wli                 S 
wli                 c 
wli                 o
wli                 r 
wli                 e
wli                 58
wli                 32

add  $22,   $14,    $0
jal  printNumber

waitInputF: noop            # wait for user input
wp   $25                    # update(input)
and  $11,   $25,     $6     
noop
noop
noop
bne  $11,   $7,     1       # if (input != old_input) break
j    waitInputF             # else continue loop
add  $7,    $11,    $0      # old_input = new_input

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
wli 					48	# disp('0')

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
wli 					57	# disp('9')

addi	$23, 	$0, 	10
bne		$22, 	$23, 	3	# if arg = 10
noop
wli 					49	# disp('10')
wli 					58

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

#------------------------------- Sleep Function -------------------------------#

Sleep: noop                     # args: $22
                                # uses: $23
sll     $23,    $23,    4
addi    $22,    $0,     0       # i == 0;
sleepLoop:
noop
noop
noop
noop
addi    $22,    $22,    1
beq     $23,    $22,    1
j   sleepLoop

jr $31

DrawFunction: noop              # args  $3 - w | $4 - h | $5 - x | $6 - y | $12 - pmem_start
                                # uses  $1, $2, $7, $8, $9, $10, $11

addi    $1,     $0,     640     # scr_w = 640
addi    $2,     $0,     480     # scr_h = 480
addi    $10,    $0,     0       # color = 0;

#--------- Calc start address ---------#

mult    $7,     $6,     $1      # start = (img_y * scr_w) + img_x
mult    $7,     $6,     $1
mult    $7,     $6,     $1
mult    $7,     $6,     $1
add     $7,     $7,     $5
add     $11,    $7,     $0      # address = start

#------------- Draw Image -------------#

addi    $9,     $0,     0       # j = 0
drawLoopJ:

addi    $8,     $0,     0       # i = 0
drawLoopI:
lp      $10,    0($12)          # color = pmem(p_addr)
lp      $10,    0($12)          # color = pmem(p_addr)
addi    $12,    $12,    1       # p_addr ++
sv      $10,    0($11)          # vmem(start) = 3

addi    $11,    $11,    1       # addr++
addi    $10,    $10,    1       # color++
addi    $8,     $8,     1       # i++

beq     $8,     $3,     1       # if i != img_w break
j drawLoopI                     # else continue loop

add     $7,     $7,     $1      # start += scr_w
add     $11,    $7,     $0      # addr = start
addi    $9,     $9,     1       # j++

beq     $9,     $4,     1       # if j != img_h break
j drawLoopJ                     # else continue loop

jr $31