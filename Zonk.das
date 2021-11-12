require Round
require Random

let NUM_ROUNDS = 2

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

    def Zonk(goal_: int = 5000)
        goal = goal_
        self->startNewRound()

    def startNewRound
        if !self->canPlayNextRound()
            return
        round = new Round()
        ++numRounds
        state = ZonkState IN_ROUND

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

            state = ZonkState HALTED



