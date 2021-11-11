require daslib/media

let STEP = 10

let VALUE_2_DIE <- [{auto
    [{int 0; 0; 0; 0; 1; 0; 0; 0; 0}];
    [{int 0; 0; 1; 0; 0; 0; 1; 0; 0}];
    [{int 0; 0; 1; 0; 1; 0; 1; 0; 0}];
    [{int 1; 0; 1; 0; 0; 0; 1; 0; 1}];
    [{int 1; 0; 1; 0; 1; 0; 1; 0; 1}];
    [{int 1; 1; 1; 0; 0; 0; 1; 1; 1}]
}]

def drawDie(x: int; y: int; value: int)
    fill_rect(x, y, STEP * 7, STEP * 7, 0x0000FF)
    for i in range(3)
        for j in range(3)
            if VALUE_2_DIE[value][i * 3 + j] == 1
                fill_rect(x + STEP + i * STEP * 2, y + STEP + j * STEP * 2, STEP, STEP, 0x000000)

