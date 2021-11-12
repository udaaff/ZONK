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

def drawDie(x: int; y: int; value: int; size: int = 56; selected = false; setAside = false)
    let step = size / 7
    fill_rect(x, y, size, size, setAside ? 0x008080 : 0x00FFFF)

    if selected
        set_font_size(14)
        let hold = "HOLD"
        let holdSize = get_text_size(hold)
        text_out(x + size / 2 - int(holdSize.x) / 2, y + size, hold, 0x00FF00)

    for i in range(3)
        for j in range(3)
            if VALUE_2_DIE[value][i * 3 + j] == 1
                fill_rect(x + step + i * step * 2, y + step + j * step * 2, step, step, 0x000000)

def drawCombos(x: int; y: int; w: int; combs: auto)
    let comboHeight = 40
    var numCombos = length(combs)
    fill_rect(x, y, w, numCombos * comboHeight, 0x0000FF)
    for i in range(numCombos)
        drawCombo(x, y + i * comboHeight, w, comboHeight, combs[i])
    return

def drawCombo(x: int; y: int; w: int; h: int; comb: Comb?)
    let dieSize = 28
    let gap = h / 2 - dieSize / 2
    rect(x + 1, y + 1, w - 2, h - 2, 0xFFFFFF)
    for i in range(length(comb.diceVals))
        drawDie(gap + x + i * (dieSize + gap), gap + y, comb.diceVals[i], dieSize, false, false)
    set_font_size(14)
    var score = "{comb.score}"
    var scoreSize = get_text_size(score)
    text_out(x + w - gap - int(scoreSize.x), y + h / 2 - int(scoreSize.y) / 2, score, 0xFFFFFF)

def drawPlayerInfo(var zonk: Zonk?; x: int; y: int)
    let width = 140
    let gap = 6
    let color = 0xFFFFFF
    fill_rect(x, y, width, 140, 0x0000FF)
    rect(x + 2, y + 2, width - 4, width - 4, 0xFFFFFF)
    set_font_size(14)
    let roundInfo = "Round {zonk.numRounds} of {NUM_ROUNDS}"
    var nameSize = get_text_size(roundInfo)
    text_out(x + gap, y + gap, roundInfo, color)
    line(x + gap, y + int(nameSize.y) + gap, x + width - gap, y + int(nameSize.y) + gap, color)
    text_out(x + gap, y + gap * 2 + int(nameSize.y), "Score: {zonk.round.score}", color)
    text_out(x + gap, y + gap * 2 + int(nameSize.y) * 2, "Bank: {zonk.bank}", color)
    text_out(x + gap, y + gap * 2 + int(nameSize.y) * 3, "Goal: {zonk.goal}", color)
    text_out(x + gap, y + gap * 2 + int(nameSize.y) * 4, "Bet: {zonk.bet}", color)
    text_out(x + gap, y + gap * 2 + int(nameSize.y) * 5, "Balance: {zonk.balance}", color)

def drawDice(var zonk: Zonk?)
    let length = length(zonk.round.dice)
    if length == 0
        return
    let gap = 8
    for i in range(length)
        let die = zonk.round.dice[i]
        drawDie(gap + gap * gap * i, gap, die.value, gap * 7, die.selected, die.setAside)

def drawState(var zonk: Zonk?; x: int; y: int)
    let state = getStateText(zonk)
    set_font_size(16)
    var stateSize = get_text_size(state)
    text_out(x - int(stateSize.x) / 2 , y - int(stateSize.y) / 2, state, 0xFFFFFF)

def private getStateText(var zonk: Zonk?): string
    if zonk.state == ZonkState HALTED
        return "Press [F5] to start over. "

    if zonk.state == ZonkState IN_ROUND
        var res: string = ""
        if zonk.round.canSetAside
            res += "Press [1-5] to select dice. Press [SPACE] to hold. "
        if zonk.round.canBankScore
            res += "Press [SHIFT] to bank. "
        if zonk.round.canThrowDice
            res += "Press [ENTER] to roll. "
        return res

    if zonk.state == ZonkState WAIT_FOR_ROUND
        return "Press [ENTER] to roll new round. "

    return "-"

def drawInfo(var zonk: Zonk?; x: int; y: int)
    let info = getInfoText(zonk)
    set_font_size(40)
    var infoSize = get_text_size(info)
    text_out(x, y - int(infoSize.y) / 2, info, 0xFF00FF)
    return

def private getInfoText(var zonk: Zonk?)
    if zonk.state == ZonkState HALTED
        let sign = zonk.bank >= zonk.goal ? "+" : "-"
        return "BALANCE {sign}{zonk.bet * BET_MULT}"
    if zonk.round.completed && zonk.round.score == 0
        return "ZONK"
    if zonk.round.completed
        return "BANK {zonk.round.score}"
    if zonk.round.prizeRound
        return "PRIZE ROUND!"
    if zonk.round.dice |> length() == 0
        return "BET {zonk.bet}"

    return ""

def drawBG(w: int; h: int)
    let gap = 8
    let bottom = 54
    line(gap, h - bottom, w - gap, h - bottom, 0xFFFFFF)
    line(gap, h - bottom + 2, w - gap, h - bottom + 2, 0xFFFFFF)
    return


