###
This module does the math trickster needs to operate
###

bc = require './binomial_coefficient'

###
These are the partitions we care about for now, there should be 39 of them
###
validPartitions =
  "13"      : undefined
  "12,1"    : undefined
  "11,2"    : undefined
  "11,1,1"  : undefined
  "10,3"    : undefined
  "10,2,1"  : undefined
  "10,1,1,1": undefined
  "9,4"     : undefined
  "9,3,1"   : undefined
  "9,2,2"   : undefined
  "9,2,1,1" : undefined
  "8,5"     : undefined
  "8,4,1"   : undefined
  "8,3,2"   : undefined
  "8,3,1,1" : undefined
  "8,2,2,1" : undefined
  "7,6"     : undefined
  "7,5,1"   : undefined
  "7,4,2"   : undefined
  "7,4,1,1" : undefined
  "7,3,3"   : undefined
  "7,3,2,1" : undefined
  "7,2,2,2" : undefined
  "6,6,1"   : undefined
  "6,5,2"   : undefined
  "6,5,1,1" : undefined
  "6,4,3"   : undefined
  "6,4,2,1" : undefined
  "6,3,3,1" : undefined
  "6,3,2,2" : undefined
  "5,5,3"   : undefined
  "5,5,2,1" : undefined
  "5,4,4"   : undefined
  "5,4,3,1" : undefined
  "5,4,2,2" : undefined
  "5,3,3,2" : undefined
  "4,4,4,1" : undefined
  "4,4,3,2" : undefined
  "4,3,3,3" : undefined


###
Calculate the partition probability

@param arguments [Integer]
@return [Decimal]
###
partitionProbability = () ->
  args = Array.prototype.slice.call arguments
  key = args.toString()

  throw new Error 'Not a valid partition!' unless validPartitions.hasOwnProperty key

  # Don't re-calculate unless we have to
  return validPartitions[key] if validPartitions[key]

  denominator = bc 52, 13

  numerator = args.map (e) ->
    bc 13, e

  .reduce (a, b) ->
    a * b

  validPartitions[key] = numerator / denominator


probs = () ->
  partitions.map (p) ->
    100 * partitionProbability p


# Choose which functions we want to be public
Prob =
  partitionProbability: partitionProbability
  probs: probs
  validPartitions: validPartitions


if typeof exports != 'undefined'
  module.exports = Prob
else
  @Trickster ||= {}
  @Trickster.Prob = Prob
