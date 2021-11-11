require Die

let NUM_DICE = 5

class Round
    score = 0
    dice: array<Die?>
    combos: array<array<Die?>>


    def Round
        for i in range(NUM_DICE)
            push(dice, new Die())

    def throwDice
        for die in dice
            die->roll()

        for i in range(NUM_DICE)
            print("[{dice[i].value}] ")

    def setAside
        // check to see if selected dice could be all combined in combos
        // if not return

        for die in dice
            if die.setAside
                continue

        return

    def private calculateScore
        return 100

    def bankScore
        return

    def toString
        for i in range(NUM_DICE)
            print("[{dice[i].value}] ")
