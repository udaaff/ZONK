require Round
require Random

let NUM_ROUNDS = 1

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

    def Zonk()
        self->startNewRound()

    def startNewRound
        if !self->canPlayNextRound()
            return
        round = new Round()
        ++numRounds
        state = ZonkState IN_ROUND

    def canPlayNextRound
        let playedRoundsLen = length(completedRounds)
        return playedRoundsLen == 0 || NUM_ROUNDS - playedRoundsLen > 1

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



