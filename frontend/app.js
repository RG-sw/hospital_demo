'use strict';  // to enable error detection
// https://medium.com/swlh/how-to-create-your-first-login-page-with-html-css-and-javascript-602dd71144f1

const loginForm = document.getElementById("login-form");
const loginButton = document.getElementById("login-form-submit");
const loginErrorMsg = document.getElementById("login-error-msg");

const token_url = "http://127.0.0.1:8000/token";
        

// let ws = new WebSocket("ws://127.0.0.1:8000/ws");


// npm install http-server -g


loginButton.addEventListener("click", (e) => {
    e.preventDefault();
    const username = loginForm.username.value;
    const password = loginForm.password.value;

    let token = requestToken(token_url, username, password);

    if (token != null) {
        alert('login successful.');
        // window.location.replace("/secondpage.html");
        myFunction();
    } else {
        loginErrorMsg.style.opacity = 1;
    }
})


function requestToken(url, username, password) {
    
    let httpRequest = new XMLHttpRequest();
    
    let token_response;

    function alertContents() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                token_response = JSON.parse(httpRequest.responseText);
                alert('request successful.');
            } else {
                alert('There was a problem with the request.');
            }
        }
    }   
    httpRequest.onreadystatechange = alertContents;

    let FD  = new FormData();
    FD.append('username', username);
    FD.append('password', password);
    httpRequest.open('POST', url, false); // false = synchronous
    httpRequest.send(FD);

    return token_response;
}

// function fetchRequestToken(url, username, password) {
//     let FD  = new FormData();
//     FD.append('username', username);
//     FD.append('password', password);
//     return fetch(url, {
//         method: 'POST',
//         body: FD,
//         }).then(function(response){
//         return response.json(); // Process it inside the `then`
//     });
// };

function myFunction() {
    var loginForm = document.getElementById('main-holder');
    loginForm.remove();

    var demoButtonMain = document.createElement('main');
    demoButtonMain.setAttribute('id', 'demo-button-holder');

    var demoTextField = document.createElement('text');
    demoTextField.setAttribute('id', 'demo-text');
    demoTextField.className = 'textbox';

    var demo_button = document.createElement('input');
    demo_button.setAttribute('id', 'demo-btn');
    demo_button.type = 'submit';
    demo_button.className = 'demo-btn';
    demo_button.value = 'Try Query';
    demo_button.innerText = 'demo-btn';

    document.body.appendChild(demoButtonMain);
    demoButtonMain.appendChild(demoTextField);
    demoButtonMain.appendChild(demo_button);
}

