require('./main.css');
var Elm = require('./App.elm');

var root = document.getElementById('root');

Elm.App.embed(root);
