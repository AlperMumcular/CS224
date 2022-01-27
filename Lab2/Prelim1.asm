	.text
__start:
	la $a0, intro
	li $v0, 4
	syscall
	
	sw $a0, inputAddr 
	li $a1, 11 # space 10 + 1 (enter)
	la $a0, inputAddr
	li $v0, 8 
	syscall
	
	la $t0, inputAddr # t0 -> address
	j calculate

# gives an error
error:
	la $a0, errorMessage
	li $v0, 4
	syscall
	
	j programEnd

# prints the result
result:
	la $a0 , decimalMessage
	li $v0 ,4
	syscall
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	la $a0, newLine
	li $v0, 4
	syscall
	j __start

# ends the program
programEnd:
	li $v0, 10
	syscall

# converts octal number to its decimal value
calculate:
	next:
		lbu $t1, 0($t0) # t1 char
		blt $t1, 10, end # after enter
		addi $t0, $t0, 1
		j next
	
	end:
		subi $t0, $t0, 2 # null and enter
		
	addi $t2, $0, 1
	addi $t3, $0, 0 # result
	
	octal:
		blt $t0, $a0, result
		lbu $t1, 0($t0)
		ble $t1, 47, error
		bge $t1, 56, error
		subi $t1, $t1, 48
		mul $t1, $t1, $t2
		mul $t2, $t2, 8
		add $t3, $t1, $t3
		subi $t0, $t0, 1
		j octal		
	j result
	.data
inputAddr: .space 10
intro: .asciiz "\nPlease enter an octal number: "
decimalMessage: .asciiz "It's decimal representation is: "
newLine: .asciiz "\n"
errorMessage: .asciiz "You have entered false octal representation."

