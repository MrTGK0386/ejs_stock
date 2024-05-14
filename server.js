const http = require('http');
const express = require('express');
const { Server } = require('socket.io');
const port = 34090;
const sequelize = require("./database.js");

const app = express();

const indexRouter = require("./routes/index");
const authRouter = require("./routes/auth");

sequelize.sync().then(()=>{
    console.log("database up !.");
});



app.use(express.static('public'));
app.set('view engine', 'ejs');
app.use(express.urlencoded({ extended: true }));

app.use('/', indexRouter)
app.use('/auth', authRouter);

const server = http.createServer(app);
const io = new Server(server);

var buttonValue = null;

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


server.listen(port, () => {
    console.log(`Server started at http://localhost:${port}`);
});