.data
.include "data/tile.data"
.include "data/red_coin.data"
.include "data/yellow_coin.data"
.include "data/menu.data"
.include "data/options.data"
.include "data/yellow_won.data"
.include "data/red_won.data"
.include "data/tie_img.data"


# Tabuleiro do jogo
grid: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

altura: .byte 0,0,0,0,0,0,0
vetor_maiores: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

# Ponteiros/ coluna das moedas jogadas por cada jogador
player_coins:   .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ai_coins:       .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text	
SET_UP:
	li s0, 1
	li s1, 2 			# nivel dificil
  	la s2, red_coin 	# cor do jogador
	la s3, yellow_coin 	# cor da ia
	la s4, grid			# endereço bolado
	addi s4, s4, 20
	la s5, red_won
	la s6, yellow_won

	jal MENU_SET_UP

MENU_SET_UP:
  	jal CLEAR_SCREEN
	la a0, menu
  	li a1, 0
  	li a2, 0
  	li a3, 0
  	jal DRAW_IMAGE

  	jal MENU_SELECTION

  	jal CLEAR_SCREEN

	la a0, grid
	jal DRAW_GRID
	jal GAMELOOP

GAMELOOP_SET_UP:
	jal CLEAR_SCREEN
	jal DRAW_GRID
	jal GAMELOOP

GAMELOOP:
#	li a0,1
#	jal melhor_jogada
#	li t0,4
#	bge a0,t0,FIM
#	li a0,2
#	jal melhor_jogada
#	li t0,4
#	bge a0,t0,FIM


	bltz s0,VEZ_PC
	jal KEY1
	mv a1,a0
	addi a1,a1,-48 #transforma string em int
	#atualiza altura da coluna
	la t0,altura
	add t0,t0,a1
	lb t1,0(t0)
	addi t1,t1,1
	sb t1,0(t0)
	#continua com os argumentos de ADD_COIN
	
	la a0,grid
	mv a2, s2
	li a3,1
	la a4, player_coins
	jal ADD_COIN
	jal PRINTA_MATRIZ
	

	# Verifica se o jogador venceu
	li a0, 1
	la a1, player_coins
	jal CHECK_VICTORY
	bnez a0, WIN_SCREEN
	
	
	#muda jogador
	li t0,-1
	mul s0,s0,t0
	jal zero,GAMELOOP
	
VEZ_PC:

	li t0,2
	beq s1,t0,ESCOLHA_DIFICIL 
	li t0,1
	beq s1,t0,ESCOLHA_MEDIA
	jal zero,ESCOLHA_FACIL
	
	#atualiza altura da coluna
JOGADA_PC:
	la t0,altura
	add t0,t0,a1
	lb t1,0(t0)
	addi t1,t1,1
	sb t1,0(t0)
	#continua com os argumentos de ADD_COIN
	
	la a0, grid
	mv a2, s3
	li a3, 2
	la a4, ai_coins
	jal ADD_COIN

	# Verifica se a IA ganhou
	li a0, 2
	la a1, ai_coins
	jal CHECK_VICTORY
	bnez a0, LOSE_SCREEN

	la a0, altura
	jal CHECK_TIE
	bnez a0, TIE_SCREEN

	
	#muda jogador
	li t0,-1
	mul s0, s0, t0
	
	jal PRINTA_MATRIZ
	
	jal zero,GAMELOOP
	


FIM:	
INFINITO:
	# jal zero,INFINITO
	li a7, 32
    li a0, 2500
    ecall
	
	li a7, 10
	ecall


### Espera o usuário pressionar uma tecla
KEY1: 	li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
LOOP: 	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,LOOP		# não tem tecla pressionada então volta ao loop
   	lw a0,4(t1)			# le o valor da tecla
	ret				# retorna
	
.include "coin_animation.s"
.include "draw_grid.s"
.include "add_coin.s"
.include "inteligencia.asm"
.include "get_keypress.s"
.include "menu_selection.s"
.include "clear_screen.s"
.include "check_victory.s"
.include "end_menu.s"
.include "draw_image.s"
.include "check_tie.s"
.include "clear_vector.s"
