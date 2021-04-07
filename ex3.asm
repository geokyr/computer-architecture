        li 	$t0, 	36		#36 is ASCII code for ‘$’
        li 	$t1, 	43		#43 is ASCII code for ‘+’
        li 	$t2, 	45		#45 is ASCII code for ‘-‘
        li 	$t3, 	42		#42 is ASCII code for ‘*’	
        li 	$t4, 	47		#47 is ASCII code for ‘/’
        j 	LOOP				
LOOP:  	lb 	$t5, 	0($a0)		#load current byte (ASCII code) of a0 to t5
beq 	$t5, 	$t0, 	EXIT		#check if t5 is equal to t0 (char = $, eof)
        slti 	$t6, 	$t5, 	48	#check if t5 is an operator (operators<48=‘0’)
        beq 	$t6, 	$zero, 	PUSH	#if t6=0, we push the number to the stack
        beq 	$t5, 	$t1, 	ADDN	#if t5=’+’ (addition) go to ADDN
        beq 	$t5, 	$t2, 	SUBN	#if t5=’-‘ (subtraction) go to SUBN
        beq 	$t5, 	$t3, 	MULN	#if t5=’*’ (multiplication) go to MULN
        beq 	$t5, 	$t4, 	DIVN	#if t5=’/’ (division) go to DIVN
EXIT: 	lw 	$v0, 	0($sp)		#v0 = result (top of stack, last number left)
        addi 	$sp, 	$sp, 	4	#release its stack memory
        jr	$ra				
PUSH:	addi 	$sp, 	$sp, 	-4	#allocate space for word (4 bytes)
        addi	$t5,	$t5,	-48	#convert ASCII code to integer
        sw 	$t5, 	0($sp) 		#store the integer on the stack
        addi 	$a0, 	$a0, 	1	#move a0 to its next byte (ASCII code)
        j 	LOOP				
ADDN: 	lw 	$t7, 	0($sp)		#retrieve second operand (top of stack)
        addi 	$sp, 	$sp,	4	#release its stack memory
        lw 	$t8, 	0($sp)		#retrieve first operand (top of stack)
        add 	$t8, 	$t8,	$t7	#t8+=t7, addition of integers
        sw 	$t8, 	0($sp)		#renew t8 with the answer on stack
        addi 	$a0, 	$a0, 	1	#move a0 to its next byte (ASCII code)
        j 	LOOP				
SUBN:	lw 	$t7, 	0($sp)		#retrieve second operand (top of stack)
        addi 	$sp, 	$sp, 	4	#release its stack memory
        lw 	$t8, 	0($sp)		#retrieve first operand (top of stack)
        sub 	$t8, 	$t8, 	$t7	#t8-=t7, subtraction of integers
        sw 	$t8, 	0($sp)		#renew t8 with the answer on stack
        addi 	$a0, 	$a0, 	1	#move a0 to its next byte (ASCII code)
        j 	LOOP				
MULN:	lw 	$t7, 	0($sp)		#retrieve second operand (top of stack)
        addi 	$sp, 	$sp, 	4	#release its stack memory
        lw 	$t8, 	0($sp)		#retrieve first operand (top of stack)
        mul 	$t8, 	$t8, 	$t7	#t8*=t7, multiplication of integers
        sw 	$t8,	 0($sp)		#renew t8 with the answer on stack
        addi 	$a0, 	$a0, 	1	#move a0 to its next byte (ASCII code)
        j 	LOOP				
DIVN: 	lw	$t7,	0($sp)		#retrieve second operand (top of stack)
        addi 	$sp, 	$sp, 	4	#release its stack memory
        lw 	$t8, 	0($sp)		#retrieve first operand (top of stack)
        div 	$t8, 	$t8, 	$t7	#t8/=t7, division of integers
        sw 	$t8, 	0($sp)		#renew t8 with the answer on stack
        addi 	$a0, 	$a0, 	1	#move a0 to its next byte (ASCII code)
        j 	LOOP		
