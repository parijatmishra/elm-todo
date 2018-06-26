var jsonServer = require('json-server');
var server = jsonServer.create();
server.use(jsonServer.defaults());

// Introduce a delay -- if you want to see how the UI will behave when net is slow
const pause = require('connect-pause');
server.use(pause(1000));

var router = jsonServer.router('db.json');
server.use('/api', router);

console.log("Listening at 4000");
server.listen(4000);
