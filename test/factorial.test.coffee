factorial = require '../factorial'
assert    = require 'assert'

describe 'factorial', ->


  it 'should compute the factorial of large numbers', ->
    assert.equal factorial(100), 9.33262154439441e+157


  it 'should throw an error if the result is too large', ->
    assert.throws (-> factorial 171), /too large/


  it 'should throw an error if the input is negative', ->
    assert.throws (-> factorial -1), /negative/


  it 'should memoize the results', ->
    factorialResults = [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800]
    factorial 10
    i = 11
    while i--
      assert.equal factorial.memo[i], factorialResults[i]
