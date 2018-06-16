'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');

// require index.html, so that webpack copies it to dist.
require('./index.html');

// some basic javascript that will be included in the bundle
document.body.onload = addElement;

function addElement () { 
  // create a new div element 
  var newDiv = document.createElement("div"); 
  // and give it some content 
  var newContent = document.createTextNode("Hi there and greetings!"); 
  // add the text node to the newly created div
  newDiv.appendChild(newContent);  

  // add the newly created element and its content into the DOM 
  var currentDiv = document.getElementById("main"); 
  document.body.insertBefore(newDiv, currentDiv); 
}