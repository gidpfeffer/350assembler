#----------------------------------- Select -----------------------------------#
noop							# Casino Game Selection Menu
lss  	$0,		$31,	0		# seed lfsr to PC


addi $24, 	$0, 	0		# old_input = 0;
addi $1,	$0, 	0 	

SelectGameLoop:
jal printChoHan
jal waitForUserToggle

addi $1, 	$1, 	1
jal DrawBackground

jal printWar
jal waitForUserToggle

addi $1, 	$1, 	1
jal DrawBackground

jal printBlackjack
jal waitForUserToggle



addi $1, 	$1, 	1
jal DrawBackground

j SelectGameLoop

END: j END

#------------------------- waitForUserToggle Function -------------------------#
waitForUserToggle: noop 	# args = <24> use = <25>
waitInput: noop				# wait for user input
wp 	 $25					# update(input)
noop
noop
noop
noop
bne  $25,   $24,     1      # if (input != old_input) break
j    waitInput              # else continue loop
add  $24,   $25,    $0      # old_input = new_input
jr 	 $31

#--------------------------------- Menu items ---------------------------------#
printChoHan:
wli 				C   	# disp('Cho-Han')
wli 				h 		
wli 				o
wli 			   	45
wli 				H
wli 				a
wli 				n
wli 		 		32
wli 		 		B
wli 		 		a
wli 		 		k
wli 		 		u
wli 		 		c
wli 		 		h
wli 		 		i
wli 				32
jr 	 $31

printWar:
wli 				W   	# disp('Cho-Han')
wli 				a 		
wli 				r
wli 			   	32
wli 				32
wli 				32
wli 				32
wli 		 		32
wli 		 		32
wli 		 		32
wli 		 		32
wli 		 		32
wli 		 		32
wli 		 		32
wli 		 		32
wli 				32
jr 	 $31

printBlackjack:
wli 				B   	# disp('Cho-Han')
wli 				l 		
wli 				a
wli 			   	c
wli 				k
wli 				j
wli 				a
wli 		 		c
wli 		 		k
wli 		 		32
wli 		 		32
wli 		 		32
wli 		 		32
wli 		 		32
wli 		 		32
wli 				32
jr 	 $31

# Clear screen function #
jr $31


#--------------------------- DrawBackground Function --------------------------#
DrawBackground: 	noop		# args $1 - start_color
								# uses $2, $3
addi 	$2, 	$0, 	0 		# i = 0
addi 	$3, 	$0, 	38400	# 
sll 	$3, 	$3, 	3 		# lim = 307200
DrawBackgroundLoop:
sv 		$1, 	0($2) 			# vmem(i) = color
addi 	$2, 	$2, 	1 		# i++
beq 	$2, 	$3, 	1 		# if (i == lim) break
j DrawBackgroundLoop			# else continue loop
jr $31

#------------------------------- Draw Function --------------------------------#
DrawFunction: noop              # args  $3 - w | $4 - h | $5 - x | $6 - y
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