factorial = require './factorial.coffee'


###
Calculate the multinomial coefficient of a given set of Integers

@param arr [Array<Integer>]

@return [Decimal]
###
multinomialCoefficient = (arr) ->
  counts = multinomialCoefficient.count arr

  numerator = factorial counts.reduce (a, b) ->
    a + b

  denominator = counts.map (e) ->
    factorial e

  .reduce (a, b) ->
    a * b

  numerator / denominator


###
Count the number of occurrences of an element in an array.

NOTE: This function only returns an Array of counts, with
      no "key: value" to determine which count goes with
      which value.  This is by design, since here we don't
      care about that.

@param arr [Array<Integer>]

@return [Array]
###
multinomialCoefficient.count = (arr) ->
  obj = {}

  arr.forEach (e) ->
    if obj[e]
      obj[e]++

    else
      obj[e] = 1

  counts = []
  for own k, v of obj
    counts.push v

  counts


module.exports = multinomialCoefficient
