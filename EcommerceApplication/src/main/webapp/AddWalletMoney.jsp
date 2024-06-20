<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.chainsys.finalproject.model.User" %>

<%
    // Retrieve the userId and paymentMethod from the previous page
    int userId = Integer.parseInt(request.getParameter("userId"));
    String paymentMethod = request.getParameter("paymentMethod");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Wallet Money</title>
    <!-- Link to Font Awesome for rupees icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('https://images.unsplash.com/photo-1542281286-9e0a16bb7366');
            background-size: cover;
            background-repeat: no-repeat;
            margin: 0;
        }

        .container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 350px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .container:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        h2 {
            color: #2e3192;
        }

        .input-field {
            margin: 10px 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 1.2em;
        }

        .input-field input {
            width: 60%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
        }

        .input-field .rupee-symbol {
            margin-left: 5px;
            font-size: 1.2em;
        }

        .captcha-container {
            margin: 10px 0;
            font-size: 1.2em;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .captcha-container span {
            font-weight: bold;
        }

        .captcha-container button {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            margin-left: 10px;
        }

        .captcha-container button img {
            width: 24px;
            height: 24px;
        }

        .captcha-container input {
            width: 60%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
        }

        .checkbox-container {
            margin: 10px 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2em;
        }

        .checkbox-container input {
            margin-right: 10px;
        }

        .button-container {
            display: flex;
            justify-content: center;
        }

        .button {
            background-color: #FF9900;
            color: white;
            padding: 10px 40px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: none; /* Initially hidden */
            font-size: 1.2em;
        }

        .button:hover {
            background-color: #e68a00;
        }
    </style>
    <script>
        function validateCaptcha() {
            var userCaptcha = document.getElementById('userCaptcha').value;
            var actualCaptcha = document.getElementById('captcha').innerText;
            return userCaptcha === actualCaptcha;
        }

        function enableSubmit() {
            var checkbox = document.getElementById('confirmCheckbox');
            var submitButton = document.getElementById('submitButton');
            var captchaValid = validateCaptcha();
            if (checkbox.checked && captchaValid) {
                submitButton.style.display = 'block';
            } else {
                submitButton.style.display = 'none';
            }
        }

        function generateCaptcha() {
            var captchaText = Math.random().toString(36).substring(2, 8);
            document.getElementById('captcha').innerText = captchaText;
        }

        window.onload = function() {
            generateCaptcha();
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Add Money to Wallet</h2>
        <form action="ProcessAddMoney.jsp" method="post">
            <input type="hidden" name="userId" value="<%= userId %>">
            <input type="hidden" name="paymentMethod" value="<%= paymentMethod %>">
            <div class="input-field">
                <label for="amount">Amount to Add:</label>
                <input type="number" id="amount" name="amount" value="1000" step="1000" required>
                <span class="rupee-symbol"><i class="fas fa-rupee-sign"></i></span>
            </div>
            <div class="captcha-container">
                <span id="captcha"></span>
                <button type="button" onclick="generateCaptcha()">
                    <img src="https://img.icons8.com/ios-filled/50/000000/refresh.png" alt="Refresh">
                </button>
                <input type="text" id="userCaptcha" oninput="enableSubmit()" required placeholder="Enter Captcha">
            </div>
            <div class="checkbox-container">
                <input type="checkbox" id="confirmCheckbox" onclick="enableSubmit()">
                <label for="confirmCheckbox">Confirm</label>
            </div>
            <div class="button-container">
                <button type="submit" id="submitButton" class="button">Proceed</button>
            </div>
        </form>
    </div>
</body>
</html>
