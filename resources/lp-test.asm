noop # Test load pixel instruction

# Write test values to register
addi    $1  $0  1      	# $1 = 1
addi 	$2	$0	2		# $2 = 2;
addi 	$3  $0 	3		# $3 = 3;

addi 	$5  $0  0		# i = 0
addi 	$6  $0  32		# lim = 32

printValues:
lp    	$4  0($5)       # pixel = pmem(i)
noop
noop
noop

beq     $4  $0  3       # continue if $4 != 0
noop
wli 	48
j       endPrintValues
beq     $4  $1  3       # continue if $4 != 1
noop
wli 	49
j       endPrintValues
beq     $4  $2  3       # continue if $4 != 2
noop
wli 	50
j       endPrintValues
beq     $4  $3  3       # continue if $4 != 3
noop
wli 	51
j       endPrintValues

endPrintValues:
addi 	$5	$5		1	# i++
beq 	$5	$6		1 	# if i == lim break
j printValues			# else continue

end: j  end