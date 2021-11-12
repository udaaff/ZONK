require daslib/media
options debugger            // uncomment for debug in VS Code
require daslib/debug        // uncomment for debug in VS Code

require Random
require Round
require Die
require view
require Zonk
require Combos

let APP_WIDTH = 600
let APP_HEIGHT = 400

var round: Round?
var zonk: Zonk?

// 'initialize' runs once when game starts and every hot-reload
[export]
def initialize
    disable_auto_upscale()
    set_resolution(APP_WIDTH, APP_HEIGHT)
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
    if get_key_down(VK_LSHIFT) || get_key_down(VK_RSHIFT)
        bankScore()
    return

// this function will be called every frame after 'act',
// you can draw anything in this function
[export]
def draw
    zonk |> drawDice()
    zonk |> drawPlayerInfo(8, 190)
    zonk |> drawState(APP_WIDTH / 2, APP_HEIGHT - 30)
    zonk |> drawInfo(20, 120)

    drawCombos(APP_WIDTH - 200 - 8, 8, 200, CombosList)
    drawBG(APP_WIDTH, APP_HEIGHT)
    return

// commands
def selectDie(dieIndex: int)
    if zonk.round.canSetAside
        zonk.round.dice[dieIndex]->select()

def setAside
    zonk.round->setAside()

def throwDice
    if zonk.state == ZonkState WAIT_FOR_ROUND
        zonk->startNewRound()
        return

    zonk.round->throwDice()

def bankScore
    zonk.round->bankScore()
