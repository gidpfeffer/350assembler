#----------------------------------- Select -----------------------------------#
noop

addi $24, 	$0, 	0		# old_input = 0;

SelectGameLoop:
jal printChoHan
jal waitForUserToggle

jal printWar
jal waitForUserToggle

# Read user input and jump if start toggled

jal printBlackjack
jal waitForUserToggle

j SelectGameLoop

END: j END

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

