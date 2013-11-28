t      = require '../trickster'
assert = require 'assert'


describe 'trickster#partitionProbability', ->


  it 'should calculate the probabilty of a given partition', ->
    assert ( a = t.partitionProbability( 5, 3, 3, 2 ) ) > 0.15, "#{a} should be greater than 0.15"


  it 'should cache partitions we have previously calculated', ->
    t.partitionProbability( 5, 3, 3, 2 )
    assert t.validPartitions['5,3,3,2']


  it 'should throw an error when trying to access an invalid partition', ->
    assert.throws (-> t.partitionProbability 0), /partition/
