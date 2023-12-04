# Part Two

The engineer finds the missing part and installs it in the engine! As the engine springs to life, you jump in the closest gondola, finally ready to ascend to the water source.

You don't seem to be going very fast, though. Maybe something is still wrong? Fortunately, the gondola has a phone labeled "help", so you pick it up and the engineer answers.

Before you can explain the situation, she suggests that you look out the window. There stands the engineer, holding a phone in one hand and waving with the other. You're going so slowly that you haven't even left the station. You exit the gondola.

The missing part wasn't the only issue - one of the gears in the engine is wrong. A gear is any * symbol that is adjacent to exactly two part numbers. Its gear ratio is the result of multiplying those two numbers together.

This time, you need to find the gear ratio of every gear and add them all up so that the engineer can figure out which gear needs to be replaced.

Consider the same engine schematic again:

    input = """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
    """

In this schematic, there are two gears. The first is in the top left; it has part numbers 467 and 35, so its gear ratio is 16345. The second gear is in the lower right; its gear ratio is 451490. (The * adjacent to 617 is not a gear because it is only adjacent to one part number.) Adding up all of the gear ratios produces 467835.

What is the sum of all of the gear ratios in your engine schematic?


## Defs

    { log, getInput, readFileSync } = require '../utils'
    { sum, uniq, multiply } = require '../utils'

    map = (text='')->
      text
      .split '\n'
      .map (line)->
        line.split ''

    ratios = (map=[[]])->
      ret = []
      for numbers in parts(map) when numbers.length is 2
        ret.push multiply numbers...
      ret

    parts = (map=[[]])->
      ret = []
      for row, y in map
        for val, x in row
          if val is '*'
            if part = findNumbers map, y, x
              ret.push part
      ret

    findNumbers = (map=[[]], y=0, x=0)->
      ret = []
      # only check the corners
      for dy in [-1, 0, 1]
        # check the middle
        if (val = map[y+dy]?[x]) and val?.match /\d/
          if num = numberAt map, y+dy, x
            ret.push num if Number.isInteger num
        else
          # if no result, check the corners
          for dx in [-1, 1]
            continue unless map[y+dy]?[x+dx]?
            if num = numberAt map, y+dy, x+dx
              ret.push num if Number.isInteger num
      ret

    numberAt = (map=[[]], y=0, x=0)->
      cur = map[y][x]
      return false unless cur?.match /\d/
      ret = [cur]

      # fill in digits to the left
      offset = 0
      loop
        offset -= 1
        cur = map[y][x + offset]
        break unless cur?.match /\d/
        ret.unshift cur

      # fill in digits to the right
      offset = 0
      loop
        offset += 1
        cur = map[y][x + offset]
        break unless cur?.match /\d/
        ret.push cur

      parseFloat ret.join ''


## Tests

    { describe, it, before } = require 'node:test'
    assert  = require "node:assert"
    { isEqual } = require "underscore"

    describe "parsing", ->

      it "finds diagonals" , ->
        assert.equal 4, sum ...ratios map \
        """
        2.2
        +*.
        ...
        """

        assert.equal 4, sum ...ratios map \
        """
        2..
        +*.
        ..2
        """

      it "finds sides" , ->
        assert.equal 4, sum ...ratios map \
        """
        ...
        2*2
        +..
        """

      it "finds top and bottom" , ->
        assert.equal 4, sum ...ratios map \
        """
        .2.
        .*.
        +2.
        """

      it "ignores more than 2 gears", ->
        assert isEqual [[1,2,3]], parts map \
        """
        .1.
        .*2
        3..
        """
        #  ex
        assert.equal 0, sum ...ratios map \
        """
        .1.
        .*2
        3..
        """

    assert.equal 467835, sum ...ratios map input


## Run

    log sum ...ratios map getInput()
