require daslib/media
require Combos

let STEP = 8

let VALUE_2_DIE <- [{auto
    [{int 0; 0; 0; 0; 1; 0; 0; 0; 0}];
    [{int 0; 0; 1; 0; 0; 0; 1; 0; 0}];
    [{int 0; 0; 1; 0; 1; 0; 1; 0; 0}];
    [{int 1; 0; 1; 0; 0; 0; 1; 0; 1}];
    [{int 1; 0; 1; 0; 1; 0; 1; 0; 1}];
    [{int 1; 1; 1; 0; 0; 0; 1; 1; 1}]
}]

def drawDie(x: int; y: int; value: int; size: int = 56; selected = false; setAside = false; color = 0x0000FF)
    let step = size / 7
    fill_rect(x, y, size, size, color)

    if setAside
        rect(x, y, size, size, 0xFFFFFF)
    elif selected
        set_font_size(14)
        let hold = "hold"
        let holdSize = get_text_size(hold)
        text_out(x + size / 2 - int(holdSize.x) / 2, y + size, hold, 0xFF00FF)

    for i in range(3)
        for j in range(3)
            if VALUE_2_DIE[value][i * 3 + j] == 1
                fill_rect(x + step + i * step * 2, y + step + j * step * 2, step, step, 0x000000)

def drawCombos(x: int; y: int; w: int; combs: auto)
    let comboHeight = 40
    var numCombos = length(combs)
    fill_rect(x, y, w, numCombos * comboHeight, 0xC0C0C0)
    for i in range(numCombos)
        drawCombo(x, y + i * comboHeight, w, comboHeight, combs[i])
    return

def drawCombo(x: int; y: int; w: int; h: int; comb: Comb?)
    let dieSize = 28
    let gap = h / 2 - dieSize / 2
    line(x + gap, y + h, x + w - gap * 2, y + h, 0x000000)
    for i in range(length(comb.diceVals))
        drawDie(gap + x + i * (dieSize + gap), gap + y, comb.diceVals[i], dieSize, false, false, 0x00FFFF)
    set_font_size(14)
    var score = "{comb.score}"
    var scoreSize = get_text_size(score)
    text_out(x + w - gap - int(scoreSize.x), y + h / 2 - int(scoreSize.y) / 2, score, 0x000000)

def drawPlayerInfo(x: int; y: int; name: string; score: int; color: uint)
    let width = STEP * 14
    rect(x, y, width, width, 0x00FF00)
    set_font_size(14)
    var nameSize = get_text_size(name)
    text_out(x + width / 2 - int(nameSize.x) / 2, y, name, color)
    text_out(x + width / 2 - int(nameSize.x) / 2, y + int(nameSize.y), "Score: {score}", color)


