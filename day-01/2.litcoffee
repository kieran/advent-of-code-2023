# Part Two

Your calculation isn't quite right. It looks like some of the digits are actually spelled out with letters: one, two, three, four, five, six, seven, eight, and nine also count as valid "digits".

Equipped with this new information, you now need to find the real first and last digit on each line. For example:

    input = """
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
    """

In this example, the calibration values are 29, 83, 13, 24, 42, 14, and 76. Adding these together produces 281.

What is the sum of all of the calibration values?


## Defs

    { log, assert, getInput, sum } = require '../utils'

    parseInput = (text='')->
      text
      .split '\n'
      .filter (v)-> v
      .map (line)->
        # have to run 2 matches since JS RE isn't greedy :-/
        [_, first] = line.match ///(#{Object.keys(nums).join '|'}|\d).*///
        [_, last] = line.match ///.*(#{Object.keys(nums).join '|'}|\d)///

        # convert names to digits, if it's in the map. Otherwise use the digit
        first = nums[first] or first
        last = nums[last] or last

        # second digit might be a repeat of the first digit if there's only one
        parseFloat [first, last or first].join ''

    nums =
      one:    1
      two:    2
      three:  3
      four:   4
      five:   5
      six:    6
      seven:  7
      eight:  8
      nine:   9

    calibrate = (numbers=[])->
      sum numbers...


## Tests

    assert.equal 281, calibrate parseInput input


## Run

    log calibrate parseInput getInput()
