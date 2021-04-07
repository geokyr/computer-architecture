        addi    $sp,    $sp,    -8
        sw      $s1,	4($sp)		# storing s1, s2, so we can restore them
        sw	$s2,	0($sp)		# after we are done using them 
        add	$t1,	$zero,	$zero 	# t1 used as res and initialization res=0
        add	$t2,	$zero,	$zero 	# t2 used as i and initialization i=0
FOR:    lw	$s1,	0($a0)		# s1=v[i] (a0)
	lw	$s2,	0($a1)		# s2=u[i] (a1)
	mul	$s1,	$s1,	$s2	# s1=v[i]*u[i]
	add	$t1,	$t1,	$s1	# res+=v[i]*u[i]
	addi	$a0,	$a0,	4	# next number of a0
	addi	$a1,	$a1,	4	# next number of a1
	addi	$t2,	$t2,	1	# i++
	slt	$t3,	$t2,	$a2	# t3=1, if i<n, meaning FOR loop goes on
	bne	$t3,	$zero,	FOR	# if t3!=0 (t3=1) then loop FOR
        add 	$v0, 	$t1, 	$zero	# v0=res
        lw 	$s2, 	0($sp)  	# restoring s1 and s2 since we are done
        lw 	$s1, 	4($sp)		
        addi 	$sp, 	$sp,	8		
        jr 	$ra	