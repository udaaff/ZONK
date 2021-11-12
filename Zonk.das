require Round
require Random
require daslib/media
require strings

let NUM_ROUNDS = 10
let DEFAULT_BALANCE = 2000

enum ZonkState
    IN_ROUND
    WAIT_FOR_ROUND
    COMPLETED
    HALTED

class Zonk
    bank: int = 0
    numRounds: int = 0
    round: Round?
    completedRounds: array<Round?>
    state: ZonkState
    goal: int
    bet: int
    balance: int

    def Zonk(goal_: int = 100; bet_: int = 200)
        goal = goal_
        bet = bet_

        let balanceStr = local_storage_get("zonk_balance")
        balance = balanceStr == "" ? DEFAULT_BALANCE : to_int(balanceStr)
        self->startNewRound()

    def startNewRound
        if !self->canPlayNextRound()
            return
        round = new Round()
        ++numRounds
        state = ZonkState IN_ROUND

        if numRounds == 1
            balance -= bet
            local_storage_set("zonk_balance", "{balance}")

    def canPlayNextRound
        return numRounds < NUM_ROUNDS

    def act
        if state == ZonkState HALTED
            return

        if (round?.completed ?? false) && state == ZonkState IN_ROUND
            bank += round.score
            completedRounds |> push(round)
            state = self->canPlayNextRound() ? ZonkState WAIT_FOR_ROUND : ZonkState COMPLETED
            return

        if state == ZonkState COMPLETED
            if bank >= goal
                balance += bet * 2
                local_storage_set("zonk_balance", "{balance}")
            state = ZonkState HALTED



