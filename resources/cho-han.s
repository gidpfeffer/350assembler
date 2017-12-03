noop                        # Cho-Han Game

noop                        # Make dice roll
addi $1,    $0,     0       # i = 0;
addi $2,    $0,     6       # roundLimit = 5
addi $4,    $0,     1       # odd_bitmask = 0x00000001

DiceRollRound:
addi $1,    $1,     1       # i++
and  $3,    $1,    $4       # parity = i & odd_bitmask

beq  $3,    $1,     6       # if (parity == 1) then odd
noop 
wli                 H       # disp("Han")
wli                 a
wli                 n
beq  $3,    $0,     6       # if (parity == 0) then even
noop
wli                 C       # disp("Cho")
wli                 h
wli                 o
wli                 32
beq  $1,    $2,     1       # if (i == roundLimit) break
j DiceRollRound             # else continue

END: j END                  # end program