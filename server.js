const port = 34090; // port de l'application

const http = require('http');
const express = require('express');
const session = require('express-session');
const { Server } = require('socket.io');
const sequelize = require("./database.js"); // Gestionnaire et intégrateur de base de donnée
const passport = require("passport"); // Gestionnaire d'authentification

const app = express(); // Instanciation de l'application

const indexRouter = require("./routes/index"); // Paramétrage du routeur par défaut
const authRouter = require("./routes/auth"); // Paramétrage du routeur d'authentification

sequelize.sync().then(()=>{ // Synchronisation à la base de donnée
    console.log("database up !");
});



app.use(express.static('public')); //Définition d'un dossier "public" qui contient les données lié au site (images ,fonts, css)
app.set('view engine', 'ejs'); // Application du modèle de vue EJS
app.use(express.urlencoded({ extended: true })); // Permet de récupérer les objets des requêtes post et put sous forme de string ou d'arrays
app.use(session({ secret: "SECRETKEY", resave: true, saveUninitialized: true })); // Définis une clé de chiffrement pour les session express (pas top niveau sécu)
app.use(passport.initialize());
app.use(passport.session()) //Génère une session Express avec l'authentification de passport

app.use('/', indexRouter); app.use('/auth', authRouter); // Indique les routeur à utilisé en fonction de l'URL de la requête

const server = http.createServer(app);
const io = new Server(server); //créer un socket pour le serveur

var buttonValue = null; // Valeur d'un bouton pour faire des test sur les socket

io.on('connection', function(socket) { //gestion des événement suite à une connexion avec un socket client
    console.log("New user got a socket connection");
    socket.on('addOne', function() {
        buttonValue++;
        io.emit('addOneResponse', buttonValue);
    })
    socket.on('disconnect', function() { // gère la déconnection
        console.log("A socket was disbanded");
    });
});


server.listen(port, () => { // Ouverture du serveur sur le port défini au début
    console.log(`Server started at http://localhost:${port}`);
});