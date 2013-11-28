###
Recursive factorial function with cache

@param n [Integer] an Integer
@return [Integer]
###
factorial = (n) ->
  throw new Error 'Cannot take factorial of a negative number!' if n < 0

  if memo[n] > 0
    result = memo[n]
  else
    result = memo[n] = n * factorial(n - 1)

  throw new Error 'Factorial is too large, javascript cannot handle it!' if result == Infinity

  result


# The `memo` variable acts like a lookup cache.  We'll save our factorial results in it.
# Input the first two values so we don't have to clutter up the function with them.
memo = [1, 1]

# Expose the memo so we can see our saved values
factorial.memo = memo

module.exports = factorial
