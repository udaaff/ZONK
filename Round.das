require Die
require Combos

let NUM_DICE = 5

class Round
    score: int = 0
    dice: array<Die?>
    combos: array<array<Die?>>
    canThrowDice: bool = true
    canSetAside: bool = true
    canBankScore: bool = false
    completed: bool = false

    def Round
        for i in range(NUM_DICE)
            push(dice, new Die())

    def throwDice
        if !canThrowDice
            return

        for die in dice
            die->roll()

        var vals <- self->getVals()
        if !hasComb(vals)
            score = 0
            completed = true
            print("ZONK")

        for i in range(NUM_DICE)
            print("[{dice[i].value + 1}] ")

    def setAside
        if !canSetAside
            return

        var selectedVals <- self->getSelectedVals()
        if selectedVals |> length() == 0
            return

        let combsValue = selectedVals |> calculate()
        if combsValue == 0
            return

        // make prize round instad of completion
        completed = true
        for die in dice
            die.setAside = die.selected
            if !die.setAside
                completed = false

        canSetAside = false
        // make some threshold
        canBankScore = true
        return

    def private getSelectedVals(): array<int>
        var res: array<int>
        for die in dice
            if (!die.setAside && die.selected)
                push(res, die.value)
        return <- res

    def private getVals(): array<int>
        var res: array<int>
        for die in dice
            push(res, die.value)
        return <- res

    def bankScore
        if score == 0
            return

    def toString
        for i in range(NUM_DICE)
            print("[{dice[i].value}] ")
