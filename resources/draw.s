noop 							# Draw arbitrary

addi	$1,		$0, 	640 	# scr_w = 640
addi 	$2, 	$0, 	480 	# scr_h = 480

addi 	$3, 	$0, 	50		# img_w = 200
addi	$4, 	$0, 	50 		# img_h = 200

addi	$5, 	$0,		295		# img_x = 100
addi 	$6, 	$0, 	215 	# img_y = 100

addi 	$10, 	$0, 	3		# color = 3;

#--------- Calc start address ---------#

mult 	$7, 	$6, 	$1 		# start = (img_y * scr_w) + img_x
mult 	$7, 	$6, 	$1
mult 	$7, 	$6, 	$1
mult 	$7, 	$6, 	$1
add  	$7, 	$7, 	$5
add 	$11, 	$7, 	$0 		# address = start

#------------- Draw Image -------------#

addi 	$9, 	$0, 	0		# j = 0
drawLoopJ:

addi 	$8, 	$0, 	0		# i = 0
drawLoopI:

sv 		$10, 	0($11) 			# vmem(start) = 3

addi 	$11, 	$11, 	1 		# addr++
addi 	$10, 	$10, 	1 		# color++
addi 	$8, 	$8, 	1 		# i++

beq 	$8, 	$3, 	1 		# if i != img_w break
j drawLoopI 					# else continue loop

add 	$7, 	$7, 	$1 		# start += scr_w
add 	$11, 	$7, 	$0  	# addr = start
addi 	$9, 	$9, 	1 		# j++

beq 	$9, 	$4, 	1 		# if j != img_h break
j drawLoopJ 					# else continue loop


END: j END