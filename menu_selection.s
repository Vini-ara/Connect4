.text
# MENU_SELECTION
#     - Implementa a logica de seleção de cor e dificuldade do menu do jogo

MENU_SELECTION:
  # salva os registradores utilizados
  addi sp, sp, -4
  sw ra, 0(sp)

  COLOR_MENU_LOOP:
    jal GET_KEYPRESS # salva em a0 o caractere pressionado pelo usuario
    
    li t1, 'a'  # t1 = 'd' (utilizado para comparacao)
    beq a0, t1, SET_YELLOW  # se 'd' foi apertado, o usuario escolheu amarelo

    li t1, 'v' # t1 = 'a' 
    beq a0, t1, SET_RED # se 'a' foi apertado, ele escolheu vermelho

    li t1, '1'
    beq a0, t1, SET_EASY

    li t1, '2'
    beq a0, t1, SET_MEDIUM

    li t1, '3'
    beq a0, t1, SET_HARD

    li t1, ' '
    beq a0, t1, RET_MENU_SELECTION

    jal zero, COLOR_MENU_LOOP # se nao foi uma das ultimas teclas, volta para o loop

    SET_YELLOW:
      la s2, yellow_coin # cor do jogador = amarela
      la s3, red_coin
      la s5, yellow_won
      la t0, red_won
	la t1, reg_s6
	sw t0, (t1)
      jal zero, COLOR_MENU_LOOP # volta para o loop
      
    SET_RED:
      la s2, red_coin # cor do jogador = vermelha
      la s3, yellow_coin
      la s5, red_won
      la t0, yellow_won
	la t1, reg_s6
	sw t0, (t1)
      jal zero, COLOR_MENU_LOOP # volta para o loop

    SET_EASY:
      li s1,0 # dificuldade do jogo = facil
      jal zero, COLOR_MENU_LOOP # volta para o loop

    SET_MEDIUM:
      li s1, 1 # dificuldade do jogo = medio
      jal zero, COLOR_MENU_LOOP # volta para o loop

    SET_HARD:
      li s1, 2 # dificuldade do jogo = dificil
      jal zero, COLOR_MENU_LOOP # volta para o loop

  RET_MENU_SELECTION:
  # Recupera os registradores salvos
  lw ra, 0(sp)
  addi sp, sp, 4
  #Retorna
  ret
