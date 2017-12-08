#------------------------------- Draw Function --------------------------------#

noop 							# Draw arbitrary

addi 	$3, 	$0, 	22		# img_w = 20
addi	$4, 	$0, 	22 		# img_h = 20
addi	$5, 	$0,		280		# img_x = 100
addi 	$6, 	$0, 	220 	# img_y = 100
lw 		$12, 	404($0) 		# p_addr = dmem(400)
jal DrawFunction

addi 	$3, 	$0, 	22		# img_w = 20
addi	$4, 	$0, 	22 		# img_h = 20
addi	$5, 	$0,		360		# img_x = 100
addi 	$6, 	$0, 	220 	# img_y = 100
lw 		$12, 	405($0) 		# p_addr = dmem(400)
jal DrawFunction

END: j END

DrawFunction: noop				# args  $3 - w | $4 - h | $5 - x | $6 - y | $12 - pmem_start
								# uses  $1, $2, $7, $8, $9, $10, $11

addi	$1,		$0, 	640 	# scr_w = 640
addi 	$2, 	$0, 	480 	# scr_h = 480
addi 	$10, 	$0, 	0		# color = 0;

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
lp 		$10, 	0($12)			# color = pmem(p_addr)
lp 		$10, 	0($12)			# color = pmem(p_addr)
addi 	$12, 	$12, 	1 		# p_addr ++
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

jr $31