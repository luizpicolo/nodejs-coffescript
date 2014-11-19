var app, eco, express, port;

require("coffee-script");

express = require('express');

eco = require('eco');

app = express.createServer();

app.configure(function() {
  app.set('views', __dirname + "/views");
  app.set('view engine', 'eco');
  app.use(express.bodyParser());
  return app.use(express["static"](__dirname + "/public"));
});

app.get('/', function(req, res) {
  return res.render('login', {
    title: 'log in'
  });
});

app.post('/login', function(req, res) {
  var user;
  user = req.body.user;
  if (user.name === 'admin' && user.password === 'admin') {
    return res.render('loggedin', {
      title: "Logged in as " + user.name,
      user: user
    });
  } else {
    return res.render('login', {
      title: 'Error',
      error: true
    });
  }
});

app.post('/logout', function(req, res) {
  return res.render('login', {
    title: 'logged out',
    loggedOut: true
  });
});

port = process.env.PORT || 9294;

app.listen(port, function() {
  return console.log("Server is starting on port: " + port);
});
