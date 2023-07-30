const signupForm = document.getElementById('signup-form');
signupForm.addEventListener('submit', function (event) {
    event.preventDefault();

    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirm-password').value;

    if (password !== confirmPassword) {
        alert('Passwords do not match. Please try again.');
        return;
    }

    // Code to submit the form to the server goes here.
    // You can use AJAX or a form submission to send the data to the server.
    // For this example, we'll just display an alert.
    alert('Signup successful!');
});
