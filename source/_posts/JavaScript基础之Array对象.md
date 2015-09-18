title: JavaScript基础之Array对象
date: 2015-09-18 14:33:26
categories: ["翻译"]
tags: ["Array", "JavaScript"]
---
> 
原文链接：https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array

## Summary
> 
The JavaScript Array object is a global object that is used in the construction of arrays; which are high-level, list-like objects.

**Create an Array**

```javascript
var fruits = ["Apple", "Banana"];

console.log(fruits.length);
// 2
```

**Access (index into) an Array item**

```javascript
var first = fruits[0];
// Apple

var last = fruits[fruits.length - 1];
// Banana
```
<!--more-->
**Loop over an Array**

```javascript
fruits.forEach(function (item, index, array) {
  console.log(item, index);
});
// Apple 0
// Banana 1
```

**Add to the end of an Array**

```javascript
var newLength = fruits.push("Orange");
// ["Apple", "Banana", "Orange"]
```

**Remove from the end of an Array**

```javascript
var last = fruits.pop(); // remove Orange (from the end)
// ["Apple", "Banana"];
```

**Remove from the front of an Array**

```javascript
var first = fruits.shift(); // remove Apple from the front
// ["Banana"];
```

**Add to the front of an Array**

```javascript
var newLength = fruits.unshift("Strawberry") // add to the front
// ["Strawberry", "Banana"];
```

**Find the index of an item in the Array**

```javascript
fruits.push("Mango");
// ["Strawberry", "Banana", "Mango"]

var pos = fruits.indexOf("Banana");
// 1
```

**Remove an item by Index Position**

```javascript
var removedItem = fruits.splice(pos, 1); // this is how to remove an item
// ["Strawberry", "Mango"]
```

**Copy an Array**

```javascript
var shallowCopy = fruits.slice(); // this is how to make a copy
// ["Strawberry", "Mango"]
```

## Syntax
> 
```javascript
[element0, element1, ..., elementN]
new Array(element0, element1[, ...[, elementN]])
new Array(arrayLength)
```

**elementN**

&emsp;&emsp;A JavaScript array is initialized with the given elements, except in the case where a single argument is passed to the Array constructor and that argument is a number. (See below.) Note that this special case only applies to JavaScript arrays created with the Array constructor, not array literals created with the bracket syntax.

**arrayLength**

&emsp;&emsp;If the only argument passed to the Array constructor is an integer between 0 and 232-1 (inclusive), this returns a new JavaScript array with length set to that number. If the argument is any other number, a [RangeError](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RangeError) exception is thrown.

## Description

Arrays are list-like objects whose prototype has methods to perform traversal and mutation operations. Neither the length of a JavaScript array nor the types of its elements are fixed. Since an array's size length grow or shrink at any time, JavaScript arrays are not guaranteed to be dense. In general, these are convenient characteristics; but if these features are not desirable for your particular use, you might consider using typed arrays.

