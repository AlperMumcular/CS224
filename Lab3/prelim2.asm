# Alper Mumcular
# 21902740
# CS224 
# Lab 3 
# Prelim 2
	.text
main:
	choice:
		la $a0, line1
		li $v0, 4
		syscall
		la $a0, line2
		li $v0, 4
		syscall
		la $a0, line3
		li $v0, 4
		syscall
		la $a0, line4
		li $v0, 4
		syscall
		la $a0, option
		li $v0, 4
		syscall
		
		li $v0, 5
		syscall
		
		beq $v0, 1, option1
		beq $v0, 2, option2
		beq $v0, 3, option3
		beq $v0, 4, option4
		j choice
		
option1:
	addi $a0, $0, 6
	jal sampleLinkedList
	move $t0, $a1
	
	addi $a0, $a1, 0
	addi $v0, $a1, 0
	jal duplicate
	addi $a1, $a0, 0
	jal printLinkedList
	j choice
option2:
	la $a0, sizeMsg
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a0, $v0
	jal createLinkedList
	move $t0, $v0
	j choice	
option3:
	addi $a0, $t0, 0
	jal printLinkedList
	j choice
option4:
	addi $a0, $a1, 0
	addi $v0, $a1, 0
	jal duplicate
	addi $a1, $a0, 0
	jal printLinkedList
	j choice
	
duplicate: #a0, a1, v0, head
	addi $sp, $sp, -32
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	
	
	add $s1, $a0, $0
	bne $a1, $s1, cont
	beq $a1, $s1, beginning
	
	cont:
		beq $a1, $0, end
		
		li $a0, 8
		li $v0, 9
		syscall
		
		move $s6, $v0 # s6 new node
				
	    	sw $s6, 0($s5)
	    	move $s5, $s6 
	    	
	    	lw $s3, 0($a1) # gets the next address
		lw $s2, 4($a1) # gets the data val
		    	
		sw $s2, 4($s5)
		
		addi $a1, $s3, 0 #a1 updates its address
		beq $a1, $0, end
		jal duplicate
		
		end:
			addi $a0, $s4, 0 # a0 is head
	    		lw $ra, 0($sp)
			lw $s0, 4($sp)
			lw $s1, 8($sp)
			lw $s2, 12($sp)
			lw $s3, 16($sp)
			lw $s4, 20($sp)
			lw $s5, 24($sp)
			lw $s6, 28($sp)
			addi $sp, $sp, 32
			jr $ra
# taken from lecture codes and modified.	
sampleLinkedList:
	
	addi	$sp, $sp, -24
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram
	
	move	$s0, $a0	# $s0: no. of nodes to be created.
	li	$s1, 1		# $s1: Node counter
	
	
# Create the first node: header.
# Each node is 8 bytes: link field then data field.
	li	$a0, 8
	li	$v0, 9
	syscall
# OK now we have the list head. Save list head pointer 
	move	$s2, $v0	# $s2 points to the first and last node of the linked list.
	move	$s3, $v0	# $s3 now points to the list head.
	addi $s4, $0, 1
# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$s4, 4($s2)	# Store the data value.
	

# Are we done?
# No. of nodes created compared with the number of nodes to be created.
	beq	$s1, $s0, allDone2
	addi	$s1, $s1, 1	# Increment node counter.
	li	$a0, 8 		# Remember: Node size is 8 bytes.
	li	$v0, 9
	syscall
# Connect the this node to the lst node pointed by $s2.
	sw	$v0, 0($s2)
# Now make $s2 pointing to the newly created node.
	move	$s2, $v0	# $s2 now points to the new node.
	addi $s4, $0, 5
# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$s4, 4($s2)	# Store the data value.
	
	# Are we done?
# No. of nodes created compared with the number of nodes to be created.
	beq	$s1, $s0, allDone2
	addi	$s1, $s1, 1	# Increment node counter.
	li	$a0, 8 		# Remember: Node size is 8 bytes.
	li	$v0, 9
	syscall
# Connect the this node to the lst node pointed by $s2.
	sw	$v0, 0($s2)
