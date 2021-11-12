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
    disable_auto_upscale()
    set_resolution(800, 600)
    set_window_title("ZONK")
    randomizeSeed()
    zonk = new Zonk()
    return

// this function is called to update game data,
// dt - time elapsed since the previous update (in seconds)
[export]
def act(dt: float)
    zonk->act()
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
    if get_key_down(VK_RETURN)
        throwDice()
    return

// this function will be called every frame after 'act',
// you can draw anything in this function
[export]
def draw
    drawDices(zonk.round.dice)
    drawPlayerInfo(6, 200, "Player 1", zonk.bank, zonk.round.score, 0xFF00FF)
    drawCombos(340, 8, 200, CombosList)
    drawState(zonk, 400, 500)
    return

// commands
def selectDie(dieIndex: int)
    if zonk.round.canSetAside
        zonk.round.dice[dieIndex]->select()

def setAside
    zonk.round->setAside()

def throwDice
    zonk.round->throwDice()

def bankScore
    zonk.round->bankScore()
