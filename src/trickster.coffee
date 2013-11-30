prob = require './prob.coffee'


class Trickster


  ###
  Creates the table and inserts it into the given element (selected by element id)

  @param elementName [String] The id of the Trickster container

  @return [Trickster]
  ###
  constructor: (elementName) ->
    throw new Error 'You must include an element name as an argument to the Trickster constructor!' unless elementName

    @container = document.getElementById elementName
    throw new Error "Could not find element with id = #{elementName}!" unless @container

    @probs = generateProbabilities().sortByPartition()

    @render()
    @


  render: ->
    @container.innerHTML = ''
    @table = @createProbabilitiesTable @probs
    @container.appendChild @table


  reRender: ->
    @dispose()
    @render()


  dispose: ->
    @container.removeChild @table


  ###
  Add events to the headers that sort the table by the data in each header's column

  @param table [DOMElement] The table we're making sortable

  @return [DOMElement]
  ###
  makeItSortable: (table) ->
    tr = table.children[0]

    tr.children[0].onclick = (e) =>
      @probs.sortByPartition()
      @reRender()

    tr.children[1].onclick = (e) =>
      @probs.sortByProbabilty()
      @reRender()


  ###
  Creates a two-column table based on the given Array.

  @param probabilities [Array<Array>] e.g. [["5,3,3,2", 0.15], ...]

  @return [DOMElement] The table element
  ###
  createProbabilitiesTable: (probabilities) ->
    p = probabilities.map (el) ->
      [el[0].toString().replace(/,/g,'-'), numberToPercent el[1]]

    p.sortedBy = 'probability decreasing'

    table = createTable ['Partition', 'Probability (%)'], p
    @makeItSortable table
    table


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


###
Creates an Array with embedded Arrays of Arrays of Integers and a Float.  Yeah.
This is because Arrays are sortable, as we will need to do later.  It was easier than
creating my own custom Sortable class because Arrays come with lots of neat
functions like sort, map, and reduce already.

@return [Array <Array <Array <Integer>>, <Float>>] e.g. [ [ [5,3,3,2], 0.15], ... ]
###
generateProbabilities = ->
  arr = objToArr prob.calculateProbabilities()

  p = arr.map (e) ->
    [prob.padArr(eval("[#{e[0]}]"), 4), e[1]]

  p.sortByPartition = ->
    weightedReduction = (e) ->
      e[0] * 1000 +
      e[1] * 100 +
      e[2] * 10 +
      e[3]

    if @sortedBy == 'partition decreasing'
      @sortedBy = 'partition increasing'

      @sort (a, b) ->
        x = a.reduce weightedReduction
        y = b.reduce weightedReduction
        x - y

    else
      @sortedBy = 'partition decreasing'

      @sort (a, b) ->
        x = a.reduce weightedReduction
        y = b.reduce weightedReduction
        y - x


  p.sortByProbabilty = ->
    if @sortedBy == 'probability decreasing'
      @sortedBy = 'probability increasing'

      @sort (a, b) ->
        a[1] - b[1]

    else
      @sortedBy = 'probability decreasing'

      @sort (a, b) ->
        b[1] - a[1]

  p



module.exports = Trickster
