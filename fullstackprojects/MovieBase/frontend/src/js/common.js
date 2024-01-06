/*
* Common.js contains javascript for common tasks between all pages
*/

// Set every sign in navigation button to redirect to the signin page
try {
    document.getElementById('signin-btn').addEventListener('click', (e) => {
        document.location='/signin';
    });
} catch {
    console.log('no signin button found');
}

// Set every sign up button to redircet to the sign up page
try {
    document.getElementById('signup-btn').addEventListener('click', (e) => {
        document.location='/signup';
    });
} catch {
    console.log('no sign up button found');
}

// Set every home button to redirect to the home splash page
try {
    document.getElementById('home-btn').addEventListener('click', (e) => {
        document.location='/';
    });
} catch {
    console.log('no home button found');
}