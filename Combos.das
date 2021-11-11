def calculate(var dieVals: array<int>): int
    sort(dieVals)
    var i = 0
    var score = 0
    let len = length(dieVals)
    while (i < len)
        let curVal = dieVals[i]
        if len - i > 2 && curVal == dieVals[i + 1] && curVal == dieVals[i + 2]
            i += 2
            score += (curVal + 1) * (curVal == 0 ? 1000 : 100)
        elif curVal == 0
            score += 100
        elif curVal == 4
            score += 50
        else
            score = 0
            break
        ++i
    return score

def hasComb(var dieVals: array<int>): bool
    sort(dieVals)
    var i = 0
    let len = length(dieVals)
    while (i < len)
        let curVal = dieVals[i]
        if len - i > 2 && curVal == dieVals[i + 1] && curVal == dieVals[i + 2] || curVal == 0 || curVal == 4
            return true
        ++i
    return false