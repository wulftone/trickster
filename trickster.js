!function(e){"object"==typeof exports?module.exports=e():"function"==typeof define&&define.amd?define(e):"undefined"!=typeof window?window.Trickster=e():"undefined"!=typeof global?global.Trickster=e():"undefined"!=typeof self&&(self.Trickster=e())}(function(){var define,module,exports;return (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var Trickster, createTable, createTableRow, getProbs, numberToPercent, objToArr, prob;

prob = require('./src/prob.coffee');

Trickster = (function() {
  /*
  Creates the table and inserts it into the given element (selected by element id)
  
  @param elementName [String] The id of the Trickster container
  
  @return [Trickster]
  */

  function Trickster(elementName) {
    if (!elementName) {
      throw new Error('You must include an element name as an argument to the Trickster constructor!');
    }
    this.container = document.getElementById(elementName);
    if (!this.container) {
      throw new Error("Could not find element with id = " + elementName + "!");
    }
    this.probs = getProbs().sortByPartition();
    this.render();
    this;
  }

  Trickster.prototype.render = function() {
    this.container.innerHTML = '';
    this.table = this.createProbabilitiesTable(this.probs);
    return this.container.appendChild(this.table);
  };

  Trickster.prototype.reRender = function() {
    this.dispose();
    return this.render();
  };

  Trickster.prototype.dispose = function() {
    return this.container.removeChild(this.table);
  };

  /*
  Add events to the headers that sort the table by the data in each header's column
  
  @param table [DOMElement] The table we're making sortable
  
  @return [DOMElement]
  */


  Trickster.prototype.makeItSortable = function(table) {
    var tr,
      _this = this;
    tr = table.children[0];
    tr.children[0].onclick = function(e) {
      _this.probs.sortByPartition();
      return _this.reRender();
    };
    return tr.children[1].onclick = function(e) {
      _this.probs.sortByProbabilty();
      return _this.reRender();
    };
  };

  /*
  Creates a two-column table based on the given Array.
  
  @param probabilities [Array<Array>] e.g. [["5,3,3,2", 0.15], ...]
  
  @return [DOMElement] The table element
  */


  Trickster.prototype.createProbabilitiesTable = function(probabilities) {
    var p, table;
    p = probabilities.map(function(el) {
      return [el[0].toString().replace(/,/g, '-'), numberToPercent(el[1])];
    });
    p.sortedBy = 'probability decreasing';
    table = createTable(['Partition', 'Probability (%)'], p);
    this.makeItSortable(table);
    return table;
  };

  return Trickster;

})();

/*
Turn an object into an Array of Arrays

@param obj [Object]

@return [Array<Array>]
*/


objToArr = function(obj) {
  var arr, k, v;
  arr = [];
  for (k in obj) {
    v = obj[k];
    arr.push([k, v]);
  }
  return arr;
};

numberToPercent = function(n) {
  var x;
  x = (100 * n).toPrecision(4);
  if (x < 0.1) {
    return parseFloat(x).toExponential();
  } else {
    return x;
  }
};

/*
Creates a two-column table.

@param headers [Array<String>] An Array that contains two strings to be used as column titles in the table
@param rows [Object] A basic Object whose keys will be the first column, and values the second column in the table

@return [DOMElement] The table element
*/


createTable = function(headers, rows) {
  var headerRow, table;
  table = document.createElement('table');
  headerRow = createTableRow(headers[0], headers[1], 'th');
  table.appendChild(headerRow);
  rows.forEach(function(row) {
    var tr;
    tr = createTableRow(row[0], row[1]);
    return table.appendChild(tr);
  });
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

getProbs = function() {
  var arr, p;
  arr = objToArr(prob.calculateProbabilities());
  p = arr.map(function(e) {
    return [prob.padArr(eval("[" + e[0] + "]"), 4), e[1]];
  });
  p.sortByPartition = function() {
    var weightedReduction;
    weightedReduction = function(e) {
      return e[0] * 1000 + e[1] * 100 + e[2] * 10 + e[3];
    };
    if (this.sortedBy === 'partition decreasing') {
      this.sortedBy = 'partition increasing';
      return this.sort(function(a, b) {
        var x, y;
        x = a.reduce(weightedReduction);
        y = b.reduce(weightedReduction);
        return x - y;
      });
    } else {
      this.sortedBy = 'partition decreasing';
      return this.sort(function(a, b) {
        var x, y;
        x = a.reduce(weightedReduction);
        y = b.reduce(weightedReduction);
        return y - x;
      });
    }
  };
  p.sortByProbabilty = function() {
    if (this.sortedBy === 'probability decreasing') {
      this.sortedBy = 'probability increasing';
      return this.sort(function(a, b) {
        return a[1] - b[1];
      });
    } else {
      this.sortedBy = 'probability decreasing';
      return this.sort(function(a, b) {
        return b[1] - a[1];
      });
    }
  };
  return p;
};

module.exports = Trickster;


},{"./src/prob.coffee":5}],2:[function(require,module,exports){
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
var factorial, multinomialCoefficient,
  __hasProp = {}.hasOwnProperty;

factorial = require('./factorial.coffee');

/*
Calculate the multinomial coefficient of a given set of Integers

@param arr [Array<Integer>]

@return [Decimal]
*/


multinomialCoefficient = function(arr) {
  var counts, denominator, numerator;
  counts = multinomialCoefficient.count(arr);
  numerator = factorial(counts.reduce(function(a, b) {
    return a + b;
  }));
  denominator = counts.map(function(e) {
    return factorial(e);
  }).reduce(function(a, b) {
    return a * b;
  });
  return numerator / denominator;
};

/*
Count the number of occurrences of an element in an array.

NOTE: This function only returns an Array of counts, with
      no "key: value" to determine which count goes with
      which value.  This is by design, since here we don't
      care about that.

@param arr [Array<Integer>]

@return [Array]
*/


multinomialCoefficient.count = function(arr) {
  var counts, k, obj, v;
  obj = {};
  arr.forEach(function(e) {
    if (obj[e]) {
      return obj[e]++;
    } else {
      return obj[e] = 1;
    }
  });
  counts = [];
  for (k in obj) {
    if (!__hasProp.call(obj, k)) continue;
    v = obj[k];
    counts.push(v);
  }
  return counts;
};

module.exports = multinomialCoefficient;


},{"./factorial.coffee":3}],5:[function(require,module,exports){
/*
This module does the bridge-specific math trickster requires
*/

var Prob, bc, calculateProbabilities, mc, padArr, partitionProbability, validPartitions, verifyHandSize;

bc = require('./binomial_coefficient.coffee');

mc = require('./multinomial_coefficient.coffee');

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
  var binomialCoefficients, deckSize, denominator, handArr, handSize, multinomial, paddedHandArr;
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
  paddedHandArr = padArr(handArr, 4);
  binomialCoefficients = paddedHandArr.map(function(e) {
    return bc(handSize, e);
  }).reduce(function(a, b) {
    return a * b;
  });
  multinomial = mc(handArr);
  return validPartitions[hand] = multinomial * binomialCoefficients / denominator;
};

/*
Pad an array with zeros out to index `size - 1`

@param arr  [Array]
@param size [Integer] The desired final size of the array

@return [Array]
*/


padArr = function(arr, size) {
  var numPads;
  numPads = size - arr.length;
  while (numPads--) {
    arr.push(0);
  }
  return arr;
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
  validPartitions: validPartitions,
  padArr: padArr
};

module.exports = Prob;


},{"./binomial_coefficient.coffee":2,"./multinomial_coefficient.coffee":4}]},{},[1])
(1)
});
;