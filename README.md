# 350assembler

Disclaimer: This software is provided "as is" with no warranty expressed or implied.

**@author: pf51**  
**@date: Nov 5 2017**  
**@author: ghb51**  
**@date: May 2018**  
**@author: mdd36**  
**@date: Sep 2018**  


## About

1. **What is:** this is a simple parser that converts MIPS code into machine code using the ISA provided in the Duke ECE350 handout.
2. You need Java 10 to run this project. Find it here: https://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase10-4425482.html.   
**IMPORTANT:** Do not use Java 11, as Java 11 no longer comes with JavaFX packaged into it, and there is not good way to add the library to jar at this time. Later, I *may* add a command line jar that will work with Java 11, but for now it is unsupported. If you really want to use Java 11, you can install JavaFX 11 at the link below, but note that you'll have to set up a Maven or Gradle package manager to correctly import that library.  
https://gluonhq.com/products/javafx/
3. **How to:**   
(1) Clone or download the repo  
(2) Write your mips code in any `.s` or `.asm` file   
(3) Launch the GUI from the provided jar  
(4) Select an input folder/file and an output folder  
(5) Click launch
4. Things you **CAN** do:  
(1) Write comments using "#" to start a line,  
(2) Use noop's by typing noop  
(3) Use $rstatus as syntax,  
(4) Use $ra as syntax  
(5) Have optional trailing semicolons on lines  
(6) Use a directory as input  
(7) Have the assembler pad each instruction with noops to prevent hazards  
(8) Do labeled branching or jumping (ie, `j start`, `blt loop`)  
(9) use all other instructions in the correct syntax, found in our handout and also included below 

### Example
See folder example for what the MIPS file should look like

### Instructions

    nop
    add   $rd,   $rs,   $rt
    addi  $rd,   $rs,   N
    sub   $rd,   $rs,   $rt
    or   $rd,   $rs,   $rt
    sll   $rd,   $rs,   shamt
    sra   $rd,   $rs,   shamt
    mul   $rd,   $rd,   $rt
    div   $rd,   $rs,   $rt
    sw   $rd,   N($rs)
    lw   $rd,   N($rs)
    j   T
    bne   $rd,   $rs,   N
    jal   T
    jr   $rd
    blt   $rd,   $rs,   N
    bex   T
    setx   T

## Building and Running

### Running With Maven

If maven is already intalled on your machine, you can compile and run the application by forking the repo, cd'ing into the root directory, and running

```mvn compile exec:java```

### Running with Docker

X-forwarding is needed to display GUIs from Docker on local machines.

#### OS X

Follow guide found [here]: https://cntnr.io/running-guis-with-docker-on-mac-os-x-a14df6a76efc to set up X server on mac using socat and XQuartz. Make sure you can get xeyes to work as the guide details before moving forward. 

Once xeyes has been launched successfully, cd into the repo, build the docker image:

```docker build -t assembler .```

And run it using X forwarding

```docker run -e DISPLAY=10.197.164.115:0 assembler```

To access the files while it is running, type 

```docker ps```

to see the running docker containers. Then type:

```docker exec -it [CONTAINER ID] bash```

To launch a shell for the docker container running the assembler gui. All file can be accessed here. They can then be copy or pasted/transferred manually over the network.
