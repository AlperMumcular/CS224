	.text
__start:
	
	# lab work part a
	main:
		la $a0, sizeMessage
		li $v0, 4
		syscall
		
		li $v0, 5
		syscall
		
		subi $sp, $sp, 36
		sw $s0, 4($sp) # base address
		sw $s1, 8($sp) # current address 
		sw $s2, 12($sp) # selection
		sw $s3, 16($sp) # size count 
		sw $s4, 20($sp) # array index
		sw $s5, 24($sp) # median value / index 
		sw $s6, 28($sp) # max value / index
		sw $s7, 32($sp) # size
		
		move $s7, $v0 # s7 is the size
		
		mul $a0, $s7, 4
		li $v0, 9
		syscall
		
		sw $v0, 0($sp) # base address
		move $s1, $v0 # s1 is the address
		addi $s0, $s1, 0
		
		jal monitor
		
		addi $s4, $s1, 0
		addi $s3, $0, 0
		
		display:
			lw $a0, 0($s4)
			li $v0, 1
			syscall
			
			la $a0, space
			li $v0, 4
			syscall
			
			addi $s3, $s3, 1
			blt $s3, $s7, display
			
		la $a0, newLine
		li $v0, 4
		syscall
			
		display2:
			la $a0, medianMessage
			li $v0, 4
			syscall
			
			addi $a0, $s5, 0
			li $v0, 4
			syscall
			
			la $a0, maxMessage
			li $v0, 4
			syscall
			
			addi $a0, $s6, 0
			li $v0, 4
			syscall
			
		
			
		addi $s4, $s1, 0
		addi $s3, $0, 0
			
			
			
		
monitor:
	la $a0, option1
	li $v0, 4
	syscall
	
	la $a0, option2
	li $v0, 4
	syscall
	
	la $a0, option3
	li $v0, 4
	syscall
	
	la $a0, option4
	li $v0, 4
	syscall
	
	la $a0, option5
	li $v0, 4
	syscall
	
	la $a0, newLine
	li $v0, 4
	syscall
	
	la $a0, selectionMessage
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $s2, $v0
	
	beq $s2, 1, main
	beq $s2, 2, values
	beq $s2, 3, bubbleSort
	beq $s2, 4, medianMax
	beq $s2, 5, end
	
	j monitor

# gets array elements from the user
values:
	la $a0, valueMessage
	li $v0, 4
	syscall
	addi $s3, $0, 0
	addi $s1, $s0, 0
	loop:
		li $v0, 5
		syscall
		sw $v0, 0($s1)
		addi $s1, $s1, 4
		addi $s3, $s3, 1
		blt $s3, $s7, loop
		
	j monitor
		
		
# sorting the array using bubble sort algorithm
bubbleSort:
	addi $s1, $s0, 0
	addi $s3, $0, 1
	addi $s6, $0, 1
	beq $s7, 1, last
	sorting:
		sorting2:
			lw $s4, 0($s1)
			addi $s1, $s1, 4
			lw $s5, 0($s1)
			addi $s3, $s3, 1
			bgt $s4, $s5, switch
			blt $s3, $s7, sorting2
		cont:
			addi $s3, $0, 1
			addi $s1, $s0, 0
			addi $s6, $s6, 1
			blt $s6, $s7, sorting
	
	addi $s1, $s0, 0
	addi $s3, $0, 1
	print:
		lw $a0, 0($s1)
		li $v0, 1
		syscall
		
		la $a0, comma
		li $v0, 4
		syscall
		addi $s3, $s3, 1
		addi $s1, $s1, 4
		blt $s3, $s7, print
	last:
		lw $a0, 0($s1)
		li $v0, 1
		syscall
	
	j monitor
	
	# switches a[n] and a[n+1]
	switch:
		addi $s1, $s1, -4
		sw $s5, 0($s1)
		addi $s1, $s1, 4
		sw $s4, 0($s1)
		blt $s3, $s7, sorting2
		j cont
		
# calculates the array's median and max value
medianMax:
	addi $s1, $s0, 0
	addi $s3, $0, 1
	lastindex:
		addi $s3, $s3, 1
		bgt $s3, $s7, max
		addi $s1, $s1, 4
		blt $s3, $s7, lastindex	
	
	max:
		lw $s6, 0($s1) # max value stored in $s6
	
	addi $s1, $s0, 0
	addi $s3, $0, 2
	median:
		div $s7, $s3
		mflo $s3
		mfhi $s1
		beq $s1, 1, odd
		beq $s1, 0, even
	# median for size 2n+1 (n is integer)	
	odd:
		add $s3, $s3, $s1
		addi $s1, $s0, 0
		oddloop:
			subi $s3, $s3, 1
			ble $s3, 0, med
			addi $s1, $s1, 4
			bgt $s3, 1, oddloop
		
		med:
			lw $s5, 0($s1)
		
		j medianend
	# median for size 2n (n is integer)	
	even:
		add $s3, $s3, $s1
		addi $s1, $s0, 0
		beq $s7, 2, size2 # special case
		evenloop:
			subi $s3, $s3, 1
			addi $s1, $s1, 4
			bgt $s3, 1, evenloop
		lw $s5, 0($s1)
		addi $s1, $s1, 4
		lw $s3, 0($s1)
		add $s5, $s5, $s3
		addi $s1, $0, 2
		div $s5, $s1
		mflo $s5
		mfhi $s1
		beq $s1, 1, medianend2
		beq $s1, 0, medianend
		#div.s $s5, $s5, $s1
		#addi $s1, $s0, 0
		#j medianend2
		size2: # median calculator size 2 
			lw $s5, 0($s1)
			addi $s1, $s1, 4
			lw $s1, 0($s1)
			add $s5, $s5, $s1
			addi $s1, $0, 2
			div $s5, $s1
			mflo $s5
			mfhi $s1
			beq $s1, 1, medianend2
			beq $s1, 0, medianend
			
	# integer median
	medianend:
		la $a0, medianMessage
		li $v0, 4
		syscall
		
		move $a0, $s5, 
		li $v0, 1
		syscall
		
		la $a0, maxMessage
		li $v0, 4
		syscall
		
		move $a0, $s6
		li $v0, 1
		syscall
		
		
		j monitor
	
	# floating median
	medianend2:
		la $a0, medianMessage
		li $v0, 4
		syscall
		
		move $a0, $s5
		li $v0, 1
		syscall
		
		la $a0, five
		li $v0, 4
		syscall
		
		la $a0, maxMessage
		li $v0, 4
		syscall
		
		move $a0, $s6
		li $v0, 1
		syscall
		
		
		j monitor
	
	
end:
	# deallocate
	addi $sp, $sp, 36
	
	# end
	li $v0, 10	
	syscall
		
	.data
sizeMessage: .asciiz "\nPlease enter the size: "
option1: .asciiz "\n1-Receive array beginning address and array size from main."
option2: .asciiz "\n2-Initialize array contents."
option3: .asciiz "\n3-Sort the array."
option4: .asciiz "\n4-Median and max values."
option5: .asciiz "\n5-Quit."
space: .asciiz " "
medianMessage: .asciiz "\nThe median is: "
maxMessage: .asciiz "\nThe maximum value is: "
newLine: .asciiz "\n"
selectionMessage: .asciiz "Your selection: "
valueMessage: .asciiz "\nEnter the values: \n"
five: .asciiz ".5"
comma: .asciiz ","
