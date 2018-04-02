noop                            # Shufle Test

#----------------------------------- Set up -----------------------------------#

addi    $29,    $0,     4095    # sp = 4095
addi    $29,    $29,    -52     # sp -= 52
add     $8,     $29,    $0      # fp = sp      
addi    $9,     $0,     51      # limit = 51
addi    $10,    $0,     0       # i = 0;
sw      $10,    0($8)           # vmem(fp) = i;

writeDeck: noop                 # loop over cards
addi    $8,     $8,     1       # fp++;
sw      $10,    0($8)           # vmem(fp) = i
addi    $10,    $10,    1       # i++
beq     $9,     $10,    1       # if (i == limit) break
j writeDeck                     # else continue

addi    $2,     $29,    8       # rand  = sp + 8
addi    $3,     $29,    1       # start = sp + 1;
addi    $4,     $29,    52      # last  = sp + 52
addi    $10,    $0,     1       # i = 1

shuffleDeck: noop               # shuffle cards
lw      $7,     0($2)           # card_a = vmem(rand)
lw      $5,     0($4)           # card_b = vmem(last)
sw      $7,     0($4)           # vmem(last) = card_a
sw      $5,     0($2)           # vmem(rand) = card_b
addi    $4,     $4,     -1      # last--  
beq     $4,     $3,     1       # if (last == start) break
j shuffleDeck                   # else continue

#------------------------------ Read and display ------------------------------#

addi    $1,     $29,    0       # cp = sp
addi    $2,     $29,    32      # limit = sp + 52

readDeck: noop                  # read and display cards
lw      $3,     0($1)           # curr = vmem(cp)
addi    $1,     $1,     1       # cp++
wlr     $3                      # disp(curr)
beq     $1,     $2,     1       # if (cp == limit) break
j readDeck                      # else continue

#---------------------------------- End Prog ----------------------------------#
END: J END