# Now make $s2 pointing to the newly created node.
	move	$s2, $v0	# $s2 now points to the new node.
	addi $s4, $0, 6
# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$s4, 4($s2)	# Store the data value.
	
	# Are we done?
# No. of nodes created compared with the number of nodes to be created.
	beq	$s1, $s0, allDone2
	addi	$s1, $s1, 1	# Increment node counter.
	li	$a0, 8 		# Remember: Node size is 8 bytes.
	li	$v0, 9
	syscall
# Connect the this node to the lst node pointed by $s2.
	sw	$v0, 0($s2)
# Now make $s2 pointing to the newly created node.
	move	$s2, $v0	# $s2 now points to the new node.
	addi $s4, $0, 8
# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$s4, 4($s2)	# Store the data value.
	
	# Are we done?
# No. of nodes created compared with the number of nodes to be created.
	beq	$s1, $s0, allDone2
	addi	$s1, $s1, 1	# Increment node counter.
	li	$a0, 8 		# Remember: Node size is 8 bytes.
	li	$v0, 9
	syscall
# Connect the this node to the lst node pointed by $s2.
	sw	$v0, 0($s2)
# Now make $s2 pointing to the newly created node.
	move	$s2, $v0	# $s2 now points to the new node.
	addi $s4, $0, 9
# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$s4, 4($s2)	# Store the data value.
	
	# Are we done?
# No. of nodes created compared with the number of nodes to be created.
	beq	$s1, $s0, allDone2
	addi	$s1, $s1, 1	# Increment node counter.
	li	$a0, 8 		# Remember: Node size is 8 bytes.
	li	$v0, 9
	syscall
# Connect the this node to the lst node pointed by $s2.
	sw	$v0, 0($s2)
# Now make $s2 pointing to the newly created node.
	move	$s2, $v0	# $s2 now points to the new node.
	addi $s4, $0, 10
# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$s4, 4($s2)	# Store the data value.
	
	
allDone2:
# Make sure that the link field of the last node cotains 0.
# The last node is pointed by $s2.
	sw	$zero, 0($s2)
	move	$v0, $s3	# Now $v0 points to the list head ($s3).
	
	
	addi $a1, $s3, 0
# Restore the register values
	lw	$ra, 0($sp)
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	addi	$sp, $sp, 24
	
	
	
	jr	$ra
# taken from lecture codes and modified.	
createLinkedList:
# $a0: No. of nodes to be created ($a0 >= 1)
# $v0: returns list head
# Node 1 contains 4 in the data field, node i contains the value 4*i in the data field.
# By 4*i inserting a data value like this
# when we print linked list we can differentiate the node content from the node sequence no (1, 2, ...).
	
	addi	$sp, $sp, -24
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram
	
	move	$s0, $a0	# $s0: no. of nodes to be created.
	li	$s1, 1		# $s1: Node counter
	
	la $a0, valueMsg
	li $v0, 4
	syscall
	
# Create the first node: header.
# Each node is 8 bytes: link field then data field.
	li	$a0, 8
	li	$v0, 9
	syscall
# OK now we have the list head. Save list head pointer 
	move	$s2, $v0	# $s2 points to the first and last node of the linked list.
	move	$s3, $v0	# $s3 now points to the list head.
	jal getElements
# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$s4, 4($s2)	# Store the data value.
	
addNode:
# Are we done?
# No. of nodes created compared with the number of nodes to be created.
	beq	$s1, $s0, allDone
	addi	$s1, $s1, 1	# Increment node counter.
	li	$a0, 8 		# Remember: Node size is 8 bytes.
	li	$v0, 9
	syscall
# Connect the this node to the lst node pointed by $s2.
	sw	$v0, 0($s2)
# Now make $s2 pointing to the newly created node.
	move	$s2, $v0	# $s2 now points to the new node.
	jal getElements
# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$s4, 4($s2)	# Store the data value.
	j	addNode
