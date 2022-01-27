	.text
__start:
	# wants to a value from the user
	li $v0, 4
	la $a0, aMessage
	syscall
	
	li $v0, 5
	syscall
	sw $v0, a
	
	# wants to b value from the user
	li $v0, 4
	la $a0, bMessage
	syscall
	
	li $v0, 5
	syscall
	sw $v0, bb
	
	# wants to c value from the user
	li $v0, 4
	la $a0, cMessage
	syscall
	
	li $v0, 5
	syscall
	sw $v0, c
	
	# regs
	# $t0 --> value of a
	# $t1 --> value of b
	# $t2 --> value of c
	lw $t0, a ###
	lw $t1, bb
	lw $t2, c
	jal remainder # calculates remainder
	
	# prints x value
	li $v0, 4
	la $a0, xMessage
	syscall
	
	li $v0, 1
	lw $a0, x
	syscall
	
	# end the program
	li $v0, 10	
	syscall

# the method that calculates the remainder of x = ( a x ( b - c ) ) % 8
remainder:
	sub $t3, $t1, $2 # $t3 = ( b - c )
	mul $t4, $t0, $t3 # $t4 = a* (b-c)
	addi $t5, $0, 8
	#div $t4, $t5
	#mfhi $t6
	rem $t6, $t4, $t5
	
	blt $t6, $0, negative
	#blt $t4, $0, negative
	#negative:
	#	addi $t4, $t4, 8
	#	blt $t4, $0, negative
	#bgt $t4, 8, decrement
	#decrement:
	#	subi $t4, $t4, 8
	#	bge $t4, 8, decrement
cont:
	move $v0, $t6
	sw $v0, x
	jr $ra

negative:
	addi $t6, $t6, 8
	blt $t6, $0, negative
	j cont
	.data
x: .word 0
a: .word 0
bb: .word 0
c: .word 0
aMessage: .asciiz "Enter a value: "
bMessage: .asciiz "Enter b value: "
cMessage: .asciiz "Enter c value: "
xMessage: .asciiz "Value of x is: "
