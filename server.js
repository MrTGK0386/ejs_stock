const http = require('http');
const express = require('express');
const { Server } = require('socket.io');
const port = 34090;

const app = express();


app.use(express.static('public'));
app.set('view engine', 'ejs');
app.use(express.urlencoded({ extended: true }));

const server = http.createServer(app);
const io = new Server(server);

var buttonValue = null;
const username= "test";

io.on('connection', function(socket) {
    console.log("user connected");
    socket.on('addOne', function() {
        buttonValue++;
        io.emit('addOneResponse', buttonValue);
    })
    socket.on('disconnect', function() {
        console.log("user disconnected");
    });
});

app.get('/', function (req, res) {
    res.render('index', {username: username, admin: 1 , buttonValue: buttonValue});
});

app.get('/profil', function (req, res) {
    res.render('index', {username: username, admin: 1 });
});

app.get('/IO', function (req, res) {
    res.render('index', {username: username, admin: 1 });
});

app.get('stock', function (req, res) {
    res.render('index', {username: username, admin: 1 });
});

app.get('/logout', function (req, res) {
    res.render('index', {username: username, admin: 1 });
});

app.get('/gestion', function (req, res) {
    res.render('index', {username: username, admin: 1 });
});

app.get('/gestion/', function (req, res) {
    res.render('index', {username: username, admin: 1 });
})

server.listen(port, () => {
    console.log(`Server started at http://localhost:${port}`);
});