	# $t7 ---> selection
	.text
__start:
	# getting size of the array
	li $v0, 4
	la $a0, sizeMessage
	syscall
	
	li $v0, 5 
	syscall
	sw $v0, size
	
	# getting elements
	lw $t0, size # t0 --> size
	la $t1, array # t1 --> first index
	add $t2, $0, $0
	
	li $v0, 4
	la $a0, arrayMessage
	syscall
	
	elements:
		li $v0, 5
		syscall
		sw $v0, 0($t1)
		addi $t2, $t2, 1 # t2 --> current size
		addi $t1, $t1, 4
		blt $t2, $t0, elements
	la $t1, array
	
	
	jal select
	
	##### burada kald?m
	

option1:
	addi $t4, $0, 0
	
	li $v0, 4
	la $a0, option1Message
	syscall
	
	li $v0, 5 
	syscall
	sw $v0, input
	
	lw $t6, input # t6 --> input
	
	la $t1, array
	addi $t2, $0, 0
	count:
		lw $t5, 0($t1) # t5 --> array[i]
		bgt $t5, $t6, increment
		ble $t5, $t6, skip
		increment:
			add $t4, $t4, $t5 # t4 ---> summation
		skip:
			
		addi $t2, $t2, 1
		addi $t1, $t1, 4
		blt $t2, $t0, count
		
	# printing result
	li $v0, 4
	la $a0, option1Message2
	syscall
	
	sw $t4, option1Result
	lw $a0, option1Result
	
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	jal select
option2:	
	addi $t3, $0, 0 # t3 --> odd numbers
	addi $t4, $0, 0 # t4 --> even numbers
	
	la $t1, array # t1 --> first index
	addi $t2, $0, 0
	addi $t6, $0, 2 
	addi $t8, $0, 1
	addi $t9, $0, -1
	funct:
		bge $t2, $t0, cont
		lw $t5, 0($t1)
		div $t5, $t6
		mfhi $t7 # remainder from 2
		beq $t7, $0, even
		beq $t7, $t8, odd
		beq $t7, $t9, odd
		blt $t2, $t0, funct
cont:	
	# printing summation of odd numbers 
	li $v0, 4
	la $a0, oddMessage
	syscall
	
	move $a0, $t3
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	# printing summation of even numbers
	li $v0, 4
	la $a0, evenMessage
	syscall
	
	move $a0, $t4
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	jal select
	
even:
	add $t4, $t4, $t5
	addi $t1, $t1, 4
	addi $t2, $t2, 1
	j funct
odd:
	add $t3, $t3, $t5
	addi $t1, $t1, 4
	addi $t2, $t2, 1
	j funct
option3:	

	addi $t7, $0, 0 # t5 --> no of occurrences
	
	li $v0, 4
	la $a0, option1Message
	syscall
	
	li $v0, 5 
	syscall
	sw $v0, input
	
	lw $t6, input
	la $t1, array
	addi $t2, $0, 0
	
	divCount:
		bge $t2, $t0, resume
		lw $t5, 0($t1) # t5 --> array[i]
		div $t5, $t6
		mfhi $t8 # t8 --> remainder
		addi $t1, $t1, 4
		addi $t2, $t2, 1
		beq $t8, 0, inc
		bne $t8, 0, divCount
resume:
	# printing the result
	li $v0, 4
	la $a0, option4Message
	syscall
	
	move $a0, $t7
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	jal select

inc:
	addi $t7, $t7, 1
	j divCount

option4:
	li $v0, 10
	syscall
	
select:
	li $v0, 4
	la $a0, aMessage
	syscall
	
	la $a0, bMessage
	syscall
	
	la $a0, cMessage
	syscall
	
	la $a0, dMessage
	syscall
	
	li $v0, 5 
	syscall
	sw $v0, selection
	
	lw $t7, selection
	
	beq $t7, 1, option1
	beq $t7, 2, option2
	beq $t7, 3, option3
	beq $t7, 4, option4
	
	jr $ra
	
	.data
aMessage: .asciiz "1- Find summation of numbers stored in the array which is greater than an input number.\n"
bMessage: .asciiz "2- Find summation of even and odd numbers and display them.\n"
cMessage: .asciiz "3- Display the number of occurrences of the array elements divisible by a certain input number.\n"
dMessage: .asciiz "4- Quit.\n"
sizeMessage: .asciiz "Enter the size of the array:\n"
arrayMessage: .asciiz "Enter the values of the array.\n"
option1Message: .asciiz "Enter a value:\n"
option1Message2: .asciiz "Summation: "
oddMessage: .asciiz "Summation of odd numbers: "
evenMessage: .asciiz "Summation of even numbers: "
option4Message: .asciiz "Number of occurrences of the array elements divisible by a certain input number: "
newLine: .asciiz "\n"
option1Result: .word 0
selection: .word 0
array: .space 400
size: .word 0
input: .word 0
