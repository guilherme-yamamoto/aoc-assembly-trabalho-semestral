#Trabalho Semestral de AOC
#Guilherme Yamamoto Gonçalves, RA: 1110482622029, ADS Vespertino

#58. Entrar com o numero de termos da serie (n), (n > 0 e, caso nao seja, deve ser novamente solicitado), e imprimir o valor de H, 
#sendo: H = 1*2+3*2+5*2+... Observcao: cada multiplicacao eh um termo. Entender a serie eh fundamental para a resolucao do problema.

### Essa é a versão enxuta, seguindo estritamente o que foi pedido na proposta de trabalho, sem imprimir dinamicamente os cálculos a serem feitos. ###

.data
	termos_n: .asciiz "Bom dia Colevati, insira o número de termos da série (N), ela deve ser maior que 0: "
	erro: .asciiz "Eita! A quantidade de termos não pode ser menor nem igual a 0. Recomeçando do começo.\n\n"
	res: .asciiz "\nO valor de H é: "
	ext_esp: .asciiz "\n"
	
.text
# t0 -> número de termos, t1 -> primeiro fator, t2 -> segundo fator, t3 -> resultado do produto da multiplicação, t4 -> contador de termos, t5 -> "variável" H

main:
	#Printa a mensagem pedindo os termos
	li $v0, 4
	la $a0, termos_n
	syscall
	
	#Insere quantidade de termos	
	li $v0, 5
	syscall
	
	#Copia para t0
	move $t0, $v0
	
	#Define o quanto vale os dois fatores iniciais da série, o contador de termos e o valor de H
	li $t1, 1
	li $t2, 2
	li $t4, 1
	li $t5, 0
	
	#Se menor/igual a zero, vai pro reenviar, se não, vai direto pro loop
	blez $t0, reenviar
	j loop_serie

reenviar:
	#Mensagem de erro e retorno ao main
	li $v0, 4
	la $a0, erro
	syscall
	j main

loop_serie:
	#Realiza os cálculos
	
	#Multiplica os dois fatores ($t1 e ($t2) e guarda em ($t3);
	mul $t3, $t1, $t2
	
	#Incrementa 2 ao fator móvel ($t1);
	addi $t1, $t1, 2
	
	#Soma o resultado ao valor de H ($t5)?
	add $t5, $t5, $t3
	
	#Incrementa 1 no contador de termos N ($t4), volta para o começo do loop ou segue para o fim
	addi $t4, $t4, 1
	bgt $t4, $t0, fim
	j loop_serie
	
fim:
	#Printa a resposta final, que é o valor de H ($t5)
	li $v0, 4
	la $a0, res
	syscall
	
	li $v0, 1
	add $a0, $t5, 0
	syscall

	#Encerra o programa
	li $v0, 10
	syscall