<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <style>
        /* Custom styles */
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        .card {
            margin-top: 2rem;
        }

        .btn-primary {
            width: 100%;
        }

        .card-header {
            background-color: #007bff;
            color: #fff;
            text-align: center;
        }

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
</head>
<body>
    <div class="container">
        <div class="row justify-content-center mt-5">
            <div class="col-md-6">
                <div class="card">
                    <h5 class="card-header">Login</h5>
                    <div class="card-body">
                        <form id="loginForm" action="LoginServlet" method="POST">
                            <div class="form-group">
                                <label for="userId">User ID</label>
                                <input type="text" class="form-control" id="userId" name="userId" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Login</button>
                        </form>
                    </div>
                </div>
                <!-- Register Button -->
                <form class="form" action="RegistrationForm.jsp">
                    <button class="btn" type="submit" id="registerBtn">Register
                        <div class="notification">If you are new here, choose me</div>
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- Custom JS -->
    <script>
        // Retrieve status from URL query parameters
        const urlParams = new URLSearchParams(window.location.search);
        const status = urlParams.get('status');

        // If status is failed, show SweetAlert popup
        if (status === 'failed') {
            Swal.fire({
                icon: 'error',
                title: 'Wrong username or password!',
                text: 'Your login failed!'
            });
        } else if (status === 'error') {
            Swal.fire({
                icon: 'error',
                title: 'Server Error',
                text: 'There was an error processing your request. Please try again later.'
            });
        }

        const registerBtn = document.getElementById('registerBtn');

        registerBtn.addEventListener('mouseenter', () => {
            showNotification(registerBtn, 'If you are new here, choose me');
        });

        registerBtn.addEventListener('mouseleave', () => {
            hideNotification(registerBtn);
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
