<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Success</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="js/main.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-image: url('https://img.freepik.com/free-vector/delivery-service-with-masks-concept_23-2148535315.jpg?ga=GA1.1.1636780205.1718340265&semt=ais_user'); /* Path to your background image */
            background-size: cover;
            background-position: center;
            background-attachment: fixed; /* Ensures the background image remains fixed */
            background-color: rgba(0, 0, 0, 0.5); /* Background color with transparency */
            padding-top: 70px;
            color: #ffffff;
        }

       .navbar {
            background-color: #232F3E;
            color: #ffffff;
        }
        .navbar .navbar-brand, .navbar .nav-link {
            color: #ffffff;
        }
        .form-control {
            background-color: #ffffff;
            color: #000;
        }
        .offcanvas-body {
            padding: 15px;
        }
        .btn-outline-success {
            background-color: #febd69;
            color: #232F3E;
        }
        .btn-outline-success:hover {
            background-color: #febd99;
            color: #232F3E;
        }
        .btn-outline-secondary {
            color: #ffffff;
            border-color: #ffffff;
        }
        .btn-outline-secondary:hover {
            background-color: #febd69;
            color: #232F3E;
        }
        .checkout-container {
            display: flex;
        }
        .checkout-details {
            flex: 1;
            padding: 20px;
        }
        .product-details {
            margin-bottom: 20px;
        }
        .btn-home {
            background-color: #232F3E;
            color: #ffffff;
            font-size: 20px;
            border-radius: 5px;
            padding: 8px 12px;
            border: none;
        }
        .btn-home:hover {
            background-color: #febd69;
            color: #232F3E;
        }
        .btn-buy {
            background-color: #febd69;
            color: #232F3E;
            border: none;
            padding: 10px 20px;
            font-size: 18px;
            border-radius: 5px;
        }
        .btn-buy:hover {
            background-color: #f0c14b;
            color: #232F3E;
        }
        .card {
            background: rgba(255, 255, 255, 0.8); /* Card background with transparency */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* Optional: Box shadow for card */
        }

        .card-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 80vh; /* Adjust the height as needed */
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container-fluid">
        <form action="home.jsp" method="POST">
            <button class="btn-home" type="submit" name="home">
                <i class="fa fa-home"></i>
            </button>
        </form>
        
    </div>
</nav>

<div class="container">
    <div class="card-container">
        <div class="card text-center">
            <h2>Order Success</h2>
            <p>${message}</p>
            <p>Order Number: ${orderNumber}</p>
        </div>
    </div>
</div>

<input type="hidden" id="status" value="${status}">
<input type="hidden" id="message" value="${message}">
<input type="hidden" id="orderNumber" value="${orderNumber}">

<script type="text/javascript">
    var status = document.getElementById("status").value;
    var message = document.getElementById("message").value;
    var orderNumber = document.getElementById("orderNumber").value;

    if (status === "success") {
        Swal.fire({
            icon: 'success',
            title: 'Order Placed Successfully!',
            text: message + " Your order number is " + orderNumber + "."
        });
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-d1JcZm8dASb0mPv0RNFRpK0q8/6BJBmQKZNOs1/DYad66OpKefjUlCok2VdHbYD6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
