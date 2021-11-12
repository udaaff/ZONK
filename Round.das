require Die
require Combos

let NUM_DICE = 5

class Round
    score: int = 0
    dice: array<Die?>
    combos: array<array<Die?>>
    canThrowDice: bool = true
    canSetAside: bool = false
    canBankScore: bool = false
    completed: bool = false
    prizeRound: bool = false

    def throwDice
        if !canThrowDice
            return

        canThrowDice = false
        canBankScore = false

        if dice |> length() == 0
            for i in range(NUM_DICE)
                push(dice, new Die())

        for die in dice
            if !die.setAside
                die->roll()

        var vals <- self->getVals()
        if !hasComb(vals)
            score = 0
            completed = true
        else
            canSetAside = true

    def setAside
        if !canSetAside
            return

        var selectedVals <- self->getSelectedVals()
        if selectedVals |> length() == 0
            return

        let combsValue = selectedVals |> calculate()
        if combsValue == 0
            return

        prizeRound = true
        for die in dice
            if die.selected
                die.selected = false
                die.setAside = true
            if !die.setAside
                canThrowDice = true
                prizeRound = false

        score += combsValue
        canSetAside = false
        canBankScore = true

        if prizeRound
            canThrowDice = true
            for die in dice
                die.setAside = false

    def private getSelectedVals(): array<int>
        var res: array<int>
        for die in dice
            if die.selected
                push(res, die.value)
        return <- res

    def private getVals(): array<int>
        var res: array<int>
        for die in dice
            if !die.setAside
                push(res, die.value)
        return <- res

    def bankScore
        if canBankScore
            canBankScore = false
            canSetAside = false
            canThrowDice = false
            completed = true
