factorial = require './factorial'

###
Calculate binomial coefficients

@param n [Integer] The corresponding "row" in pascal's triangle
@param k [Integer] The corresponding "column" in pascal's triangle (dependent on the row number, since it's a triangle!)

@return [Decimal]
###
binomialCoefficient = (n, k) ->
  throw new Error "n must be greater than or equal to k!  n was #{n} and k was #{k}!" if n < k

  factorial(n) / ( factorial(k) * factorial(n - k) )


if typeof exports != 'undefined'
  module.exports = binomialCoefficient
else
  Math.binomialCoefficient = binomialCoefficient