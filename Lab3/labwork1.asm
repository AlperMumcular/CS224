# Alper Mumcular
# 21902740
# CS224 
# Lab 3 
# Lab Work 1
	.text
main:
	la $a0, main
	la $a1, endaddr
	jal subprogram

	move $t0, $v0 # R type in main
	move $t1, $v1 # I type in main
	la $a0, Rmain
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	
	la $a0, Imain
	li $v0, 4
	syscall
	move $a0, $t1
	li $v0,1
	syscall
	
	li $v0, 10
	syscall
subprogram:
	subi $sp, $sp, 24
	sw $ra, 0($sp)
	sw $s0, 4($sp) # head address
	sw $s1, 8($sp) # last 
	sw $s2, 12($sp) # R type
	sw $s3, 16($sp) # I type
	sw $s4, 20($sp) # curr instruction
	
	move $s0, $a0
	move $s1, $a1
	
	addi $s2, $0,0
	addi $s3, $0,0
	
	instructionLoop:
		bge $s0, $s1, end
		lw $s4, 0($s0)
		srl $s4, $s4, 26 # for opcode
		beq $s4, $0, increaseRtype
		beq $s4, 2, jumpType
		beq $s4, 3, jumpType
		j increaseItype
		
	jumpType:
		addi $s0, $s0, 4
		j instructionLoop
	increaseRtype:
		addi $s2, $s2, 1
		addi $s0, $s0, 4
		j instructionLoop
	increaseItype:
		addi $s3, $s3, 1
		addi $s0, $s0, 4
		j instructionLoop
	end:
		move $v0, $s2 # R type
		move $v1, $s3 # I type
		lw $s4, 20($sp)
		lw $s3, 16($sp)
		lw $s2, 12($sp)
		lw $s1, 8($sp)
		lw $s0, 4($sp)
		lw $ra, 0($sp)
		addi $sp, $sp, 24
endaddr:	jr $ra
	
	
	.data
Rmain: .asciiz "\nNumber of R type instructions in program: " 
Imain: .asciiz "\nNumber of I type instructions in program: " 
