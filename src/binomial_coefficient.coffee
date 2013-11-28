factorial = require './factorial.coffee'

###
Calculate binomial coefficients.  Also known as "n choose k".
Uses Math.floor to offset javascript math errors.

@param n [Integer] The corresponding "row" in pascal's triangle
@param k [Integer] The corresponding "column" in pascal's triangle (dependent on the row number, since it's a triangle!)

@return [Decimal]
###
binomialCoefficient = (n, k) ->
  throw new Error "n must be greater than or equal to k!  n was #{n} and k was #{k}!" if n < k

  Math.floor( factorial(n) / ( factorial(k) * factorial(n - k) ) )


module.exports = binomialCoefficient
