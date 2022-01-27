#Registers
# $t0 = size of the array
# $t1 = beginning of the array
# $t2 = index of the array 
# $t3 $4 = swapping purposes
	.text
__start:
	# Size message
	li $v0, 4
	la $a0, sizeMessage
	syscall
	
	# Getting input from the user
	li $v0, 5
	syscall
	sw $v0, size
	
	jal create
	jal display
	
	la $a0, 0($t0)
	jal reverse
	jal display
	
	li $v0, 10
	syscall
	
reverse:
	la $t0, array
	swap:
		lw $t3, 0($t1)
		lw $t4, 0($t0)
		sw $t3, 0($t0)
		sw $t4, 0($t1)
		addi $t0, $t0, 4
		subi $t1, $t1, 4
		bgt $t1, $t0, swap
	jr $ra
	  
display:
	la $t1, array
	lw $t0, size
	add $t2, $0, $0
	
	li $v0, 4
	la $a0, displayMessage
	syscall
	disp:
		lw $a0, ($t1)
		addi $t1, $t1, 4
		li $v0, 1
		syscall
		addi $t7, $t2, 1
		bgt $t0, $t7, spacing
		spacing:
			la $a0, space
			li $v0, 4
			syscall
		addi $t2, $t2, 1
		blt $t2, $t0, disp
	subi $t1, $t1, 4
	jr $ra
	 	
create:
	lw $t0, size
	la $t1, array
	add $t2, $0, $0
	
	# values
	la $a0, itemMessage
	li $v0, 4
	syscall
	
	inputs:
		li $v0, 5
		syscall
		sw $v0, 0($t1)
		addi $t2, $t2, 1
		addi $t1, $t1, 4
		blt $t2, $t0, inputs
	jr $ra
	
  
			
	.data
sizeMessage: .asciiz "Please enter the size of the array:"
size: .word 0
array: .space 80 #20 x 4 =80
displayMessage: .asciiz "\n Array: \n"
itemMessage: .asciiz "Array items:"
space: .asciiz " "
