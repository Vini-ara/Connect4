.data
.include "data/tile.data"
.include "data/options.data"
.include "data/red_won.data"
.include "data/red_coin.data"
.include "data/yellow_coin.data"

grid: .byte 1, 2, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
.text
    la s2, red_coin
    la s3, yellow_coin
    la s6, red_won
    la a0, grid
    jal DRAW_GRID
    jal LOSE_SCREEN

    li a7, 10
    ecall



.include "draw_image.s"
.include "lose_screen.s"
.include "draw_grid.s"
.include "clear_vector.s"
.include "get_keypress.s"
