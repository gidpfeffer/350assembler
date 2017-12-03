### Instruction Test

wli     T
wli     e
wli     s
wli     t
wli     12

## A: addi + beq test
addi    $1,    $0,      1       # $1 = 1
addi    $2,    $0,      1       # $2 = 1

beq     $1,     $2,     4       # Pass
nop
nop
nop
wli     P
j       endTestA
wli     F


endTestA: