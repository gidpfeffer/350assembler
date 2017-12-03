noop                        # War program
noop                        # Write cards to memory
addi $3,    $0,     0       # i = 0
addi $4,    $0,     51      # limit = 51    

WriteCards: noop            # write each card
sw   $3,    0($s3)          # *i = i
sw   $3,    52($3)          # *(i+52) = i
addi $3,    $3,     1       # i++;
beq  $3,    $4,     1       # if (limit == i) break
j   WriteCards              # continue loop

ShuffleCards: noop          # Shuffle the cards in memory
noop                        # TODO

noop                        # Compare each card
addi $3,    $0,     0       # i = 0;
addi $4,    $0,     51      # limit = 51

addi $5,    $0,     0       # p1Score = 0
addi $6,    $0,     0       # p2Score = 0

CompareCards: noop          # iterate over both decks
lw   $1,    0($3)           # c1 = *i
lw   $2,    0($3)           # c2 = *i
addi $3,    $3,     1       # i++
beq  $1,    $2,     4       # if (c1 == c2) 
noop
noop
noop
wli                 T       # disp('T')
blt  $1,    $2,     4       # if (c1 < c2)
addi $6,    $0,     1       # p2Score++
noop
noop
wli                 A       # disp('A')
blt  $2,    $1,     4       # if (c2 < c1)
addi $6,    $0,     1       # p1Score++
noop
noop
wli                 B       # disp('B')
beq  $3,    $4,     1       # if (limit == i) break
j CompareCards              # continue loop

wli                 32      # disp(' ')
blt  $6,    $5,     4       # if (p2Score < p1Score)
noop
noop
noop
wli                 35      # disp('5')
blt  $5,    $6,     4       # if (p1Score > p2Score)
noop
noop
noop
wli                 36      # disp('6')
beq  $5,    $6,     4       # if (p1Score == p2Score)
noop
noop
noop
wli                 T       # disp("Tie")
wli                 i 
wli                 e 

END: j END                  # End program