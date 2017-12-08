#--------------------------------- Slots Game ---------------------------------#
StartSlots: noop				# slots 

#------------ Setup screen ------------#
# DrawTechnicolor border
addi 	$3, 	$0, 	640		# img_w = 640
addi	$4, 	$0, 	480 	# img_h = 480
addi	$5, 	$0,		0		# img_x = 0
addi 	$6, 	$0, 	0		# img_y = 0
addi	$10, 	$0, 	0 		# color = 0
jal DrawTechnicolor

# Draw Black slots screen
addi 	$3, 	$0, 	480		# img_w = 480
addi	$4, 	$0, 	240 	# img_h = 240
addi	$5, 	$0,		80		# img_x = 80
addi 	$6, 	$0, 	120 	# img_y = 120
addi	$10, 	$0, 	0 		# color = 0
jal DrawBlockFunction

#-------------- Game Loop -------------#
addi 	$24, 	$0, 	0		# old_input = 0;
addi 	$1,		$0, 	0 		# i = 0
addi 	$2, 	$0, 	10		# rounds = 10
addi 	$3, 	$0, 	0		# j = 0

SlotsGameLoop:

sw 		$1,  	1000($0) 		# save $1-3 in memory
sw 		$2, 	1001($0)
sw 		$3, 	1002($0)

addi 	$10, 	$0, 	0 		# color = 0
addi 	$12, 	$0, 	1 		# set limit to 32'd1
noop
noop
noop
sll 	$12, 	$12, 	5 		# limit = limit * 2^5

addi 	$15, 	$0, 	0		# stop1 = 0
addi 	$16, 	$0, 	0 		# stop2 = 0
addi 	$17, 	$0, 	0		# stop3 = 0
addi 	$21, 	$0, 	0		# event_enum = 0

SlotsPrintLoop:
# Iterate over colors
lrs 	$20, 	$0, 	0
noop
noop
noop
add 	$10, 	$10, 	$20		# color += lfsr.read();
addi 	$3, 	$0, 	3 		# bitmask3 = 3
noop
noop
noop
and 	$4, 	$3, 	$10 	# last_two_bits = bitmask3 & color
noop
noop
noop
bne 	$4, 	$0, 	1 		# if color != black skip
addi 	$10, 	$10,   	1 		# else color++

bne 	$15, 	$0, 	5 		# when set skip draw
# Draw Slot 1 screen
addi 	$3, 	$0, 	80		# img_w = 80
addi	$4, 	$0, 	120 	# img_h = 120
addi	$5, 	$0,		140		# img_x = 140
addi 	$6, 	$0, 	180 	# img_y = 180
jal DrawBlockFunction

bne 	$16, 	$0, 	5		# when set skip draw
# Draw Slot 2 screen
addi 	$3, 	$0, 	80		# img_w = 80
addi	$4, 	$0, 	120 	# img_h = 120
addi	$5, 	$0,		280		# img_x = 280
addi 	$6, 	$0, 	180 	# img_y = 180
jal DrawBlockFunction

# Draw Slot 3 screen
bne 	$17, 	$0, 	5
addi 	$3, 	$0, 	80		# img_w = 80
addi	$4, 	$0, 	120 	# img_h = 120
addi	$5, 	$0,		420		# img_x = 420
addi 	$6, 	$0, 	180 	# img_y = 180
jal DrawBlockFunction

addi 	$23, 	$0, 	10000
jal 	Sleep

beq 	$17, 	$0, 	1 		# if start3 set, then end loop
j 		EndSlotsPrintLoop
noop 		

addi 	$3, 	$0, 	3 		# bitmask3 = 3
and 	$4, 	$3, 	$10 	# last_two_bits = bitmask3 & color

# Determine stop logic
addi 	$20, 	$0, 	25 		# rem = color % 25
rem 	$19, 	$10, 	$20
rem 	$19, 	$10, 	$20
rem 	$19, 	$10, 	$20
rem 	$19, 	$10, 	$20
rem 	$19, 	$10, 	$20
rem 	$19, 	$10, 	$20
rem 	$19, 	$10, 	$20
rem 	$19, 	$10, 	$20
noop
noop
noop
addi 	$20, 	$0, 	24
bne 	$20, 	$19, 	23 		# if (rem == 24)
addi 	$21, 	$21, 	1 		# event++
noop 							#--------------------------#
addi 	$20, 	$0, 	1 	
noop
noop
noop
bne 	$20, 	$21, 	1		# if (event == 1)
add 	$15, 	$4,		$0 		# then stop1 = color
noop 							# -------------------------#
addi 	$20, 	$0, 	2
noop
noop
noop
bne 	$20, 	$21, 	1 		# if (event == 2)
add 	$16, 	$4, 	$0 		# then stop2 = color
noop 							#--------------------------#
addi 	$20, 	$0, 	3
noop
noop
noop
bne		$20, 	$21, 	1 		# if (event == 3)
add 	$17, 	$4, 	$0 		# then stop3 = color
noop 							#--- end if (rem == 24) ---#
noop							# Noop sled
noop
noop
noop

