#Trabalho Semestral de AOC
#Guilherme Yamamoto Gonçalves, RA: 1110482622029, ADS Vespertino

#58. Entrar com o numero de termos da serie (n), (n > 0 e, caso nao seja, deve ser novamente solicitado), e imprimir o valor de H, 
#sendo: H = 1*2+3*2+5*2+... Observcao: cada multiplicacao eh um termo. Entender a serie eh fundamental para a resolucao do problema.

.data
	ext_intr_1: .asciiz "\nEsses detalhes extras que eu adicionei foi por diversão mesmo kkkk. Eu também elaborei\n"
	ext_intr_2: .asciiz "uma versão mais restrita, seguindo com mais rigor a proposta do trabalho, se preferir\n\n"
	termos_n: .asciiz "Bom dia Colevati, insira o número de termos da série (N), ela deve ser maior que 0: "
	erro: .asciiz "Eita! A quantidade de termos não pode ser menor nem igual a 0. Recomeçando do começo.\n\n"
	res: .asciiz "\n\nO valor de H é: "
	ext_termo_atual: .asciiz "\n\nO termo atual sendo iterado equivale a N = "
	ext_esp: .asciiz "\n"
	ext_adi: .asciiz " + "
	ext_mul: .asciiz " * "
	ext_igu: .asciiz " = "
	
.text
# t0 -> número de termos, t1 -> primeiro fator, t2 -> segundo fator, t3 -> resultado do produto da multiplicação, t4 -> contador de termos, t5 -> "variável" H

main:
	#Comentário de introdução
	li $v0, 4
	la $a0, ext_intr_1
	syscall
	la $a0, ext_intr_2
	syscall

inicio:
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
	j inicio

loop_serie:
	#Mostra o termo atual sendo iterado
	li $v0, 4
	la $a0, ext_termo_atual
	syscall
	
	li $v0, 1
	add $a0, $t4, 0
	syscall
	
	#Caractere de quebra de linha
	li $v0, 4
	la $a0, ext_esp
	syscall
	
	#Mostra o valor acumulado de H até o momento, para ser somado com o próximo termo
	li $v0, 1
	add $a0, $t5, 0
	syscall
	
	#Caractere de adição "+"
	li $v0, 4
	la $a0, ext_adi
	syscall
	
	#Mostra o fator móvel (que aumenta de 2 em 2)
	li $v0, 1
	add $a0, $t1, 0
	syscall
	
	#Caractere de multiplicação "*"
	li $v0, 4
	la $a0, ext_mul
	syscall
	
	#Mostra o fator estático (que vale 2)
	li $v0, 1
	add $a0, $t2, 0
	syscall
	
	#Caractere de igualdade "="
	li $v0, 4
	la $a0, ext_igu
	syscall
	
	#Realiza os cálculos
	
	#Multiplica os dois fatores ($t1 e ($t2) e guarda em ($t3);
	mul $t3, $t1, $t2
	
	#Incrementa 2 ao fator móvel ($t1);
	addi $t1, $t1, 2
	
	#Soma o resultado ao valor de H ($t5), mostrando em seguida;
	add $t5, $t5, $t3
	
	li $v0, 1
	add $a0, $t5, 0
	syscall	
	
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