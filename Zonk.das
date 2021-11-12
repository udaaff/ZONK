require Round
require Random

let NUM_ROUNDS = 2

enum ZonkState
    IN_ROUND
    WAIT_FOR_ROUND
    COMPLETED

class Zonk
    bank: int = 0
    numRounds = 0
    round: Round?
    completedRounds: array<Round?>
    state: ZonkState

    def Zonk()
        self->startNewRound()

    def startNewRound
        round = new Round()
        state = ZonkState IN_ROUND

    def canPlayNextRound(): bool
        return completedRounds |> length() < NUM_ROUNDS

    def act
        if round.completed && state == ZonkState IN_ROUND
            bank += round.score
            completedRounds |> push(round)
            state = ZonkState WAIT_FOR_ROUND


