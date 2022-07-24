'use strict';  // to enable error detection
// https://medium.com/swlh/how-to-create-your-first-login-page-with-html-css-and-javascript-602dd71144f1

const loginForm = document.getElementById("login-form");
const loginButton = document.getElementById("login-form-submit");
const loginErrorMsg = document.getElementById("login-error-msg");

let ws = new WebSocket("ws://127.0.0.1:8000/ws");
// ws.onopen = function(e) {
//     alert("[open] Connection established");
//     alert("Sending to server");
//     ws.send("My name is John");
//   };

loginButton.addEventListener("click", (e) => {
    e.preventDefault();
    const username = loginForm.username.value;
    const password = loginForm.password.value;

    if (username === "user" && password === "web_dev") {
        alert("You have successfully logged in.");
        // ws = new WebSocket("ws://127.0.0.1:8000/ws");
        // ws.onopen = function(e) {
        //     ws.send("My name is John");
        // }
        ws.send(username);
        location.reload();
    } else {
        loginErrorMsg.style.opacity = 1;
    }
})

