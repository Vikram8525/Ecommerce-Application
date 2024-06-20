<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Methods</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
        }

        .left-side {
            width: 50%;
            background-image: url('https://img.freepik.com/free-vector/isometric-composition-with-online-shopping-elements_23-2147674283.jpg?t=st=1718505188~exp=1718505788~hmac=e30317e7be268bb2ac45af87728ace9f39e6845176e41273e474ec50f04133d9'); /* Add your background image here */
            background-size: cover;
            background-position: center;
        }

        .right-side {
            width: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #ffd080; /* Mild gray background */
        }

        .container {
            background-color: rgba(255, 255, 255, 0.1); /* Semi-transparent background */
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 80%;
            max-width: 400px;
            text-align: center;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
        }

        .payment-methods {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .payment-method {
            display: flex;
            align-items: center;
            padding: 10px;
            border-radius: 5px;
            background-color: #fbcf7d;
            transition: background-color 0.3s ease, transform 0.3s ease, border 0.3s ease;
            cursor: pointer;
            margin-bottom: 15px; /* Gap between each payment method */
            border: 2px solid transparent; /* Initial transparent border */
        }

        .payment-method img {
            width: 40px;
            height: 40px;
            margin-right: 15px;
        }

        .payment-method span {
            font-size: 18px;
            color: #333;
        }

        .payment-method:hover {
            transform: scale(1.05);
        }

        #amazon-pay:hover {
            background-color: #ff9900;
            border-color: #000000;
        }

        #google-pay:hover {
            background-color: #4285f4;
            border-color: #000000;
        }

        #credit-card:hover {
            background-color: #4caf50;
            border-color: #000000;
        }

        #debit-card:hover {
            background-color: #ff5722;
            border-color: #000000;
        }

        #phone-pay:hover {
            background-color: #7e57c2;
            border-color: #000000;
        }

        input[type="radio"] {
            display: none;
        }

        input[type="radio"]:checked + .payment-method {
            border: 2px solid #000; /* Add border to selected payment method */
        }

        form {
            margin: 0;
        }
    </style>
</head>
<body>
    <div class="left-side"></div>
    <div class="right-side">
        <div class="container">
            <h1>Select Wallet Type</h1>
            <div class="payment-methods">
                <form id="amazon-pay-form" action="Wallet.jsp" method="post">
                    <input type="hidden" name="userId" value="<%= request.getParameter("userId") %>">
                    <input type="hidden" name="paymentMethod" value="Amazon Pay">
                    <input type="radio" id="amazon-pay-radio" name="selectedPaymentMethod" value="Amazon Pay" onchange="document.getElementById('amazon-pay-form').submit()">
                    <label for="amazon-pay-radio" class="payment-method" id="amazon-pay">
                        <img src="icons/amazon-pay.png" alt="Amazon Pay">
                        <span>Amazon Pay</span>
                    </label>
                </form>
                <form id="google-pay-form" action="Wallet.jsp" method="post">
                    <input type="hidden" name="userId" value="<%= request.getParameter("userId") %>">
                    <input type="hidden" name="paymentMethod" value="Google Pay">
                    <input type="radio" id="google-pay-radio" name="selectedPaymentMethod" value="Google Pay" onchange="document.getElementById('google-pay-form').submit()">
                    <label for="google-pay-radio" class="payment-method" id="google-pay">
                        <img src="icons/google-pay.png" alt="Google Pay">
                        <span>Google Pay</span>
                    </label>
                </form>
                <form id="credit-card-form" action="Wallet.jsp" method="post">
                    <input type="hidden" name="userId" value="<%= request.getParameter("userId") %>">
                    <input type="hidden" name="paymentMethod" value="Credit Card">
                    <input type="radio" id="credit-card-radio" name="selectedPaymentMethod" value="Credit Card" onchange="document.getElementById('credit-card-form').submit()">
                    <label for="credit-card-radio" class="payment-method" id="credit-card">
                        <img src="icons/credit-card.png" alt="Credit Card">
                        <span>Credit Card</span>
                    </label>
                </form>
                <form id="debit-card-form" action="Wallet.jsp" method="post">
                    <input type="hidden" name="userId" value="<%= request.getParameter("userId") %>">
                    <input type="hidden" name="paymentMethod" value="Debit Card">
                    <input type="radio" id="debit-card-radio" name="selectedPaymentMethod" value="Debit Card" onchange="document.getElementById('debit-card-form').submit()">
                    <label for="debit-card-radio" class="payment-method" id="debit-card">
                        <img src="icons/debit-card.png" alt="Debit Card">
                        <span>Debit Card</span>
                    </label>
                </form>
                <form id="phone-pay-form" action="Wallet.jsp" method="post">
                    <input type="hidden" name="userId" value="<%= request.getParameter("userId") %>">
                    <input type="hidden" name="paymentMethod" value="PhonePe">
                    <input type="radio" id="phone-pay-radio" name="selectedPaymentMethod" value="PhonePe" onchange="document.getElementById('phone-pay-form').submit()">
                    <label for="phone-pay-radio" class="payment-method" id="phone-pay">
                        <img src="icons/phone-pay.png" alt="PhonePe">
                        <span>PhonePe</span>
                    </label>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
