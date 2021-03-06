	.text
__start:

# user interface and user selection
getInput:
	la $a0, inputMessage
	li $v0, 4
	syscall
	
	la $a0, quitMessage
	syscall
	
	la $a0, choiceMessage
	syscall
	
	li $v0,5
	syscall
	
	sw $v0, choice
	lw $t0, choice
	
	beq $t0, 1, getValue
	beq $t0, 2, quit
	bgt $t0, 2, getInput
	blt $t0, 1, getInput
	
# gets value from the user
getValue:
	la $a0, valueMessage
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	j switch

# ends the program
quit:
	li $v0, 10
	syscall

# switches nibbles
switch:
	addi $t4, $0, 0
	addi $a0, $t0, 0
	li $v0, 34
	syscall
	
	# r6 -> used
	# t5 -> used.
	# t4 -> switched version
	# t3 -> used
	# t2 -> used.
	# t1-> 16^n
	
	addi $t1, $0, 268435456 # 16^7
	div $t0, $t1
	mflo $t2
	mul $t3, $t2, 16777216
	mul $t6, $t2, 268435456
	sub $t0, $t0, $t6
	add $t4, $t4, $t3
	
	
	addi $t1, $0, 16777216
	div $t0, $t1
	mflo $t2
	mul $t3, $t2, 268435456
	mul $t6, $t2, 16777216
	sub $t0, $t0, $t6
	add $t4, $t4, $t3
	
	
	
	addi $t1, $0, 1048576 # 16^5
	div $t0, $t1
	mflo $t2
	mul $t3, $t2, 65536
	mul $t6, $t2, 1048576
	sub $t0, $t0, $t6
	add $t4, $t4, $t3
	
	
	addi $t1, $0, 65536
	div $t0, $t1
	mflo $t2
	mul $t3, $t2, 1048576
	mul $t6, $t2, 65536
	sub $t0, $t0, $t6
	add $t4, $t4, $t3
	
	
	
	addi $t1, $0, 4096 # 16^3
	div $t0, $t1
	mflo $t2
	mul $t3, $t2, 256
	mul $t6, $t2, 4096
	sub $t0, $t0, $t6
	add $t4, $t4, $t3
	
	
	addi $t1, $0, 256
	div $t0, $t1
	mflo $t2
	mul $t3, $t2, 4096
	mul $t6, $t2, 256
	sub $t0, $t0, $t6
	add $t4, $t4, $t3
	
	
	addi $t1, $0, 16 # 16^1
	div $t0, $t1
	mflo $t2
	mul $t3, $t2, 1
	mul $t6, $t2, 16
	sub $t0, $t0, $t6
	add $t4, $t4, $t3
	
	
	addi $t1, $0, 1
	div $t0, $t1
	mflo $t2
	mul $t3, $t2, 16
	mul $t6, $t2, 1
	sub $t0, $t0, $t6
	add $t4, $t4, $t3
	
	la $a0, newLine
	li $v0, 4
	syscall
	
	move $a0, $t4
	li $v0, 34
	syscall
	
	j getInput
	
	.data
inputMessage: .asciiz "\n1-Enter a decimal and display and switch nibbles in hexadecimal form."
quitMessage: .asciiz "\n2-Quit."
choice: .word 0
choiceMessage: .asciiz "\nYour selection: "
valueMessage: .asciiz "\nDecimal Number: "
newLine: .asciiz "\n"
