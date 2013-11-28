prob = require './prob.coffee'

###
Creates the table and inserts it into the given element (selected by element id)

@param elementName [String] The id of the Trickster container

@return [Trickster]
###
Trickster = (elementName) ->
  container = document.getElementById elementName
  table = createProbabilitiesTable prob.calculateProbabilities()
  container.appendChild table
  @


###
Creates a two-column table based on the given object.

@param probabilities [Object] e.g. {"5,3,3,2": 0.15, ...}

@return [DOMElement] The table element
###
createProbabilitiesTable = (probabilities) ->
  p = {}

  for partition, probability of probabilities
    p[partition] = Math.floor(10000 * probability) / 100 # Floored to two decmials

  table = createTable ['Partition', 'Probability (%)'], p



###
Creates a two-column table.

@param headers [Array<String>] An Array that contains two strings to be used as column titles in the table
@param rows [Object] A basic Object whose keys will be the first column, and values the second column in the table

@return [DOMElement] The table element
###
createTable = (headers, rows) ->
  table = document.createElement 'table'
  headerRow = createTableRow headers[0], headers[1], 'th'
  table.appendChild headerRow

  for k, v of rows
    tr = createTableRow k, v
    table.appendChild tr

  table


###
Creates a two-column `tr` element with the given contents.

@param column1Text [String] The text to enter into the leftmost column
@param column2Text [String] The text to enter into the rightmost column
@param columnType  [String] (default: 'td') The type of column (e.g. `th` or `td`)
###
createTableRow = (column1Text, column2Text, columnType = 'td') ->
  tr = document.createElement 'tr'
  td1 = document.createElement columnType
  td2 = document.createElement columnType
  td1.textContent = column1Text
  td2.textContent = column2Text
  tr.appendChild td1
  tr.appendChild td2
  tr


module.exports = Trickster
