nop # Test load pixel instruction

# Write test values to register
addi    $1  $0  1       # $1 = 1
addi    $2  $0  2       # $2 = 2
addi    $3  $0  3       # $3 = 3

## Test $4 == 0

addi    $4  $0  0       # $4 = 0
beq     $4  $0  1       # end if $4 != 0
j       end
wli     A

## Test $4 == 1

wli     32
addi    $4  $4  1       # $4++
beq     $4  $1  1       # end if $4 != 1
j       end
wli     B

## Test $4 == 2

wli     32
addi    $4  $4  1       # $4++
beq     $4  $2  1       # end if $4 != 2
j       end
wli     C

## Test $4 == 3

wli     32
addi    $4  $4  1       # $4++
beq     $4  $3  1       # end if $4 != 3
j       end
wli     D

end: j  end