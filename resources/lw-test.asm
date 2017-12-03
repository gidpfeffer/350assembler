# Set up while
addi    $1  $0  0           # v_addr = 0;
addi    $10 $0  5000        # limit = 5000; 


addi    $4  $0  44
lw      $3  3($0)           # addr_44 = vmem(3);
nop
nop
bne     $3  $4  1           # if ($4 != $5) print to screen
jump    end

while: nop
nop
lp      $2  0($1)           # pixel = p_mem(v_addr);
nop
nop
nop
sv      $2  0($1)           # vmem(v_addr) = pixel;
addi    $1  $1  1           # v_addr++;
nop
nop
nop
blt     $10 $1  1           # if (limit < v_addr) break;
j       while

end: 
j end