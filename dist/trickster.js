!function(e){"object"==typeof exports?module.exports=e():"function"==typeof define&&define.amd?define(e):"undefined"!=typeof window?window.Trickster=e():"undefined"!=typeof global?global.Trickster=e():"undefined"!=typeof self&&(self.Trickster=e())}(function(){var define,module,exports;return (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var Trickster, createProbabilitiesTable, createTable, createTableRow, makeItSortable, prob;

prob = require('./src/prob.coffee');

/*
Creates the table and inserts it into the given element (selected by element id)

@param elementName [String] The id of the Trickster container

@return [Trickster]
*/


Trickster = function(elementName) {
  var container, table;
  if (!elementName) {
    throw new Error('You must include an element name as an argument to the Trickster constructor!');
  }
  container = document.getElementById(elementName);
  if (!container) {
    throw new Error("Could not find element with id = " + elementName + "!");
  }
  container.innerHTML = '';
  table = createProbabilitiesTable(prob.calculateProbabilities());
  container.appendChild(table);
  return this;
};

makeItSortable = function(table) {
  var tr;
  tr = table.children[0];
  return console.log(tr);
};

/*
Creates a two-column table based on the given object.

@param probabilities [Object, Array<Array>] e.g. {"5,3,3,2": 0.15, ...}, or [["5,3,3,2", 0.15], ...]

@return [DOMElement] The table element
*/


createProbabilitiesTable = function(probabilities) {
  var p, partition, probability, table;
  p = {};
  for (partition in probabilities) {
    probability = probabilities[partition];
    p[partition] = Math.floor(10000 * probability) / 100;
  }
  table = createTable(['Partition', 'Probability (%)'], p);
  makeItSortable(table);
  return table;
};

/*
Creates a two-column table.

@param headers [Array<String>] An Array that contains two strings to be used as column titles in the table
@param rows [Object] A basic Object whose keys will be the first column, and values the second column in the table

@return [DOMElement] The table element
*/


createTable = function(headers, rows) {
  var headerRow, k, table, tr, v;
  table = document.createElement('table');
  headerRow = createTableRow(headers[0], headers[1], 'th');
  table.appendChild(headerRow);
  for (k in rows) {
    v = rows[k];
    tr = createTableRow(k, v);
    table.appendChild(tr);
  }
  return table;
};

/*
Creates a two-column `tr` element with the given contents.

@param column1Text [String] The text to enter into the leftmost column
@param column2Text [String] The text to enter into the rightmost column
@param columnType  [String] (default: 'td') The type of column (e.g. `th` or `td`)
*/


createTableRow = function(column1Text, column2Text, columnType) {
  var td1, td2, tr;
  if (columnType == null) {
    columnType = 'td';
  }
  tr = document.createElement('tr');
  td1 = document.createElement(columnType);
  td2 = document.createElement(columnType);
  td1.textContent = column1Text;
  td2.textContent = column2Text;
  tr.appendChild(td1);
  tr.appendChild(td2);
  return tr;
};

module.exports = Trickster;


},{"./src/prob.coffee":4}],2:[function(require,module,exports){
var binomialCoefficient, factorial;

factorial = require('./factorial.coffee');

/*
Calculate binomial coefficients.  Also known as "n choose k".
Uses Math.floor to offset javascript math errors.

@param n [Integer] The corresponding "row" in pascal's triangle
@param k [Integer] The corresponding "column" in pascal's triangle (dependent on the row number, since it's a triangle!)

@return [Decimal]
*/


binomialCoefficient = function(n, k) {
  if (n < k) {
    throw new Error("n must be greater than or equal to k!  n was " + n + " and k was " + k + "!");
  }
  return Math.floor(factorial(n) / (factorial(k) * factorial(n - k)));
};

module.exports = binomialCoefficient;


},{"./factorial.coffee":3}],3:[function(require,module,exports){
/*
Recursive factorial function with cache

@param n [Integer] an Integer
@return [Integer]
*/

var factorial, memo;

factorial = function(n) {
  var result;
  if (n < 0) {
    throw new Error('Cannot take factorial of a negative number!');
  }
  if (memo[n] > 0) {
    result = memo[n];
  } else {
    result = memo[n] = n * factorial(n - 1);
  }
  if (result === Infinity) {
    throw new Error('Factorial is too large, javascript cannot handle it!');
  }
  return result;
};

memo = [1, 1];

factorial.memo = memo;

module.exports = factorial;


},{}],4:[function(require,module,exports){
/*
This module does the bridge-specific math trickster requires
*/

var Prob, bc, calculateProbabilities, partitionProbability, validPartitions, verifyHandSize;

bc = require('./binomial_coefficient.coffee');

/*
These are the partitions we care about for now, there should be 39 of them
*/


validPartitions = {
  "13": void 0,
  "12,1": void 0,
  "11,2": void 0,
  "11,1,1": void 0,
  "10,3": void 0,
  "10,2,1": void 0,
  "10,1,1,1": void 0,
  "9,4": void 0,
  "9,3,1": void 0,
  "9,2,2": void 0,
  "9,2,1,1": void 0,
  "8,5": void 0,
  "8,4,1": void 0,
  "8,3,2": void 0,
  "8,3,1,1": void 0,
  "8,2,2,1": void 0,
  "7,6": void 0,
  "7,5,1": void 0,
  "7,4,2": void 0,
  "7,4,1,1": void 0,
  "7,3,3": void 0,
  "7,3,2,1": void 0,
  "7,2,2,2": void 0,
  "6,6,1": void 0,
  "6,5,2": void 0,
  "6,5,1,1": void 0,
  "6,4,3": void 0,
  "6,4,2,1": void 0,
  "6,3,3,1": void 0,
  "6,3,2,2": void 0,
  "5,5,3": void 0,
  "5,5,2,1": void 0,
  "5,4,4": void 0,
  "5,4,3,1": void 0,
  "5,4,2,2": void 0,
  "5,3,3,2": void 0,
  "4,4,4,1": void 0,
  "4,4,3,2": void 0,
  "4,3,3,3": void 0
};

/*
Just verifies that the hand size is 13.  Throws an error if it is not.

@param handArr [Array] The hand, (e.g. [5, 3, 3, 2])
*/


verifyHandSize = function(handArr) {
  var handSize;
  handSize = handArr.reduce(function(a, b) {
    return a + b;
  });
  if (handSize !== 13) {
    throw new Error('Hand size must be 13 cards!');
  }
};

/*
Calculate the partition probability

@param hand [String] e.g. "5,3,3,2"

@return [Decimal]
*/


partitionProbability = function(hand) {
  var deckSize, denominator, handArr, handSize, numerator;
  if (!validPartitions.hasOwnProperty(hand)) {
    throw new Error('Not a valid partition!');
  }
  if (validPartitions[hand]) {
    return validPartitions[hand];
  }
  handSize = 13;
  deckSize = 52;
  denominator = bc(deckSize, handSize);
  handArr = eval("[" + hand + "]");
  verifyHandSize(handArr);
  numerator = handArr.map(function(e) {
    return bc(handSize, e);
  }).reduce(function(a, b) {
    return a * b;
  });
  return validPartitions[hand] = numerator / denominator;
};

/*
Calculate all the probabilities for the valid partitions
*/


calculateProbabilities = function() {
  var partition, value;
  for (partition in validPartitions) {
    value = validPartitions[partition];
    partitionProbability(partition);
  }
  return validPartitions;
};

Prob = {
  partitionProbability: partitionProbability,
  calculateProbabilities: calculateProbabilities,
  validPartitions: validPartitions
};

module.exports = Prob;


},{"./binomial_coefficient.coffee":2}]},{},[1])
(1)
});
;