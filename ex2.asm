        addi 	$sp, 	$sp, 	-4
        sw 	$ra, 	0($sp)		# saving $ra, because we are using jal later
        mov 	$t0, 	$a0	        # copy a0 to t0, because we need a0 as is later 
        lbu 	$t1, 	0($t0)		# load first bit of a0 (t0) to t1 (a0=t0=*p=s)
        beq 	$t1, 	$zero, 	SUCC	# if we have an empty string, it’s palindrome
        jal	CNT			# else we want to count the string length
	add 	$t3, 	$zero, 	$zero	# t3 used as l and initialization l=0
	addi 	$t2, 	$t2, 	-1	# t2 is strlen and used as h=strlen(s)-1
	j       LOOP		
LOOP:   slt 	$t4, 	$t3, 	$t2	# t4=1, if l<h, meaning the LOOP should go on
	beq 	$t4, 	$zero, 	SUCC	# if t4=0, l>=h, so we are done with success
	add 	$t5, 	$t3, 	$a0	# t5=s[l] (a0[l])
	add 	$t6, 	$t2,	$a0	# t6=s[h] (a0[h])
	bne 	$t5, 	$t6, 	FAIL	# if s[l]!=s[h], the string is not palindrome
	addi 	$t3,	$t3,	1	# l++, get to the next char from the start
        addi 	$t2, 	$t2,	-1	# h--, get to the previous char from the end
        j	LOOP		
CNT:	addi 	$t0, 	$t0, 	1 	# next char of a0 (p++)
        lbu 	$t1,	0($t0) 		# current byte of a0 (t0) is loaded to t1
        bne 	$t1, 	$zero, 	CNT	# if it is not ‘\0’ loop CNT
        sub 	$t2, 	$t0, 	$a0	# when loop is done, t2=strlen(s)=p-s
	jr	$ra		
SUCC:	addi 	$v0, 	$zero, 	1	# if all characters compared are equal, the 
	j	EXIT			# the string is palindrome, therefore v0=1
FAIL:	add 	$v0, 	$zero, 	$zero	# if there are unequal characters, the string
	j	EXIT			# is not palindrome, therefore v0=0
EXIT:   lw 	$ra, 	0($sp)		# restore $ra, since jal may be used
        addi 	$sp, 	$sp, 	4
        jr 	$ra