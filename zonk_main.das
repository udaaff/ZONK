require daslib/media
options debugger            // uncomment for debug in VS Code
require daslib/debug        // uncomment for debug in VS Code

require Random
require Round
require Die
require view
require Zonk
require Combos

var round: Round?
var zonk: Zonk?

// 'initialize' runs once when game starts and every hot-reload
[export]
def initialize
    // set_resolution(320, 200)
    set_window_title("ZONK")
    randomizeSeed()
    // round = new Round()
    // round->throwDice()
    zonk = new Zonk()
    return

// this function is called to update game data,
// dt - time elapsed since the previous update (in seconds)
[export]
def act(dt: float)
    if get_key(VK_ESCAPE)
        schedule_quit_game()
    if get_key_down(VK_1)
        selectDie(0)
    if get_key_down(VK_2)
        selectDie(1)
    if get_key_down(VK_3)
        selectDie(2)
    if get_key_down(VK_4)
        selectDie(3)
    if get_key_down(VK_5)
        selectDie(4)
    if get_key_down(VK_SPACE)
        setAside()
    return

// this function will be called every frame after 'act',
// you can draw anything in this function
[export]
def draw
    let gap = 8
    for i in range(length(zonk.round.dice))
        let die = zonk.round.dice[i]
        drawDie(gap + gap * gap * i, gap, die.value, gap * 7, die.selected, die.setAside)

    drawPlayerInfo(6, 200, "Player 1", zonk.bank, 0xFF00FF)
    drawCombos(340, gap, 200, CombosList)
    return

// commands
def selectDie(dieIndex: int)
    zonk.round.dice[dieIndex]->select()

def setAside
    zonk.round->setAside()

def throwDice
    zonk.round->throwDice()

def bankScore
    zonk.round->bankScore()
