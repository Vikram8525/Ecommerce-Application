<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Magic Card</title>
<style>
  :root {
    --rotate: 132deg;
    --card-height: 65vh;
    --card-width: calc(var(--card-height) / 1.5);
  }

  body {
    min-height: 100vh;
    background: #ffb536;
    display: flex;
    align-items: center;
    justify-content: center; 
    flex-direction: column;
    padding-top: 2rem;
    padding-bottom: 2rem;
    box-sizing: border-box;
  }

  .card {
    background: #191c29;
    width: var(--card-width);
    height: var(--card-height);
    padding: 3px;
    position: relative;
    border-radius: 6px;
    justify-content: center;
    align-items: center;
    text-align: center;
    display: flex;
    flex-direction: column; 
    font-size: 1.5em;
    color: rgb(88, 199, 250, 0%);
    cursor: pointer;
    font-family: cursive;
    margin: 1rem; 
    background-size: cover;
    background-position: center;
    transition: transform 0.3s ease-in-out;
  }

  .card:hover {
    color: rgb(0, 0, 0);
  }

  .card:hover:before,
  .card:hover:after {
    animation: none;
    opacity: 0;
  }

  .card::before {
    content: "";
    width: 104%;
    height: 102%;
    border-radius: 8px;
    background-image: linear-gradient(var(--rotate), #ffa65d, #e37f3c 43%, #ff5e00);
    position: absolute;
    z-index: -1;
    top: -1%;
    left: -2%;
    animation: spin 2.5s linear infinite;
  }

  .card::after {
    position: absolute;
    content: "";
    top: calc(var(--card-height) / 6);
    left: 0;
    right: 0;
    z-index: -1;
    height: 100%;
    width: 100%;
    margin: 0 auto;
    transform: scale(0.8);
    filter: blur(calc(var(--card-height) / 6));
    background-image: linear-gradient(var(--rotate), #ff5d5d, #e33c3c 43%, #c20000);
    opacity: 1;
    transition: opacity 0.5s;
    animation: spin 2.5s linear infinite;
  }

  @keyframes spin {
    0% {
      --rotate: 0deg;
    }
    100% {
      --rotate: 360deg;
    }
  }

  .card:hover span {
    color: rgb(2, 2, 2);
    transition: color 1s;
  }

  .button-container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    margin-top: 1rem;
  }

  .button-container form {
    margin-bottom: 1rem;
  }

  .button-container input[type="submit"] {
    display: none; 
  }

  .card span {
    margin-top: auto; 
  }

  a {
    color: #212534;
    text-decoration: none;
    font-family: sans-serif;
    font-weight: bold;
    margin-top: 2rem;
  }

  
  @media (max-width: 768px) {
    .card {
      width: 80%; 
    }
    body {
      padding-left: 1rem;
      padding-right: 1rem;
    }
  }
</style>
</head>
<body>

<div style="display: flex;">

<div class="card" style="background-image: url('https://img.freepik.com/free-photo/location-symbol-with-building_23-2150169872.jpg?ga=GA1.1.1636780205.1718340265&semt=sph');" onclick="submitForm('form1');">
  <form id="form1" action="AddProfile.jsp" >
    <input type="hidden" name="card1" value="card1">
  </form>
  <span>Add Address</span>
</div>

<div class="card" style="background-image: url('https://img.freepik.com/free-vector/cashback-concept-style_23-2148458404.jpg?ga=GA1.1.1636780205.1718340265&semt=ais_user');" onclick="submitForm('form2');">
  <form id="form2" action="check-wallet-balance.php" method="post">
    <input type="hidden" name="card2" value="card2">
  </form>
  <span>Check Wallet Balance</span>
</div>

<div class="card" style="background-image: url('https://img.freepik.com/free-vector/appointment-booking-with-smartphone_23-2148554312.jpg');" onclick="submitForm('form3');">
  <form id="form3" action="order-details.php" method="post">
    <input type="hidden" name="card3" value="card3">
  </form>
  <span>Order History</span>
</div>

</div>


<script>
  function submitForm(formId) {
    document.getElementById(formId).submit();
  }
</script>

</body>
</html>
