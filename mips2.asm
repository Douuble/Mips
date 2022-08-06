.data
 	separate:.asciiz " "
	line:.asciiz "\n"
	inputeline:.asciiz "Enter height of pyramid:"
	star:.asciiz "* "
	
.text
.globl main
main:
	la $a0,inputeline
	jal print_star
	
	li $v0,5
	syscall
	
	beq $v0,$0,exit
	addiu $t0,$v0,1		#输入行数
	subiu $t1,$t0,1		#计算空格
	addiu $t2,$0,1		#计算星星数量
	
loopi:
	addiu $t3,$t1,0
	loopj:
		la $a0,separate
		jal print_star
		subiu $t3,$t3,1
	bne $t3,$0,loopj
		
	addiu $t3,$t2,0
	loopk:
		la $a0,star
		jal print_star
		subiu $t3,$t3,1
	bne $t3,$0,loopk
		
	la $a0,line
	jal print_star
	subiu $t1,$t1,1
	addiu $t2,$t2,1
	beq $t2,$t0,exit
	
j loopi

print_star:		
	li $v0,4
	syscall
	jr $ra
	
exit:
        li $v0, 10             #系统调用/退出程序
        syscall


	
	
	
