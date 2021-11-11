require Round
require Random

class Zonk

    bank = 0
    numRounds = 0
    round: Round?

    def Zonk()
        round = new Round()
        round->throwDice()