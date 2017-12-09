noop                        # beq-test

addi $1,    $0,     3       # x = 3
addi $2, 	$0, 	3
noop
noop
noop

beq  $1,    $2,     3
noop
wli                 B 
wli                 C
wli                 D
wli                 E
wli                 F
wli                 32
noop
wli                 B

bne $1,     $2,     3
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
