.text
END_MENU:
    # Printar opções
    la a0, options
    li a1, 240
    li a2, 200
    mv a3, zero
    jal DRAW_IMAGE

    # Resetar o turno
    li s0, 1
    # Limpar grid
    la a0, grid
    li a1, 42
    jal CLEAR_VECTOR

    # Limpar vetor de alturas
    la a0, altura
    li a1, 7
    jal CLEAR_VECTOR

    # Limpar vetor_maiores
    la a0, vetor_maiores
    li a1, 10
    jal CLEAR_VECTOR

    # Limpar lista de moedas do jogador
    la a0, player_coins
    li a1, 168
    jal CLEAR_VECTOR

    # Limpar lista de moedas da IA
    la a0, ai_coins
    li a1, 168
    jal CLEAR_VECTOR

    Loop_Lose_Screen:
        jal GET_KEYPRESS # salva em a0 o caractere pressionado pelo usuario
    
        li t1, '1'
        beq a0, t1, GAMELOOP_SET_UP

        li t1, '2'
        beq a0, t1, SET_UP

        j Loop_Lose_Screen 



LOSE_SCREEN:
    lw a0, reg_s6
    li a1, 240
    li a2, 180
    mv a3, zero
    jal DRAW_IMAGE

    jal END_MENU

WIN_SCREEN:
    mv a0, s5
    li a1, 240
    li a2, 180
    mv a3, zero
    jal DRAW_IMAGE

    jal END_MENU

TIE_SCREEN:
    la a0, tie_img
    li a1, 240
    li a2, 180
    mv a3, zero
    jal DRAW_IMAGE

    jal END_MENU
