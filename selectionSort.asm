# Kristine Kunapuli
# CS3340, hw3, #1

.data # define data used in program
list: .space 16 # reserve 4 words (16 bytes)
listsz: .word 4 # reserve 4 words
NL: .asciiz "\n" # define new line for printing

.text # actual code of program
main: # main processing flow
	# initialize s0 through s3
	addi $s0, $zero, 8 # initialize s0 to 8
	addi $s1, $zero, 12 # initialize s1 to 12
	addi $s2, $zero, 5 # initialize s2 to 5
	addi $s3, $zero, 2 # initialize s3 to 2
	
	la $t0, list # keep address of array in $t0
	lw $t1 listsz # get size of array
	
	# store s0-s3 in an array
	sw $s0, 0($t0) # store s0 in array
	sw $s1, 4($t0) # store s1 in array
	sw $s2, 8($t0) # store s2 in array
	sw $s3, 12($t0) # store s3 in array
	
	### print array before sorting ###
	addi $t2, $zero, 0 # set t2 to zero (counter)
	printArray:
		beq $t1, $t2, printEnd # stop at end of array
		sll $t3, $t2, 2 # calculate address offset
		add $t3, $t3, $t0 # add offset to array address
		lw $a0, 0($t3) # load element of array
		li $v0, 1 # print integer command
		syscall # execute command
		li $a0, 32 # ascii code for space (32)
		li $v0, 11 # print character command
		syscall # execute command
		addi $t2, $t2, 1
		j printArray
	printEnd:
	la $a0, NL  # print new line
	li $v0, 4
	syscall # execute command
	
	add $a0, $zero, $t0 # set argument to array address
	add $a1, $zero, $t1 # set argument to number of array elements
	jal selectionSort # call myFunction(4)
	
	### print array after sorting ###
	la $t0, list # keep address of array in $t0
	lw $t1 listsz # get size of array
	addi $t2, $zero, 0 # set t2 to zero (counter)
	printArray2:
		beq $t1, $t2, printEnd2 # stop at end of array
		sll $t3, $t2, 2 # calculate address offset
		add $t3, $t3, $t0 # add offset to array address
		lw $a0, 0($t3) # load element of array
		li $v0, 1 # print integer command
		syscall # execute command
		li $a0, 32 # ascii code for space (32)
		li $v0, 11 # print character command
		syscall # execute command
		addi $t2, $t2, 1
		j printArray2
	printEnd2:
	
	li $v0, 10 # terminate program
	syscall # issue sysetm call from previous command

selectionSort:
	addi $s4, $a1, 0 # keep number of elements in s0
	addi $s5, $zero, 0 # initialize index "c"
	addi $t0, $s4, -1 # store num elements -1
	Loop1: slt $t1, $s5, $t0 # c < (n-1) ?
		beq $t1, $zero, Exit1 # exit loop1 if c >= (n-1)
		addi $s6, $s5, 0 # position = c
		
		addi $s7, $s5, 1 # d = c+1
		Loop2: slt $t1, $s7, $s4 # d < n ?
			beq $t1, $zero, Exit2 # exit loop2 if d >= n
			
			# 1st if: array[pos] > array[d]
			sll $t2, $s6, 2 # mult position by 4
			add $t2, $t2, $a0 # address of array[position]
			lw $t4, 0($t2) # load array[position]
			sll $t3, $s7, 2 # mult d by 4
			add $t3, $t3, $a0 # address of array[d]
			lw $t5, 0($t3) # load array[d]
			slt $t6, $t5, $t4 # array[position] > array[d]?
			beq $t6, $zero, EndIf1 # skip if when array[d] >= array[pos]
			add $s6, $s7, $zero # set position = d
			
			EndIf1: # done with if array[pos] > array[d]
			
			# 2nd if: position != c
			seq $t1, $s6, $s5 # if position = c, set to 1
			bne $t1, $zero, EndIf2 # position = c; skip if
			sll $t6, $s5, 2 # c*4
			add $t6, $t6, $a0 # address of array[c]
			lw $t7, 0($t6) # load array[c]
			
			# swap values
			sw $t5, 0($t6) # store array[position=d] at array[c]
			sw $t7, 0($t3) # store array[c] at array[position=d]
		
			EndIf2: # done iwth if position != c
			
			addi $s7, $s7, 1 # add 1 to "d"
			j Loop2 # jump to Loop2
		Exit2:
		
		addi $s5, $s5, 1 # add 1 to "c"
		j Loop1 # jump to Loop1
	Exit1:
	jr $ra # return to callee