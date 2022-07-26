'use strict';  // to enable error detection
// https://medium.com/swlh/how-to-create-your-first-login-page-with-html-css-and-javascript-602dd71144f1

const loginForm = document.getElementById("login-form");
const loginButton = document.getElementById("login-form-submit");
const loginErrorMsg = document.getElementById("login-error-msg");

const token_url = "http://127.0.0.1:8000/token";
        

// let ws = new WebSocket("ws://127.0.0.1:8000/ws");

loginButton.addEventListener("click", (e) => {
    e.preventDefault();
    const username = loginForm.username.value;
    const password = loginForm.password.value;

    let token = requestToken(token_url, username, password);

    if (token != null) {
        fromLoginToGetDemo(token);
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

function requestPatient(patient_ssn, token) {
    let url = 'http://127.0.0.1:8000/patient/' + patient_ssn
    let httpRequest = new XMLHttpRequest();
    let response;

    function alertContents() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                response = JSON.parse(httpRequest.responseText);
                alert('request successful.');
            } else {
                alert('There was a problem with the request.');
            }
        }
    }   
    httpRequest.onreadystatechange = alertContents;
    
    httpRequest.open('GET', url, false); // false = synchronous
    httpRequest.setRequestHeader('Authorization', 'Bearer '+token);
    httpRequest.send();

    console.log(response)

    return response;
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

function fromLoginToGetDemo(token) {
    var loginForm = document.getElementById('main-holder');
    loginForm.remove();

    var demoMain = document.createElement('main');
    demoMain.setAttribute('id', 'demo-holder');

    var demoHeader = document.createElement('h1');
    demoHeader.setAttribute('id', 'demo-header');
    demoHeader.innerText = 'GET a Patient';

    var demoButton = document.createElement('input');
    demoButton.setAttribute('id', 'demo-input');
    demoButton.type = 'submit';
    demoButton.className = 'form-submit';
    demoButton.innerText = 'GET';

    var demoInput = document.createElement('input');
    demoInput.setAttribute('id', 'demo-input');
    demoInput.name = 'ssn';
    demoInput.type = 'text';
    demoInput.className = 'form-field';
    demoInput.placeholder = 'Insert Patient SSN';

    var demoForm = document.createElement('form');
    demoForm.setAttribute('id', 'demo-form');
    demoForm.className = 'form';


    demoForm.appendChild(demoInput);
    demoForm.appendChild(demoButton);
    demoMain.appendChild(demoHeader);
    demoMain.appendChild(demoForm);

    document.body.appendChild(demoMain);

    startDemo();   
    // demoButtonMain.appendChild(demoTextField);
    // demoButtonMain.appendChild(demo_button);
}

function startDemo(token){
    const getForm = document.getElementById("demo-form");

    getForm.addEventListener("click", (e) => {
        e.preventDefault();
        const requested_ssn = getForm.ssn.value;
        
        let res = requestPatient(requested_ssn, token);
        alert(res);

    })
}