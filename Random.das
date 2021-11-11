require daslib/media

var seed: int4

def randomizeSeed
    randomize_seed(seed)

def randomInt(value: int)
    return random_int(seed) % value