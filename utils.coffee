{ log } = console
assert  = require 'assert'
{ readFileSync } = require 'fs'

getInput = (file='./input')-> readFileSync file, encoding: 'utf8'

sum = -> [arguments...].reduce (memo, val)-> memo + val

module.exports = {
  log
  assert
  getInput
  sum
}
