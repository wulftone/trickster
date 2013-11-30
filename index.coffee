prob = require './src/prob.coffee'


###
Creates the table and inserts it into the given element (selected by element id)

@param elementName [String] The id of the Trickster container

@return [Trickster]
###
Trickster = (elementName) ->
  throw new Error 'You must include an element name as an argument to the Trickster constructor!' unless elementName

  container = document.getElementById elementName
  throw new Error "Could not find element with id = #{elementName}!" unless container

  container.innerHTML = ''
  probs = objToArr prob.calculateProbabilities()
  table = createProbabilitiesTable probs
  container.appendChild table
  @


###
Turn an object into an Array of Arrays

@param obj [Object]

@return [Array<Array>]
###
objToArr = (obj) ->
  arr = []

  for k, v of obj
    arr.push [k,v]

  arr


###
Add events to the headers that sort the table by the data in each header's column

@param table [DOMElement] The table we're making sortable

@return [DOMElement]
###
makeItSortable = (table) ->
  tr = table.children[0]
  console.log tr


###
Creates a two-column table based on the given object.

@param probabilities [Object, Array<Array>] e.g. {"5,3,3,2": 0.15, ...}, or [["5,3,3,2", 0.15], ...]

@return [DOMElement] The table element
###
createProbabilitiesTable = (probabilities) ->
  probabilities.sort (a, b) ->
    b[1] - a[1]

  p = probabilities.map (el) ->
    [el[0], numberToPercent el[1]]

  table = createTable ['Partition', 'Probability (%)'], p
  makeItSortable table
  table


numberToPercent = (n) ->
  x = (100 * n).toPrecision(4)

  if x < 0.1
    parseFloat(x).toExponential()
  else
    x


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

  rows.forEach (row) ->
    tr = createTableRow row[0], row[1]
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
