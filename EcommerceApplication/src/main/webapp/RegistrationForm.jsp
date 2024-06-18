<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random" %>
<%@ page import="com.chainsys.finalproject.dao.UserDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .btn {
            display: inline-block;
            margin: 10px;
            padding: 15px 30px;
            font-size: 16px;
            font-weight: 500;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            position: relative;
            transition: background-color 0.3s, transform 0.3s;
        }

        .btn:hover {
            background-color: #0056b3;
            transform: translateY(-5px);
        }

        .notification {
            display: none;
            position: absolute;
            bottom: -40px;
            left: 50%;
            transform: translateX(-50%);
            background-color: #333;
            color: #fff;
            padding: 5px 10px;
            border-radius: 3px;
            font-size: 14px;
            white-space: nowrap;
            z-index: 1;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .btn:hover .notification {
            display: block;
            opacity: 1;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<body>
    <div class="container mt-5">
        <h2>Register</h2>
        <form action="RegisterServlet" method="POST" id="registrationForm">
            <div class="mb-3">
                <label for="user_id" class="form-label">User ID</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="user_id" name="user_id" readonly>
                    <button type="button" class="btn btn-outline-secondary" onclick="generateUserId()">
                        <i class="fa fa-refresh"></i>
                    </button>
                </div>
            </div>
            <div class="mb-3">
                <label for="user_name" class="form-label">User Name</label>
                <input type="text" class="form-control" id="user_name" name="user_name" required pattern="[a-zA-Z_]{3,20}"
                >
            </div>
            <div class="mb-3">
                <label for="user_email" class="form-label">Email</label>
                <input type="email" class="form-control" id="user_email" name="user_email" required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                >
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?\">
            </div>
            <div class="mb-3">
                <label for="confirm_password" class="form-label">Confirm Password</label>
                <input type="password" class="form-control" id="confirm_password" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?\">
            </div>
            <button type="submit" class="btn btn-primary">Register</button>
        </form>
        <!-- Login Button -->
        <form class="form" action="LoginForm.jsp">
            <button class="btn" type="submit" id="loginBtn">Login
                <div class="notification">If you are an existing user, choose me</div>
            </button>
        </form>
    </div>

    <script>
        function generateUserId() {
            fetch('GenerateUserIdServlet')
                .then(response => response.text())
                .then(data => {
                    document.getElementById('user_id').value = data;
                })
                .catch(error => console.error('Error:', error));
        }

        document.getElementById('registrationForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirm_password').value;
            if (password !== confirmPassword) {
                alert('Passwords do not match.');
                e.preventDefault();
            }
        });

        // Function to handle registration success and failure alerts
        function showAlert(title, message, icon, redirect) {
            Swal.fire({
                title: title,
                text: message,
                icon: icon,
                confirmButtonText: 'OK',
                allowOutsideClick: false
            }).then((result) => {
                if (result.isConfirmed && redirect) {
                    window.location.href = redirect;
                }
            });
        }

        // Check for URL parameter 'registration' to show alerts
        const urlParams = new URLSearchParams(window.location.search);
        const registration = urlParams.get('registration');
        if (registration === 'success') {
            showAlert('Success!', 'Registration successful.', 'success', 'IdMailServlet');
        } else if (registration === 'failure') {
            showAlert('Error!', 'Registration failed. Please try again.', 'error', null);
        } else if (registration === 'user_exists') {
            showAlert('Error!', 'User ID or email already exists.', 'error', null);
        }

        const loginBtn = document.getElementById('loginBtn');

        loginBtn.addEventListener('mouseenter', () => {
            showNotification(loginBtn, 'If you are an existing user, choose me');
        });

        loginBtn.addEventListener('mouseleave', () => {
            hideNotification(loginBtn);
        });

        function showNotification(btn, message) {
            const notification = btn.querySelector('.notification');
            notification.innerText = message;
            notification.style.display = 'block';
            setTimeout(() => {
                notification.style.opacity = '1';
            }, 10);
        }

        function hideNotification(btn) {
            const notification = btn.querySelector('.notification');
            notification.style.opacity = '0';
            setTimeout(() => {
                notification.style.display = 'none';
            }, 300);
        }
    </script>
</body>
</html>
