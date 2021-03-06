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
	
	# display
	la $t1, array
	add $t2, $0, $0
	
	li $v0, 4
	la $a0, display
	syscall
	
	disp:
		lw $a0, 0($t1)
		addi $t1, $t1, 4
		li $v0, 1
		syscall
		addi $t2, $t2, 1 # t2 ---> no of displayed items
		bgt $t0, $t2, spacing
		spacing: 
			la $a0, space
			li $v0, 4
			syscall
		blt $t2, $t0, disp
		subi $t1, $t1, 4
	
	# reverse
	la $t0, array
	swap:
		lw $t3, 0($t1)
		lw $t4, 0($t0)
		sw $t3, 0($t0)
		sw $t4, 0($t1)
		addi $t0, $t0, 4
		subi $t1, $t1, 4
		bgt $t1, $t0, swap
	
	# reverse display
	la $t1, array
	lw $t0, size # t0 --> size
	add $t2, $0, $0
	
	li $v0, 4
	la $a0, reverseMessage
	syscall
	
	reverseDisp:
		lw $a0, 0($t1)
		addi $t1, $t1, 4
		li $v0, 1
		syscall
		addi $t2, $t2, 1 # t2 ---> no of displayed items
		bgt $t0, $t2, reverseSpacing
		reverseSpacing: 
			la $a0, space
			li $v0, 4
			syscall
		blt $t2, $t0, reverseDisp
		subi $t1, $t1, 4
	
	li $v0, 10
	syscall
	
	.data
size: .word 0
array: .space 80
sizeMessage: .asciiz "Enter the size of the array:\n"
arrayMessage: .asciiz "Enter elements:\n"
display: .asciiz "Elements: "
reverseMessage: .asciiz "\nElements in reverse order: "
space: .asciiz " "
