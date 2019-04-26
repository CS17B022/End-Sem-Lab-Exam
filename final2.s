.data

database: .ascii "ATGCTGCAATCGTACTAGGCCATGCAATGCAG"
input: .ascii "CTAGG"
inputsize: .word 5

.text
main:
la $s0, database
la $s1, input
la $t0, inputsize
lw $s2, 0($t0)
li $s3, 0 		#presence
li $s4, 32		#databse size
sub $s4, $s4, $s2	#databse size-inputsize+1

li $t0, 0		#outerloop counter	#i=0
li $t1, 0		#inner loop counter	#j=0
li $t2, 0		#database address inside loop
li $t3, 0		#input address inside loop
li $t4, 0 		#count

outerloop:
beq $t0, $s4, exit
add $t7, $s0, $0
add $t7, $t7, $t0	#database+i address
add $t8, $s1, $0	#input address
li $t4, 0			#count=0
li $t1, 0			#j=0

innerloop:
beq $t1, $s2, exit1
add $t2, $t7, $t1	#database+i+j address
add $t3, $t8, $t1	#input+j address
lb $t5, 0($t2)		#database[i+j]
lb $t6, 0($t3)		#input[j]
beq $t5, $t6, match	#if database[i+j]==input[j] then go to match
addi $t1, $t1, 1
j innerloop

match:
addi $t4, $t4, 1	#increase count by 1
addi $t1, $t1, 1
j innerloop

exit1:
beq $t4, $s2, done	#if count==inputsize then go to done
addi $t0, $t0, 1
j outerloop

done:
addi $s3, $s3, 1	#presence = 1
j exit


exit:
li $v0, 10
syscall