Some people think that [you shouldn't use an array as an associative array](http://www.andrewdupont.net/2006/05/18/javascript-associative-arrays-considered-harmful/). In any case, you can use plain [objects](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object) instead, although doing so comes with its own caveats. See the post [Lightweight JavaScript dictionaries with arbitrary keys](http://www.less-broken.com/blog/2010/12/lightweight-javascript-dictionaries.html) as an example.

**Accessing array elements**

JavaScript arrays are zero-indexed: the first element of an array is at index 0, and the last element is at the index equal to the value of the array's length property minus 1.

```javascript
var arr = ['this is the first element', 'this is the second element'];
console.log(arr[0]);              // logs 'this is the first element'
console.log(arr[1]);              // logs 'this is the second element'
console.log(arr[arr.length - 1]); // logs 'this is the second element'
```
Array elements are object properties in the same way that toString is a property, but trying to access an element of an array as follows throws a syntax error, because the property name is not valid:

```javascript
console.log(arr.0); // a syntax error
```
There is nothing special about JavaScript arrays and the properties that cause this. JavaScript properties that begin with a digit cannot be referenced with dot notation; and must be accessed using bracket notation. For example, if you had an object with a property named '3d', it can only be referenced using bracket notation. E.g.:

```javascript
var years = [1950, 1960, 1970, 1980, 1990, 2000, 2010];
console.log(years.0);   // a syntax error
console.log(years[0]);  // works properly
renderer.3d.setTexture(model, 'character.png');     // a syntax error
renderer['3d'].setTexture(model, 'character.png');  // works properly
```
Note that in the 3d example, '3d' had to be quoted. It's possible to quote the JavaScript array indexes as well (e.g., years['2'] instead of years[2]), although it's not necessary. The 2 in years[2] is coerced into a string by the JavaScript engine through an implicit toString conversion. It is for this reason that '2' and '02' would refer to two different slots on the years object and the following example could be true:

```javascript
console.log(years['2'] != years['02']);
```
Similarly, object properties which happen to be reserved words(!) can only be accessed as string literals in bracket notation(but it can be accessed by dot notation in firefox 40.0a2 at least):

```javascript
var promise = {
  'var'  : 'text',
  'array': [1, 2, 3, 4]
};
console.log(promise['array']);
```

**Relationship between length and numerical properties**

A JavaScript array's [length][length] property and numerical properties are connected. Several of the built-in array methods (e.g., [join][join], [slice][slice], [indexOf][indexOf], etc.) take into account the value of an array's [length][length] property when they're called. Other methods (e.g., [push][push], [splice][splice], etc.) also result in updates to an array's length property.  

```javascript
var fruits = [];
fruits.push('banana', 'apple', 'peach');

console.log(fruits.length); // 3
```
When setting a property on a JavaScript array when the property is a valid array index and that index is outside the current bounds of the array, the engine will update the array's [length][length] property accordingly:

```javascript
fruits[5] = 'mango';
console.log(fruits[5]); // 'mango'
console.log(Object.keys(fruits));  // ['0', '1', '2', '5']
console.log(fruits.length); // 6
```
Increasing the [length][length].

```javascript
fruits.length = 10;
console.log(Object.keys(fruits)); // ['0', '1', '2', '5']
console.log(fruits.length); // 10
```
Decreasing the [length][length] property does, however, delete elements.

```javascript
fruits.length = 2;
console.log(Object.keys(fruits)); // ['0', '1']
console.log(fruits.length); // 2
```
This is explained further on the [Array.length][length] page.

**Creating an array using the result of a match**

The result of a match between a regular expression and a string can create a JavaScript array. This array has properties and elements which provide information about the match. Such an array is returned by [RegExp.exec][exec], [String.match][match], and String.replace. To help explain these properties and elements, look at the following example and then refer to the table below:

```javascript
// Match one d followed by one or more b's followed by one d
// Remember matched b's and the following d
// Ignore case

var myRe = /d(b+)(d)/i;
var myArray = myRe.exec('cdbBdbsbz');
```
The properties and elements returned from this match are as follows:

| Property/Element | Description | Example |
|------------------|-------------|---------|
| input | A read-only property that reflects the original string against which the <br/>regular expression was matched. | cdbBdbsbz |
| index | A read-only property that is the zero-based index of the match in the string. | 1 |
| \[0] | A read-only element that specifies the last matched characters. | dbBd |
| \[1], ...\[n] | Read-only elements that specify the parenthesized substring matches, <br/>if included in the regular expression. The number of possible parenthesized substrings is unlimited. | \[1]: bB<br/>\[2]: d |

## Properties

*For properties available on Array instances, see* [Properties of Array instances](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/prototype#Properties).

**Array.length**

&emsp;&emsp;The Array constructor's length property whose value is 1.

**Array.prototype**

&emsp;&emsp;Allows the addition of properties to all array objects.

## Methods

*For methods available on Array instances, see* [Methods of Array instances](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/prototype#Methods).

**Array.from()**

&emsp;&emsp;Creates a new Array instance from an array-like or iterable object.

**Array.isArray()**

&emsp;&emsp;Returns true if a variable is an array, if not false.

**Array.observe()**

&emsp;&emsp;Asynchronously observes changes to Arrays, similar to Object.observe() for objects. It provides a stream of changes in order of occurrence.

**Array.of()**

&emsp;&emsp;Creates a new Array instance with a variable number of arguments, regardless of number or type of the arguments.

## Array instances

All Array instances inherit from Array.prototype. The prototype object of the Array constructor can be modified to affect all Array instances.

### Properties

**Array.prototype.constructor**

&emsp;&emsp;Specifies the function that creates an object's prototype.

**Array.prototype.length**

&emsp;&emsp;Reflects the number of elements in an array.

### Methods

#### Mutator methods

These methods modify the array:

**Array.prototype.copyWithin()**

&emsp;&emsp;Copies a sequence of array elements within the array.

**Array.prototype.fill()**

&emsp;&emsp;Fills all the elements of an array from a start index to an end index with a static value.

**Array.prototype.pop()**

&emsp;&emsp;Removes the last element from an array and returns that element.

**Array.prototype.push()**

&emsp;&emsp;Adds one or more elements to the end of an array and returns the new length of the array.

**Array.prototype.reverse()**

&emsp;&emsp;Reverses the order of the elements of an array in place — the first becomes the last, and the last becomes the first.

**Array.prototype.shift()**

&emsp;&emsp;Removes the first element from an array and returns that element.

**Array.prototype.sort()**

&emsp;&emsp;Sorts the elements of an array in place and returns the array.

**Array.prototype.splice()**

&emsp;&emsp;Adds and/or removes elements from an array.

**Array.prototype.unshift()**

&emsp;&emsp;Adds one or more elements to the front of an array and returns the new length of the array.

#### Accessor methods

These methods do not modify the array and return some representation of the array.

**Array.prototype.concat()**

&emsp;&emsp;Returns a new array comprised of this array joined with other array(s) and/or value(s).

**Array.prototype.includes()**

&emsp;&emsp;Determines whether an array contains a certain element, returning true or false as appropriate.

**Array.prototype.join()**

&emsp;&emsp;Joins all elements of an array into a string.

**Array.prototype.slice()**

&emsp;&emsp;Extracts a section of an array and returns a new array.

**Array.prototype.toSource()**

&emsp;&emsp;Returns an array literal representing the specified array; you can use this value to create a new array. Overrides the Object.prototype.toSource() method.

**Array.prototype.toString()**

&emsp;&emsp;Returns a string representing the array and its elements. Overrides the Object.prototype.toString() method.

**Array.prototype.toLocaleString()**

&emsp;&emsp;Returns a localized string representing the array and its elements. Overrides the Object.prototype.toLocaleString() method.

**Array.prototype.indexOf()**

&emsp;&emsp;Returns the first (least) index of an element within the array equal to the specified value, or -1 if none is found.

**Array.prototype.lastIndexOf()**

&emsp;&emsp;Returns the last (greatest) index of an element within the array equal to the specified value, or -1 if none is found.

#### Iteration methods

Several methods take as arguments functions to be called back while processing the array. When these methods are called, the length of the array is sampled, and any element added beyond this length from within the callback is not visited. Other changes to the array (setting the value of or deleting an element) may affect the results of the operation if the method visits the changed element afterwards. While the specific behavior of these methods in such cases is well-defined, you should not rely upon it so as not to confuse others who might read your code. If you must mutate the array, copy into a new array instead.

**Array.prototype.forEach()**

&emsp;&emsp;Calls a function for each element in the array.

**Array.prototype.entries()**

&emsp;&emsp;Returns a new Array Iterator object that contains the key/value pairs for each index in the array.

**Array.prototype.every()**

&emsp;&emsp;Returns true if every element in this array satisfies the provided testing function.

**Array.prototype.some()**

&emsp;&emsp;Returns true if at least one element in this array satisfies the provided testing function.

**Array.prototype.filter()**

&emsp;&emsp;Creates a new array with all of the elements of this array for which the provided filtering function returns true.

**Array.prototype.find()**

&emsp;&emsp;Returns the found value in the array, if an element in the array satisfies the provided testing function or undefined if not found.

**Array.prototype.findIndex()**

&emsp;&emsp;Returns the found index in the array, if an element in the array satisfies the provided testing function or -1 if not found.

**Array.prototype.keys()**

&emsp;&emsp;Returns a new Array Iterator that contains the keys for each index in the array.

**Array.prototype.map()**

&emsp;&emsp;Creates a new array with the results of calling a provided function on every element in this array.

**Array.prototype.reduce()**

&emsp;&emsp;Apply a function against an accumulator and each value of the array (from left-to-right) as to reduce it to a single value.

**Array.prototype.reduceRight()**

&emsp;&emsp;Apply a function against an accumulator and each value of the array (from right-to-left) as to reduce it to a single value.

**Array.prototype.values()**

&emsp;&emsp;Returns a new Array Iterator object that contains the values for each index in the array.

**Array.prototype\[@@iterator]()**

&emsp;&emsp;Returns a new Array Iterator object that contains the values for each index in the array.

### Array generic methods
> 
Array generics are non-standard, deprecated and might get removed in the future. Note that you can not rely on them cross-browser. However, there is a [shim available on GitHub](https://github.com/plusdude/array-generics).

Sometimes you would like to apply array methods to strings or other array-like objects (such as function [arguments](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/arguments)). By doing this, you treat a string as an array of characters (or otherwise treat a non-array as an array). For example, in order to check that every character in the variable str is a letter, you would write:
```javascript
function isLetter(character) {
  return character >= 'a' && character <= 'z';
}

if (Array.prototype.every.call(str, isLetter)) {
  console.log("The string '" + str + "' contains only letters!");
}
```
This notation is rather wasteful and JavaScript 1.6 introduced a generic shorthand:

```javascript
if (Array.every(str, isLetter)) {
  console.log("The string '" + str + "' contains only letters!");
}
```
Generics are also available on String.

These are currently not part of ECMAScript standards (though the ES6 Array.from() can be used to achieve this). The following is a shim to allow its use in all browsers:

```javascript
// Assumes Array extras already present (one may use polyfills for these as well)
(function() {
  'use strict';

  var i,
    // We could also build the array of methods with the following, but the
    //   getOwnPropertyNames() method is non-shimable:
    // Object.getOwnPropertyNames(Array).filter(function(methodName) {
    //   return typeof Array[methodName] === 'function'
    // });
    methods = [
      'join', 'reverse', 'sort', 'push', 'pop', 'shift', 'unshift',
      'splice', 'concat', 'slice', 'indexOf', 'lastIndexOf',
      'forEach', 'map', 'reduce', 'reduceRight', 'filter',
      'some', 'every', 'find', 'findIndex', 'entries', 'keys',
      'values', 'copyWithin', 'includes'
    ],
    methodCount = methods.length,
    assignArrayGeneric = function(methodName) {
      if (!Array[methodName]) {
        var method = Array.prototype[methodName];
        if (typeof method === 'function') {
          Array[methodName] = function() {
            return method.call.apply(method, arguments);
          };
        }
      }
    };

  for (i = 0; i < methodCount; i++) {
    assignArrayGeneric(methods[i]);
  }
}());
```

### Examples
#### Creating an array

The following example creates an array, msgArray, with a length of 0, then assigns values to msgArray[0] and msgArray[99], changing the length of the array to 100.

```javascript
var msgArray = [];
msgArray[0] = 'Hello';
msgArray[99] = 'world';

if (msgArray.length === 100) {
  console.log('The length is 100.');
}
```

#### Creating a two-dimensional array

The following creates a chess board as a two dimensional array of strings. The first move is made by copying the 'p' in (6,4) to (4,4). The old position (6,4) is made blank.
```javascript
var board = [ 
  ['R','N','B','Q','K','B','N','R'],
  ['P','P','P','P','P','P','P','P'],
  [' ',' ',' ',' ',' ',' ',' ',' '],
  [' ',' ',' ',' ',' ',' ',' ',' '],
  [' ',' ',' ',' ',' ',' ',' ',' '],
  [' ',' ',' ',' ',' ',' ',' ',' '],
  ['p','p','p','p','p','p','p','p'],
  ['r','n','b','q','k','b','n','r'] ];

console.log(board.join('\n') + '\n\n');

// Move King's Pawn forward 2
board[4][4] = board[6][4];
board[6][4] = ' ';
console.log(board.join('\n'));
```
Here is the output:

```javascript
R,N,B,Q,K,B,N,R
P,P,P,P,P,P,P,P
 , , , , , , , 
 , , , , , , , 
 , , , , , , , 
 , , , , , , , 
p,p,p,p,p,p,p,p
r,n,b,q,k,b,n,r

R,N,B,Q,K,B,N,R
P,P,P,P,P,P,P,P
 , , , , , , , 
 , , , , , , , 
 , , , ,p, , , 
 , , , , , , , 
p,p,p,p, ,p,p,p
r,n,b,q,k,b,n,r
```

### Specifications

| Specification | Status | Comment |
| --------------|------------|-------|
| ECMAScript 1st Edition (ECMA-262) | Standard | Initial definition.|
| ECMAScript 5.1 (ECMA-262) The definition of 'Array' in that specification. | Standard | New methods added: Array.isArray, indexOf, lastIndexOf, every, some, forEach, map, filter, reduce, reduceRight |
| ECMAScript 2015 (6th Edition, ECMA-262) The definition of 'Array' in that specification. | Standard | New methods added: Array.from, Array.of, find, findIndex, fill, copyWithin |

### Browser compatibility
**Desktop**
> 
|Feature | Chrome | Firefox (Gecko) | Internet Explorer | Opera | Safari|
|:-------:|:-------:|:-------:|:-------:|:-------:|:-------:|
|Basic support | (Yes) | (Yes) | (Yes) | (Yes) | (Yes)|

**Mobile**
> 
|Feature | Android | Chrome for Android | Firefox Mobile (Gecko) | IE Mobile | Opera Mobile | Safari Mobile |
|:-------:|:-------:|:-------:|:-------:|:-------:|:-------:|:-------:|
|Basic support | (Yes) | (Yes) | (Yes) | (Yes) | (Yes)| (Yes) |

### See also

- [JavaScript Guide: “Indexing object properties][1]
- [JavaScript Guide: “Predefined Core Objects: Array Object”][2]
- [Array comprehensions][3]
- [Polyfill for JavaScript 1.8.5 Array Generics and ECMAScript 5 Array Extras][4]
- [Typed Arrays][5]

[length]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/length
[exec]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp/exec
[match]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/match
[replace]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace
[join]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join
[slice]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice
[indexOf]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
[push]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
[splice]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice

[1]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Working_with_Objects#Indexing_object_properties
[2]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Predefined_Core_Objects#Array_Object
[3]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Array_comprehensions
[4]: https://github.com/plusdude/array-generics
[5]: https://developer.mozilla.org/en-US/docs/JavaScript_typed_arrays