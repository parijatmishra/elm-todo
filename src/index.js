'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');

// require index.html, so that webpack copies it to dist.
require('./index.html');

// bootstrap Elm program
const Elm = require('./Main.elm');
const mountNode = document.getElementById('main');
const app = Elm.Main.embed(mountNode);