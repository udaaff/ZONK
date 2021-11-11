require Die
require Combos

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
        var selectedDice <- self->getSelectedDice()
        if selectedDice |> length() == 0
            return

        let combsValue = selectedDice |> calculate()

        for die in dice
            if !die.setAside && die.selected
                die.setAside = true
        return

    def private getSelectedDice(): array<int>
        var res: array<int>
        for die in dice
            if (!die.setAside && die.selected)
                push(res, die.value)
        return <- res

    def bankScore
        return

    def toString
        for i in range(NUM_DICE)
            print("[{dice[i].value}] ")