allDone:
# Make sure that the link field of the last node cotains 0.
# The last node is pointed by $s2.
	sw	$zero, 0($s2)
	move	$v0, $s3	# Now $v0 points to the list head ($s3).
	
	
	addi $a1, $s3, 0
# Restore the register values
	lw	$ra, 0($sp)
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	addi	$sp, $sp, 24
	
	
	
	jr	$ra
# taken from lecture codes (Not modified)
#=========================================================
printLinkedList:
# Print linked list nodes in the following format
# --------------------------------------
# Node No: xxxx (dec)
# Address of Current Node: xxxx (hex)
# Address of Next Node: xxxx (hex)
# Data Value of Current Node: xxx (dec)
# --------------------------------------

# Save $s registers used
	addi	$sp, $sp, -20
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$s2, 8($sp)
	sw	$s3, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram

# $a0: points to the linked list.
# $s0: Address of current
# s1: Address of next
# $2: Data of current
# $s3: Node counter: 1, 2, ...
	move $s0, $a0	# $s0: points to the current node.
	li   $s3, 0
printNextNode:
	beq	$s0, $zero, printedAll
				# $s0: Address of current node
	lw	$s1, 0($s0)	# $s1: Address of  next node
	lw	$s2, 4($s0)	# $s2: Data of current node
	addi	$s3, $s3, 1
# $s0: address of current node: print in hex.
# $s1: address of next node: print in hex.
# $s2: data field value of current node: print in decimal.
	la	$a0, line
	li	$v0, 4
	syscall		# Print line seperator
	
	la	$a0, nodeNumberLabel
	li	$v0, 4
	syscall
	
	move	$a0, $s3	# $s3: Node number (position) of current node
	li	$v0, 1
	syscall
	
	la	$a0, addressOfCurrentNodeLabel
	li	$v0, 4
	syscall
	
	move	$a0, $s0	# $s0: Address of current node
	li	$v0, 34
	syscall

	la	$a0, addressOfNextNodeLabel
	li	$v0, 4
	syscall
	move	$a0, $s1	# $s0: Address of next node
	li	$v0, 34
	syscall	
	
	la	$a0, dataValueOfCurrentNode
	li	$v0, 4
	syscall
		
	move	$a0, $s2	# $s2: Data of current node
	li	$v0, 1		
	syscall	

# Now consider next node.
	move	$s0, $s1	# Consider next node.
	j	printNextNode
printedAll:
# Restore the register values
	lw	$ra, 0($sp)
	lw	$s3, 4($sp)
	lw	$s2, 8($sp)
	lw	$s1, 12($sp)
	lw	$s0, 16($sp)
	addi	$sp, $sp, 20
	jr	$ra
		
getElements:
	li $v0,5
	syscall
	addi $s4, $v0, 0
	jr $ra	
	
beginning:	
	beq $a1, $0, empty
	li $a0, 8
	li $v0, 9
	syscall
	
	move $s6, $v0
	move $s5, $s6
	
	lw $s3, 0($a1)
	lw $s2, 4($a1)
	
	sw $s3, 0($s6)
	sw $s2, 4($s6)
	move $s4, $s6 # s4 is head
	
	addi $a1, $s3,0
	j cont
empty:
	la $a0, emptyMsg
	li $v0, 4
	syscall
	j main
	.data
line:	
	.asciiz "\n --------------------------------------"

nodeNumberLabel:
	.asciiz	"\n Node No.: "
	
addressOfCurrentNodeLabel:
	.asciiz	"\n Address of Current Node: "
	
addressOfNextNodeLabel:
	.asciiz	"\n Address of Next Node: "
	
dataValueOfCurrentNode:
	.asciiz	"\n Data Value of Current Node: "
option: .asciiz "\nYour choice: "
line1: .asciiz"\n1-  Test {1,5,6,8,9,10}"
line2: .asciiz"\n2-  Create an linked list"
line3: .asciiz"\n3-  Print the original"
line4: .asciiz"\n4-  Print the dublicate"
sizeMsg: .asciiz"\nEnter the size: "
valueMsg: .asciiz"\nEnter the values: "
emptyMsg: .asciiz"\nLinked List is empty!"