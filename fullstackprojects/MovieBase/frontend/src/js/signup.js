import APIClient from "./APIClient.js";

document.getElementById('create-user-form').addEventListener('submit', handleCreateUser);

function handleCreateUser(event) {
    // Prevent the form from submitting the traditional way
    event.preventDefault();

    // Access the form element using the event
    const form = event.target;

    // Access the input values using the form's elements property
    const firstName = form.elements['first-name'].value;
    const lastName = form.elements['last-name'].value;
    const email = form.elements['email'].value;
    const password = form.elements['password'].value;

    APIClient.createAccount(firstName, lastName, email, password).then(_ => {
        APIClient.login(email, password).then(userData => {
            console.log(userData);
            localStorage.setItem('user', JSON.stringify(userData.user));
            document.location = '/'
        })
    })
    .catch(error => {
        console.log(error);
    })

    return false;
}