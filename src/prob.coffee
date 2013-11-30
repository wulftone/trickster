###
This module does the bridge-specific math trickster requires
###

bc = require './binomial_coefficient.coffee'
mc = require './multinomial_coefficient.coffee'

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
Just verifies that the hand size is 13.  Throws an error if it is not.

@param handArr [Array] The hand, (e.g. [5, 3, 3, 2])
###
verifyHandSize = (handArr) ->
  handSize = handArr.reduce (a, b) ->
    a + b

  throw new Error 'Hand size must be 13 cards!' unless handSize == 13


###
Calculate the partition probability

@param hand [String] e.g. "5,3,3,2"

@return [Decimal]
###
partitionProbability = (hand) ->
  throw new Error 'Not a valid partition!' unless validPartitions.hasOwnProperty hand

  # Don't re-calculate unless we have to
  return validPartitions[hand] if validPartitions[hand]

  handSize = 13
  deckSize = 52

  denominator = bc deckSize, handSize

  handArr = eval "[#{hand}]"
  verifyHandSize handArr

  binomialCoefficients = handArr.map (e) ->
    bc handSize, e

  .reduce (a, b) ->
    a * b

  multinomial = mc handArr
  validPartitions[hand] = multinomial * binomialCoefficients / denominator


###
Calculate all the probabilities for the valid partitions
###
calculateProbabilities = () ->
  for partition, value of validPartitions
    partitionProbability partition

  validPartitions


# Choose which functions we want to be public
Prob =
  partitionProbability: partitionProbability
  calculateProbabilities: calculateProbabilities
  validPartitions: validPartitions


module.exports = Prob
