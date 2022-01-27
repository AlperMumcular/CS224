# Alper Mumcular
# 21902740
# CS224 
# Lab 3 
# Lab Work 2
	.text
main:
	la $a0, continueMsg
	li $v0, 4
	syscall

	la $a0, selectionMsg
	li $v0, 4
	syscall
	li $v0, 5 
	syscall
	
	beq $v0, 0, end
	
	la $a0, dividendMsg
	li $v0, 4
	syscall
	li $v0, 5 
	syscall
	beq $v0, 0, end
	
	move $a1, $v0
	
	la $a0, divisorMsg
	li $v0, 4
	syscall
	li $v0, 5 
	syscall
	beq $v0, 0, end
	
	move $a2, $v0
	
	
	move $s2, $a1
	jal recDiv
	move $t0, $v1 # quotient
	
	la $a0, quotientMsg
	li $v0, 4
	syscall
	
	move $a0, $t0
	li $v0, 1
	syscall
	
	addi $v1, $0, 0
	
	j main
	
recDiv:
	addi $sp, $sp, -20
	sw $s3, 16($sp) # recursive execution time
	sw $s0, 12($sp) # quotient
	sw $s1, 8($sp) # divisor
	sw $s2, 4($sp) # dividend
	sw $ra, 0($sp)
	
	beq $s3, $0, first
cont:   
	addi $s3, $s3, 1
	addi $s0, $0,0
	move $s1, $a2
	bgt $s1, $s2, leave # initial check
	
	sub $s2, $s2, $s1
	addi $s0, $0, 1
	bgt $s1, $s2, leave
	
	jal recDiv
	
	leave:
		add $v1, $v1, $s0
		lw $s3, 16($sp)
		lw $s0, 12($sp) # quotient
		lw $s1, 8($sp) # divisor
		lw $s2, 4($sp)
		lw $ra, 0($sp)
		addi $sp, $sp, 20
		jr $ra
	
	first:
		move $s2, $a1
		j cont
	
end:
	li $v0, 10
	syscall
	.data
dividendMsg: .asciiz "\nEnter the dividend: "
divisorMsg: .asciiz "\nEnter the divisor: "
continueMsg: .asciiz "\n0-Exit \n1-Continue "
selectionMsg: .asciiz "\nYour selection: "	
quotientMsg: .asciiz "\nQuotient is : "			
