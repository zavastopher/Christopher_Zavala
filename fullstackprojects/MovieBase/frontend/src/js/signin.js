import APIClient from "./APIClient.js";

const signInForm = document.getElementById("sign-in-form");

signInForm.addEventListener("submit", (event) => {
    event.preventDefault();

    const form = event.target;

    const email = form.elements['email'].value;
    const password = form.elements['password'].value;

    APIClient.login(email, password).then(userData => {
        console.log("Logged in...")
        localStorage.setItem('user', JSON.stringify(userData.user));
        document.location = '/';
    })
    .catch(error => {
        console.log(error);
    })

    return false;
})