noop # Flush Test

addi    $1,     0,     0       # $1 = 0
addi    $3,     0,     1       # $ = 1
noop                           # add noops to ensure write
noop
noop
noop

addi    $2,     0,     1 
beq     $0,     $0,    1       # guarantee branch
j END                          # should never happen
wli                   31       # disp('1')

beq     $2,     $3,    6       # should branch if $2 writes     
noop
noop
noop
wli                    F       # disp('F')
j END
noop

wli                    S       # disp('S')

END: j END