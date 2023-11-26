.data

#strings para saber se é ou não é capicua
msgcap:    .asciiz "É capicua"
msgnaocap: .asciiz "Não é capicua"

#número verificado. Pode ser alterado e depois, será verificado pelo algoritimo
numero:    .word   9109000

.text

#começa com um "main"
.globl  main

main:


point:
#carrega o numero
    lw $t0, numero         
    move $t1, $t0

#print do processo do número
    li $v0, 1            
    move $a0, $t0          
    syscall
    
    li $v0, 11 
    li $a0, '\n'
    syscall
    
#manda para a função, valor volta em $t1
    jal reverse             

#número invertido não é igual ao original, passa pra not_capicua
    bne $t0, $t1, nao_capicua
    
#string que vai ser impressa caso não seja capicua
    li $v0, 4
    la $a0, msgcap
    syscall
    
#nova linha
    li      $v0, 11 
    li      $a0, '\n'
    syscall
    
#kthxbye
    li $v0, 10
    syscall

nao_capicua:

#manda para achar o valor capicua próximo, valor volta em $t1
    j incrementa

#essa parte só serve para teste, caso um valor acabe escapando no meio dos testes
#string que vai ser impressa caso não seja capicua
    li $v0, 4
    la $a0, msgnaocap
    syscall

#kthxbye
    li $v0, 10
    syscall

incrementa:
#pega a variavel numero, aumenta 1 e retorna tudo de novo
    lw      $t0, numero      
    addi    $t0, $t0, 1      
    sw      $t0, numero
    
    j main

reverse:
# $t2 vai receber o valor, e depois vai ter a comparação
    li $t2, 0              

reverse_loop:
# $t3 pega o ultimo digito do numero
    rem $t3, $t0, 10
#multiplica o número invertido por 10
    mul $t2, $t2, 10
#adiciona o último dígito ao número invertido
    add $t2, $t2, $t3
#remove o último dígito do número original        
    div $t0, $t0, 10

#enquanto não for igual á zero, repete
    bnez $t0, reverse_loop

#coloca o número invertido de volta pra $t0
    move $t0, $t2
#retorna
    jr $ra