j 	SlotsPrintLoop 				# continue loop

EndSlotsPrintLoop:

lw 		$1,  	1000($0)
lw 		$2, 	1001($0)
lw 		$3, 	1002($0)

#---------- Calculate score -----------#
wli 					0
#add 	$22,	$15, 	$0
#jal 	printNumber
#add 	$22,	$16, 	$0
#jal 	printNumber
#add 	$22,	$17, 	$0
#jal		printNumber

addi 	$20, 	$0, 	0		# Score = 0
noop 							# initialize the score
noop
noop
bne 	$15, 	$16, 	1 		# if first == second
addi 	$20, 	$20, 	2		# score += 2
noop
noop
noop
bne 	$16,	$17, 	1 		# if second == third
addi 	$20, 	$20, 	2 		# score += 2

wli 					S
wli 					c
wli 					o
wli 					r
wli 					e
wli 					58

addi 	$22, 	$20, 	0		
jal 	printNumber
nooop
wli 					!

wli 					32
wli 					32
wli 					32
wli 					32
wli 					32
wli 					32
wli 					32
wli 					32

addi 	$21,  	$0, 	4
bne 	$20, 	$21, 	9
noop
wli 					J
wli 					A 
wli 					C
wli 					K
wli 					P
wli 					O
wli 					T
wli 					!

#------------ Print Score -------------#


waitInputA: noop            	# wait for user input
wp   	$25                    	# update(input)
addi 	$26, 	$0, 	1 		# zeroeth bitmask
noop
noop
and  	$27,   $26,     $25    	# new_input = bitmask & input
noop
noop
noop
bne  	$24,   $27,     1       # if (input != old_input) break
j waitInputA             		# else continue loop
add  	$24,   $27,     $0      # old_input = new_input

addi 	$1, 	$1, 	1
beq 	$1, 	$2 		1 		# if (i == roundLimit) break
j 	SlotsGameLoop 				# else continue loop

END: j END


#------------------------------- Draw Function --------------------------------#
DrawTechnicolor: noop			# args  $3 - w | $4 - h | $5 - x | $6 - y | $10 - color
								# uses  $1, $2, $7, $8, $9, $10

addi	$1,		$0, 	640 	# scr_w = 640
addi 	$2, 	$0, 	480 	# scr_h = 480

#--------- Calc start address ---------#

mult 	$7, 	$6, 	$1 		# start = (img_y * scr_w) + img_x
mult 	$7, 	$6, 	$1
mult 	$7, 	$6, 	$1
mult 	$7, 	$6, 	$1
add  	$7, 	$7, 	$5
add 	$11, 	$7, 	$0 		# address = start

#------------- Draw Image -------------#

addi 	$9, 	$0, 	0		# j = 0
drawTechnicolorLoopJ:

addi 	$8, 	$0, 	0		# i = 0
drawTechnicolorLoopI:
sv 		$10, 	0($11) 			# vmem(start) = 3
addi 	$11, 	$11, 	1 		# addr++
addi 	$10, 	$10, 	1 		# color++
addi 	$8, 	$8, 	1 		# i++

beq 	$8, 	$3, 	1 		# if i != img_w break
j drawTechnicolorLoopI 			# else continue loop

add 	$7, 	$7, 	$1 		# start += scr_w
add 	$11, 	$7, 	$0  	# addr = start
addi 	$9, 	$9, 	1 		# j++

beq 	$9, 	$4, 	1 		# if j != img_h break
j drawTechnicolorLoopJ 			# else continue loop

jr $31

#------------------------------- Draw Function --------------------------------#
DrawBlockFunction: noop			# args  $3 - w | $4 - h | $5 - x | $6 - y | $10 - color
								# uses  $1, $2, $7, $8, $9, $10, $11

addi	$1,		$0, 	640 	# scr_w = 640
addi 	$2, 	$0, 	480 	# scr_h = 480

#--------- Calc start address ---------#

mult 	$7, 	$6, 	$1 		# start = (img_y * scr_w) + img_x
mult 	$7, 	$6, 	$1
mult 	$7, 	$6, 	$1
mult 	$7, 	$6, 	$1
add  	$7, 	$7, 	$5
add 	$11, 	$7, 	$0 		# address = start

#------------- Draw Image -------------#

addi 	$9, 	$0, 	0		# j = 0
drawBlockLoopJ:

addi 	$8, 	$0, 	0		# i = 0
drawBlockLoopI:
sv 		$10, 	0($11) 			# vmem(start) = 3
addi 	$11, 	$11, 	1 		# addr++
addi 	$8, 	$8, 	1 		# i++

beq 	$8, 	$3, 	1 		# if i != img_w break
j drawBlockLoopI				# else continue loop

add 	$7, 	$7, 	$1 		# start += scr_w
add 	$11, 	$7, 	$0  	# addr = start
addi 	$9, 	$9, 	1 		# j++

beq 	$9, 	$4, 	1 		# if j != img_h break
j drawBlockLoopJ 				# else continue loop

jr $31

#------------------------------- Sleep Function -------------------------------#

Sleep: noop                     # args: $23
                                # uses: $22
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