require Random

class Die
    value: int
    selected: bool = false
    setAside: bool = false

    def Die
        self->roll()

    def roll
        value = randomInt(6)

    def select
        if !setAside
            selected = !selected
