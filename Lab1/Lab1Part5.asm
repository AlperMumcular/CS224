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
	
	lw $t0, a # t0 --> value of a
	lw $t1, bb # t1 --> value of b
	
	div $t0, $t1
	mfhi $t2 # t2 --> a%b
	
	sub $t3, $t0, $t1 # t3 --> a-b
	
	mul $t4, $t2, $t3
	
	sw $t4, x
	
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
	
	.data
a: .word 0
bb: .word 0
x: .word 0
aMessage: .asciiz "Enter a value: "
bMessage: .asciiz "Enter b value: "
xMessage: .asciiz "Value of x is: "