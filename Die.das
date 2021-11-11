require Random

class Die
    value: int
    selected = false
    setAside = false

    def Die
        self->roll()

    def roll
        value = randomInt(6)
