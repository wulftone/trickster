prob   = require '../src/prob'
assert = require 'assert'


describe 'prob#partitionProbability', ->


  xit 'should calculate the probabilty of a given partition', ->
    assert ( a = prob.partitionProbability( 5, 3, 3, 2 ) ) > 0.15, "#{a} should be greater than 0.15"


  it 'should cache partitions we have previously calculated', ->
    prob.partitionProbability( 5, 3, 3, 2 )
    assert prob.validPartitions['5,3,3,2']


  it 'should throw an error when trying to access an invalid partition', ->
    assert.throws (-> prob.partitionProbability 0), /partition/


describe 'prob#probs', ->


  it 'should calculate all of the partitions', ->
    prob.probs()
