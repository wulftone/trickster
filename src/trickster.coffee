prob = require './prob.coffee'

###
Creates the table and inserts it into the given element (selected by element id)

@param elementName [String] The id of the Trickster container

@return [Trickster]
###
Trickster = (elementName) ->
  container = document.getElementById elementName
  probabilities = prob.calculateProbabilities()

  table = document.createElement 'table'
  tr = @createTableRow 'Partition', 'Probability (%)', 'th'
  table.appendChild tr

  for partition, prob of probabilities
    percent = Math.floor(10000 * prob) / 100 # Floored to two decmials
    tr = @createTableRow partition, percent
    table.appendChild tr

  container.appendChild table
  @


###
Creates a two-column `tr` element with the given contents.

@param column1Text [String] The text to enter into the leftmost column
@param column2Text [String] The text to enter into the rightmost column
@param columnType  [String] (default: 'td') The type of column (e.g. `th` or `td`)
###
Trickster.prototype.createTableRow = (column1Text, column2Text, columnType = 'td') ->
  tr = document.createElement 'tr'
  td1 = document.createElement columnType
  td2 = document.createElement columnType
  td1.textContent = column1Text
  td2.textContent = column2Text
  tr.appendChild td1
  tr.appendChild td2
  tr

module.exports = Trickster
