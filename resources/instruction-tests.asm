### (Almost) All Instruction Test

#------------------------------ Arithmetic Tests ------------------------------#

noop # addi test
addi    $1,    $0,      48       # $1 = 48
addi    $2,    $1,      37       # $2 = $1 + 37
addi    $3,    $0,      85       # $3 = 85

beq     $1,    $3,      3        # Pass (48 + 37 = 85)
noop
wli                     P
j   testaddi  

noop
wli                     F

testaddi:

noop # sub test   
sub     $4,    $3,      $1      # $4 = $3 - $1

beq     $4,    $0,      3       # Pass (85 - 85 = 0)
noop 
wli                     P
j testsub

noop
wli                     F

testsub: 

noop # add and sll test   
add     $5,    $3,      $3      # $5 = $3 + $3
sll     $6,    $3,      1       # $6 = 3 << 1

beq     $4,    $0,      3       # Pass (85 - 85 = 0)
noop 
wli                     P
j testaddsll

noop
wli                     F

testaddsll: 

noop # and test
and     $7,     $6,     $0      # $7 = $6 & $0   

beq     $4,     $0,      3      # Pass (85 - 85 = 0)
noop 
wli                     P
j testand

noop
wli                     F

testand:

#--------------------------- Jump and branch tests ----------------------------# 

jal     jaltestfunction
j       jaltestpass

jaltestfunction:
jr      $31
j       jaltestfail

jaltestpass:
wli                     P
j       jaltestend

jaltestfail:
wli                     F
j       jaltestend

jaltestend:

#----------------------------------- Memory -----------------------------------#

addi    $1,     $0,     0       # i = 0
addi    $2,     $0,     5     	# limit = 500

writeLoop:
sw      $1,     0($1)           # vmem(i) = i
addi    $1,     $1,     1       # i++
beq     $1,     $2,     1       # if limit == i break
j       writeLoop               # else continue

addi    $1,     $0,     0       # i = 0

readLoop:
lw      $3,     0($1)           # $2 = vmem(i)
beq     $3,     $1,     1       # if (vmem(i) == i) continue
j       memoryFail				# else break				
addi    $1,     $1,     1       # i++
beq     $1,     $2,     1       # if (limit == i) break
j       readLoop                # else continue

noop
wli                     P
j       memoryEnd

memoryFail:
wli                     F       # Fail

memoryEnd:

END: j END