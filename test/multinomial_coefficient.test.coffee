mc     = require '../src/multinomial_coefficient'
assert = require 'assert'


describe 'multinomial_coefficient', ->


  it 'should count the elements in an array', ->
    counts = mc.count [1, 1, 1, 2, 2, 3]

    assert.equal counts[0], 3
    assert.equal counts[1], 2
    assert.equal counts[2], 1


  it 'should compute the multinomial coefficient of the given array', ->
    assert.equal mc([13,0,0,0]),  4
    assert.equal mc([5,3,3,2]),  12
