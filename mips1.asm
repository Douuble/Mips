.data
array:.space 1024
input_num_msg:.asciiz "Please enter the number of integers:\n"
input_int_msg:.asciiz "Please enter the integers one by one:\n"
output_int_msg:.asciiz "The result ia listed below:\n"
seperate:.asciiz " "

.text
.globl main
main:
    #��ӡ�ַ�����׼��ʽ
    la $a0,input_num_msg  #����û���������Ԫ�ظ�����ʾ
    li $v0,4
    syscall

    li $v0,5         #���ڷ���ָ��
    syscall

    la $t6,array     # $t6 �������׵�ַ
    move $t7,$0      # $t7 ��ѭ������i
    move $t8,$v0     # $t8 �����鳤��
    move $t9,$0      # $t9 ��ѭ������j

input:                    # input����������������Ԫ�ص�����
    la $a0,input_int_msg  # ����û���������Ԫ����ʾ
    li $v0,4
    syscall

    li $v0,5
    syscall

    move $t0,$t7     
    mul $t0,$t0,4    # ����Ԫ����ռ�ֽ���*ѭ������+�������ʼ��ַ=����[ѭ������]
    addu $t1,$t0,$t6
    sw $v0,0($t1)

    addi $t7,$t7,1
    blt $t7,$t8,input
    move $t7,$0      # ��������ѭ��������Ϊ0

loop1:
    move $t9,$0    # ÿ��ִ�����ѭ�������ڲ�ѭ����ѭ��������Ϊ0
loop2:
    move $t0,$t9      # ��ȡa[i]
    mul $t0,$t0,4
    addu $t1,$t0,$t6
    lw $t2,0($t1)

    addi $t0,$t9,1    # ��ȡa[i+1]
    mul $t0,$t0,4
    addu $t4,$t0,$t6
    lw $t3,0($t4)

    ble $t2,$t3,skip  # ���a[i] < a[i+1],��ת��skip�����
    sw $t3,0($t1)  
    sw $t2,0($t4)    

skip:
   addi $t9,$t9,1  
   addi $t0,$t9,1   
   sub $t1,$t8,$t7  
   blt $t0,$t1,loop2 
   addi $t7,$t7,1    
   sub $t2,$t8,1
   blt $t7,$t2,loop1

output:
   la $a0,output_int_msg    #�����ʾ
   li $v0,4
   syscall

   move $t7,$0

print:              # ʵ�ִ�ӡ����Ԫ��
   move $t0,$t7
   mul $t0,$t0,4
   addu $t1,$t0,$t6
   lw $a0,0($t1)
   li $v0,1
   syscall

   la $a0,seperate   # �ָ�����Ԫ��
   li $v0,4
   syscall

   addi $t7,$t7,1
   blt $t7,$t8,print # �������ѭ����������ת��print����ִ��ѭ��
