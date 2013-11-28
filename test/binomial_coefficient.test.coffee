bc = require '../src/binomial_coefficient'
assert    = require 'assert'


describe 'binomial_coefficient', ->


  it 'should compute the binomial coefficient of the given coordinates', ->
    assert.equal bc(0, 0), 1
    assert.equal bc(1, 0), 1
    assert.equal bc(1, 1), 1
    assert.equal bc(2, 0), 1
    assert.equal bc(2, 1), 2
    assert.equal bc(3, 0), 1
    assert.equal bc(3, 1), 3
    assert.equal bc(5, 2), 10


  it 'should throw an error when k is greater than n', ->
    assert.throws (-> bc 0, 1), /must be greater than or equal to/
