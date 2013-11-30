prob   = require '../src/prob'
assert = require 'assert'


describe 'prob#partitionProbability', ->


  it 'should calculate the probabilty of a given partition', ->
    assert ( a = prob.partitionProbability([5, 3, 3, 2]) ) > 0.15,   "#{a} should be greater than 0.15"
    assert ( a = prob.partitionProbability([13]) )         < 0.0001, "#{a} should be less than 0.0001"


  it 'should cache partitions we have previously calculated', ->
    prob.partitionProbability [5, 3, 3, 2]

    assert prob.validPartitions['5,3,3,2']


  it 'should throw an error when trying to access an invalid partition', ->
    assert.throws (-> prob.partitionProbability 0), /partition/


describe 'prob#calculateProbabilities', ->


  it 'should calculate all of the partitions', ->
    assert.equal Object.keys(prob.calculateProbabilities()).length, 39


describe 'prob#padArr', ->


  it 'should pad an array with zeroes', ->
    arr = prob.padArr([1], 3)

    assert.equal arr.length, 3
    assert.equal arr[0], 1
    assert.equal arr[1], 0
