require daslib/media
options debugger            // uncomment for debug in VS Code
require daslib/debug        // uncomment for debug in VS Code
require Random
require view
require Zonk
require Combos

let APP_WIDTH = 600
let APP_HEIGHT = 400

var zonk: Zonk?
var help: bool = false

[export]
def initialize
    disable_auto_upscale()
    set_antialiasing(0)
    set_resolution(APP_WIDTH, APP_HEIGHT)
    set_window_title("ZONK")
    randomizeSeed()
    zonk = new Zonk()

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
    if get_key_down(VK_F1)
        help = !help

[export]
def draw
    zonk |> drawDice()
    zonk |> drawPlayerInfo(8, 170)
    zonk |> drawState(APP_WIDTH / 2, APP_HEIGHT - 30)
    zonk |> drawInfo(20, 100)

    drawCombos(APP_WIDTH - 200 - 8, 8, 200, CombosList)
    drawBG(APP_WIDTH, APP_HEIGHT)
    drawF1(10, APP_HEIGHT - 80)

    if help
        drawHelp(APP_WIDTH, APP_HEIGHT)

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
