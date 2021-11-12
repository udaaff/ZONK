require daslib/media
require Combos
require Die
require Zonk

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

def drawPlayerInfo(x: int; y: int; name: string; bank: int; score: int; color: uint)
    let width = 120
    let gap = 6
    rect(x, y, width, width, 0x00FF00)
    set_font_size(14)
    var nameSize = get_text_size(name)
    text_out(x + gap, y, name, color)
    text_out(x + gap, y + int(nameSize.y), "Score: {score}", color)
    text_out(x + gap, y + int(nameSize.y) * 2, "Bank: {bank}", color)

def drawDices(dices: array<Die?>)
    let length = length(dices)
    if length == 0
        return
    let gap = 8
    for i in range(length)
        let die = dices[i]
        drawDie(gap + gap * gap * i, gap, die.value, gap * 7, die.selected, die.setAside)

def drawState(var zonk: Zonk?; x: int; y: int)
    let state = getStateText(zonk)
    set_font_size(16)
    var stateSize = get_text_size(state)
    text_out(x - int(stateSize.x) / 2 , y - int(stateSize.y) / 2, state, 0xFFFFFF)

def private getStateText(var zonk: Zonk?): string
    if zonk.state == ZonkState COMPLETED
        return "Game over"
    if zonk.state == ZonkState IN_ROUND
        var res: string = ""
        if zonk.round.canSetAside
            res += "Press [1-5] to select dice. Press [SPACE] to hold. "
        if zonk.round.canBankScore
            res += "Press [SHIFT] to bank."
        if zonk.round.canThrowDice
            res += "Press [ENTER] to roll. "
        return res

        if zonk.round.completed && zonk->canPlayNextRound()
            return "Round result: {zonk.round.score == 0 ? "ZONK" : string(zonk.round.score)}. Press RETURN to roll."
    return "not defined yet"

