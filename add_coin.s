.text
# ADD_COIN 
#       >>> a0 = Endereço da matriz do jogo
#       >>> a1 = Coluna (número de 0 a 6)
#       >>> a2 = Endereco da imagem da moeda
#       >>> a3 = Qual a moeda (1 = vermelha, 2 = amarela)
#       >>> a4 = Endereço da lista de moedas

ADD_COIN:
  # salva registradores na pilha
  addi sp, sp, -32
  sw ra, 28(sp)
  sw t0, 24(sp)
  sw t1, 20(sp)
  sw t2, 16(sp)
  sw t3, 12(sp)
  sw t4, 8(sp)
  sw t5, 4(sp)
  sw t6, 0(sp)

  # t0 = Endereço da matriz do jogo
  mv t0, a0
  # t1 = Endereço do primeiro elemento da coluna a1
  li t1, 1 
  mul t1, t1, a1
  add t1, t1, a0

  # verifica se a primeira posicao ja esta ocupada
  lb t2, 0(t1) 
  bne t2, zero, RET_ADD_COIN

  # Endereco do proximo elemento
  addi t2, t1, 7
  # Posicao final da matriz
  li t3, 42
  add t3, t3, a0

  LOOP_ADD_COIN:
    bgt t2, t3, SAVE_ADD_COIN 	# se t2 > que o tamanho da matriz, salvo t1

    lb t4, 0(t2) 
    bne t4, zero, SAVE_ADD_COIN	# se t2 nao for um espaco em branco, salvo t1

    addi t1, t1, 7
    addi t2, t2, 7
    jal zero, LOOP_ADD_COIN

  SAVE_ADD_COIN:
    mv t5, a3		# salvo o registrador a3 
    jal COIN_ANIMATION	# faz a animacao da moeda caindo
    sb t5, 0(t1)	# salva a moeda na matriz
      LOOP2_ADD_COIN:
      lw t0, 0(a4)
      addi a4, a4, 8
      bnez t0, LOOP2_ADD_COIN
      sw t1, -8(a4)
      sw t6, -4(a4)    


  RET_ADD_COIN:
    # Dando load nos valores salvos da pilha
    lw t6, 0(sp)
    lw t5, 4(sp)
    lw t4, 8(sp)
    lw t3, 12(sp)
    lw t2, 16(sp)
    lw t1, 20(sp)
    lw t0, 24(sp)
    lw ra, 28(sp)
    addi sp, sp, 32
    # Retorna
    ret
 
