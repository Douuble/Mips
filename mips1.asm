.data
array:.space 1024
input_num_msg:.asciiz "Please enter the number of integers:\n"
input_int_msg:.asciiz "Please enter the integers one by one:\n"
output_int_msg:.asciiz "The result ia listed below:\n"
seperate:.asciiz " "

.text
.globl main
main:
    #打印字符串标准格式
    la $a0,input_num_msg  #输出用户输入数组元素个数提示
    li $v0,4
    syscall

    li $v0,5         #用于服务指令
    syscall

    la $t6,array     # $t6 是数组首地址
    move $t7,$0      # $t7 是循环变量i
    move $t8,$v0     # $t8 是数组长度
    move $t9,$0      # $t9 是循环变量j

input:                    # input代码块用于完成数组元素的输入
    la $a0,input_int_msg  # 输出用户输入数组元素提示
    li $v0,4
    syscall

    li $v0,5
    syscall

    move $t0,$t7     
    mul $t0,$t0,4    # 数组元素所占字节数*循环变量+数组的起始地址=数组[循环变量]
    addu $t1,$t0,$t6
    sw $v0,0($t1)

    addi $t7,$t7,1
    blt $t7,$t8,input
    move $t7,$0      # 完成输入后将循环变量置为0

loop1:
    move $t9,$0    # 每次执行外层循环都将内层循环的循环变量置为0
loop2:
    move $t0,$t9      # 获取a[i]
    mul $t0,$t0,4
    addu $t1,$t0,$t6
    lw $t2,0($t1)

    addi $t0,$t9,1    # 获取a[i+1]
    mul $t0,$t0,4
    addu $t4,$t0,$t6
    lw $t3,0($t4)

    ble $t2,$t3,skip  # 如果a[i] < a[i+1],跳转到skip代码块
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
   la $a0,output_int_msg    #输出提示
   li $v0,4
   syscall

   move $t7,$0

print:              # 实现打印数组元素
   move $t0,$t7
   mul $t0,$t0,4
   addu $t1,$t0,$t6
   lw $a0,0($t1)
   li $v0,1
   syscall

   la $a0,seperate   # 分隔数组元素
   li $v0,4
   syscall

   addi $t7,$t7,1
   blt $t7,$t8,print # 如果满足循环条件，跳转到print继续执行循环
