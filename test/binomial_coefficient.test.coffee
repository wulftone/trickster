bc = require '../src/binomial_coefficient'
assert    = require 'assert'


describe 'binomial_coefficient', ->


  it 'should compute the binomial coefficient of the given coordinates', ->
    assert.equal bc(0, 0),  1
    assert.equal bc(1, 0),  1
    assert.equal bc(1, 1),  1
    assert.equal bc(2, 0),  1
    assert.equal bc(2, 1),  2
    assert.equal bc(3, 0),  1
    assert.equal bc(3, 1),  3
    assert.equal bc(5, 2),  10
    assert.equal bc(16, 8), 12870
    assert.equal bc(52, 13), 635013559600


  it 'should satisfy the identity theorem for binomial coefficients (n k) == (n (n - k))', ->
    identity = (n, k) ->
      assert.equal bc(n, k), bc(n, (n - k))

    i = 52
    while i--
      j = i

      while j--
        identity i, j


  it 'should throw an error when k is greater than n', ->
    assert.throws (-> bc 0, 1), /must be greater than or equal to/
