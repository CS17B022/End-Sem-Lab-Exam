sum:				#returns sum(n)
addiu $sp, $sp, -8
sw $ra, 0($sp)
sw $a0, 4($sp)

beq $a0, $0, done	#base case n==0
addi $a0, $a0, -1	#n-1
jal sum				#returns sum(n-1)
lw $a0, 4($sp)
add $v0, $v0, $a0	#sum(n) = sum(n-1) + n
j finish

done:
lw $a0, 4($sp)
add $v0, $0, $0
j finish

finish:
lw $ra, 0($sp)
addiu $sp, $sp, 8
jr $ra

main:
li $s0, 10			#given number n in s0
add $a0, $s0, $0
jal sum
add $s1, $v0, $0	#result in s1
li $v0, 10
syscall