const socket = io();

const buttonVal = document.getElementById("buttonVal");

buttonVal.addEventListener("click", function() {
    socket.emit("addOne");
    console.log("addOne, done");
});


socket.on("addOneResponse", (buttonValue) => {
    const valeur = document.getElementById("valeur");
    valeur.innerHTML = `Valeur: ${buttonValue}`;
});