# Kristine Kunapuli
# CS3340, hw5, #1

.data # define data used in program
	promptx: .asciiz "Enter width of lot in feet (float): " #get value x
	prompty: .asciiz "Enter depth of lot in feet (float): " #get value y
	prompta: .asciiz "Enter width of house in feet (float): " #get value a
	promptb: .asciiz "Enter depth of house in feet (float): " #get value b
	ansStr: .asciiz "Your remaining land in sq ft is: "
	NL: .asciiz "\n" # define new line for printing

.text # actual code of program
main: # main processing flow

	# ask user for x
	li $v0, 4 # command to print string
	la $a0, promptx # load string prompt into arugment for printing
	syscall # execute command
	
	# read number from user input
	li $v0, 6 # read a float from user
	syscall # execute command; result will be in f0
	mov.s $f1, $f0 # move x into f1 so we can read more floats
	
	# ask user for y
	li $v0, 4 # command to print string
	la $a0, prompty # load string prompt into arugment for printing
	syscall # execute command
	
	# read number from user input
	li $v0, 6 # read a float from user
	syscall # execute command; result will be in f0
	mov.s $f2, $f0 # move y into f2 so we can read more floats
	
	# ask user for a
	li $v0, 4 # command to print string
	la $a0, prompta # load string prompt into arugment for printing
	syscall # execute command
	
	# read number from user input
	li $v0, 6 # read a float from user
	syscall # execute command; result will be in f0
	mov.s $f3, $f0 # move a into f3 so we can read more floats
	
	# ask user for b
	li $v0, 4 # command to print string
	la $a0, promptb # load string prompt into arugment for printing
	syscall # execute command
	
	# read number from user input
	li $v0, 6 # read a float from user
	syscall # execute command; result will be in f0
	mov.s $f4, $f0 # move b into f4 for consistency
	
	# find area of lot
	mul.s $f5, $f1, $f2 # f5 = x*y = lot area
	
	# find area of house
	mul.s $f6, $f3, $f4 # f6 = a*b = house area
	
	# find difference
	sub.s $f12, $f5, $f6
	
	# print result
	li $v0, 4 # command to print string
	la $a0, ansStr # loads answer string into argument a0 for printing
	syscall # executes command
	li $v0,2 # print float; result is in f12 already
	syscall # execute command

	li $v0, 10 # terminate program
	syscall # issue sysetm call from previous command
