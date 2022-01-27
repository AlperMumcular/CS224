	.data
Option1Msg: .asciiz "\n1- Enter matrix dimension (N)."
Option2Msg: .asciiz "\n2- Allocate and initialize."
Option3Msg: .asciiz "\n3- Display desired element."
Option4Msg: .asciiz "\n4- Obtain summation of matrix elements row-major (row by row) summation."
Option5Msg: .asciiz "\n5- Obtain summation of matrix elements column-major (column by column) summation."
Option6Msg: .asciiz "\n6- Quit."
choice: .asciiz "\nSelection: "
sizeMsg: .asciiz "\nEnter size (N): "	
elementMsg: .asciiz "\nThe element in desired location:  "
sumRowMsg: .asciiz "\nSummation (row by row) of the matrix element is equal to  "
sumColMsg: .asciiz "\nSummation (col by col) of the matrix element is equal to  "
rowMsg: .asciiz "\nThe row number is "
columnMsg: .asciiz "\nThe column number is "
	
	.text
__start:
	jal menu
	li $v0, 10
	syscall

menu:
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	li $v0, 4
	la $a0, Option1Msg
	syscall
	la $a0, Option2Msg
	syscall
	la $a0, Option3Msg
	syscall
	la $a0, Option4Msg
	syscall
	la $a0, Option5Msg
	syscall
	la $a0, Option6Msg
	syscall 
	la $a0, choice
	syscall
	jal input
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
input:
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	li $v0, 5
	syscall
	move $t7, $v0 # t7 is selection
	beq $t7, 1, option1
	beq $t7, 2, option2
	beq $t7, 3, option3
	beq $t7, 4, option4
	beq $t7, 5, option5
	beq $t7, 6, option6
	
	option1:
		li $v0, 4
		la $a0, sizeMsg
		syscall
		li $v0,5 
		syscall
		move $s0, $v0 # s0 is size
		mul $s1, $s0, $s0 # s1 element count
		j menu
	option2:
		li $v0, 9
		mul $a0, $s1, 4
		syscall
		move $s2, $v0 # s2 is base address
		jal fill
		j menu
	option3:
		la $a0, rowMsg
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		move $t0, $v0 #t0 is row no
		la $a0, columnMsg
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		move $t1, $v0 #t1 is col no
		subi $t1, $t1, 1
		mul $t1, $t1, 4
		subi $t0, $t0, 1
		mul $t0, $t0, 4
		mul $t0, $t0, $s0
		add $t1, $t0, $t1 # t1 is location
		add $t1, $t1, $s2 #t1 is address
		la $a0, elementMsg
		li $v0, 4
		syscall
		li $v0, 1
		lw $a0, 0($t1)
		syscall
		j menu
	option4:
		jal rowSum
		j menu
	option5:
		jal colSum
		j menu
	option6:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
		
rowSum:
	subi $sp, $sp, 8
	sw $s2, 0($sp)
	sw $ra, 4($sp)
	# t5 item at index i,j
	li $t6, 0 # item count
	li $t7, 0 # sum
	sumLoop:
		lw $t5, 0($s2)
		add $t7, $t7, $t5
		addi $t6, $t6, 1
		addi $s2, $s2, 4
		bne $t6, $s1, sumLoop
	la $a0, sumRowMsg
	li $v0, 4
	syscall
	li $v0, 1
	move $a0, $t7
	syscall
	lw $ra, 4($sp)
	lw $s2, 0($sp)
	addi $sp, $sp, 8
	jr $ra
colSum:
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	
	li $t0, 0 # col count
	li $t1, 0 # row count
	addi $t2, $s2, 0 # address
	li $t5, 0 # item
	li $t6, 0 # item count
	li $t7, 0 # sum
	mul $t3, $s0, 4
	colLoop1:
		lw $t5, 0($t2)
		li $v0, 1
		add $a0, $0, $t5
		syscall
		add $t7, $t7, $t5
		addi $t1, $t1, 1
		addi $t6, $t6, 1
		add $t2, $t2, $t3
		beq $t1, $s0, changeColumn
		bne $t6, $s1, colLoop1
	end:
		la $a0, sumColMsg
		li $v0, 4
		syscall
		li $v0, 1
		add $a0, $0, $t7
		syscall
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra 
		
	changeColumn:
		li $t1, 0
		addi $t0, $t0, 1
		beq $t0, $s0, end
		mul $t4, $t0, 4
		add $t2, $s2, $t4
		j colLoop1
		
fill:
	subi $sp, $sp, 8
	sw $ra, 0($sp)
	sw $s2, 4($sp)
	addi $t1, $0, 0 # element to be added
	
	fill2:
		addi $t1, $t1, 1
		sw $t1, 0($s2)
		addi $s2, $s2, 4
		bne $t1, $s1, fill2
	lw $s2, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 8
	jr $ra 
	
