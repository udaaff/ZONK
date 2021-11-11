require daslib/media

let STEP = 8

let VALUE_2_DIE <- [{auto
    [{int 0; 0; 0; 0; 1; 0; 0; 0; 0}];
    [{int 0; 0; 1; 0; 0; 0; 1; 0; 0}];
    [{int 0; 0; 1; 0; 1; 0; 1; 0; 0}];
    [{int 1; 0; 1; 0; 0; 0; 1; 0; 1}];
    [{int 1; 0; 1; 0; 1; 0; 1; 0; 1}];
    [{int 1; 1; 1; 0; 0; 0; 1; 1; 1}]
}]

def drawDie(x: int; y: int; value: int; selected: bool; setAside: bool)
    let w = STEP * 7
    fill_rect(x, y, w, w, 0x0000FF)

    if setAside
        rect(x, y, w, w, 0xFFFFFF)
    elif selected
        //2rect(x, y, w, w, 0xFFFFFF)
        set_font_size(14)
        let hold = "hold"
        let holdSize = get_text_size(hold)
        text_out(x + w / 2 - int(holdSize.x) / 2, y + w, hold, 0xFF00FF)

    for i in range(3)
        for j in range(3)
            if VALUE_2_DIE[value][i * 3 + j] == 1
                fill_rect(x + STEP + i * STEP * 2, y + STEP + j * STEP * 2, STEP, STEP, 0x000000)




def drawPlayerInfo(x: int; y: int; name: string; score: int; color: uint)
    let width = STEP * 14
    rect(x, y, width, width, 0x00FF00)
    set_font_size(14)
    var nameSize = get_text_size(name)
    text_out(x + width / 2 - int(nameSize.x) / 2, y, name, color)
    text_out(x + width / 2 - int(nameSize.x) / 2, y + int(nameSize.y), "Score: {score}", color)


