noop                        # beq-test

addi $1,    $0,     3       # x = 3

beq  $1,    $1,     3
noop
wli                 B 
wli                 C
wli                 D
wli                 E
wli                 F
wli                 12

bne $1,     $1,     3
noop
wli                 B 
wli                 C
wli                 D
wli                 E
wli                 F

blt $1,     $0      3
noop
wli                 B 
wli                 C
wli                 D
wli                 E
wli                 F

END: j END