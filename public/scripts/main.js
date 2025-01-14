const socket = io();

const buttonVal = document.getElementById("buttonVal");

function redirectByPost(url, parameters, inNewTab) {
    parameters = parameters || {};
    inNewTab = inNewTab === undefined ? true : inNewTab;

    var form = document.createElement("form");
    form.id = "reg-form";
    form.name = "reg-form";
    form.action = url;
    form.method = "post";
    form.enctype = "multipart/form-data";

    if (inNewTab) {
        form.target = "_blank";
    }

    Object.keys(parameters).forEach(function (key) {
        var input = document.createElement("input");
        input.type = "text";
        input.name = key;
        input.value = parameters[key];
        form.appendChild(input);
    });

    document.body.appendChild(form);
    form.submit();
    document.body.removeChild(form);

    return false;
}

buttonVal.addEventListener("click", function() {
    socket.emit("addOne");
    console.log("addOne, done");
});


socket.on("addOneResponse", (buttonValue) => {
    const valeur = document.getElementById("valeur");
    valeur.innerHTML = `Valeur: ${buttonValue}`;
});

function deleteUser(userid){
    redirectByPost('/action/deleteUser/' + userid,null,false);
}

function renewUserPassword(userid){
    redirectByPost('/action/renewPassword/' + userid,null,false);
}

function addUser(){
    document.location.href = '/auth/signup/';
}

function updateUser(userid,email,DSIO_Status,ADMIN_Status){
    redirectByPost('/action/updateUser/' + userid + email + DSIO_Status + ADMIN_Status,null,false,);
}