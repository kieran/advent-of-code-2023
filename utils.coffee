{ log } = console
assert  = require 'assert'
{ readFileSync } = require 'fs'

getInput = (file='./input')-> readFileSync file, encoding: 'utf8'

sum = -> [arguments...].reduce (memo, val)-> memo + val

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
}
