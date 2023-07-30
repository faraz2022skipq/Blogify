const loginForm = document.getElementById('login-form');
loginForm.addEventListener('submit', function (event) {
    event.preventDefault();

    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;

    // Code to check the username and password against a database or server goes here.
    // For this example, we'll just check for a simple condition.
    if (username === 'admin' && password === 'password') {
        alert('Login successful!');
        // Code to redirect the user to the dashboard or another page goes here.
    } else {
        alert('Invalid username or password. Please try again.');
    }
});
