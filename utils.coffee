{ log } = console
assert  = require 'assert'
{ readFileSync } = require 'fs'

getInput = (file='./input')-> readFileSync file, encoding: 'utf8'

sum = -> [arguments...].reduce ((memo, val)-> memo + val), 0

multiply = -> [arguments...].reduce (memo, val)-> memo * val

uniq = -> [...new Set arguments...]

intersection = (arr1, arr2)-> (a for a in arr1 when a in arr2)

inputLines = (text='')->
  text
  .split '\n'
  .filter (v)-> v

module.exports = {
  log
  assert
  getInput
  inputLines
  sum
  uniq
  multiply
  intersection
}
