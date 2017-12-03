.data

.text

main:

noop                # War game

noop                # Write deck to memory
addi $1, $0, 0      # d1_ptr = 0
addi $2, $0, 52     # d2_ptr = 0

addi $3, $0, 0      # i = 0
addi $4, $0, 52     # limit = 52     

writeCards: 
sw   $3, 0($)       # *d1_ptr = i
sw   $3, 0($)       # *d2_ptr = i
addi $3, $3, 1      # i++;

beq  $3, $4, 1      # if (limit == i) break
j   writeCards      # continue loop


END: j END