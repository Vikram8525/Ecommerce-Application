<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, com.chainsys.finalproject.util.Connectivity" %>
<%@ page import="com.chainsys.finalproject.model.User" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Retrieve the userId and paymentMethod from the previous page
    int userId = Integer.parseInt(request.getParameter("userId"));
    String paymentMethod = request.getParameter("paymentMethod");

    // Retrieve user details from the database
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    User user = null;
    try {
        connection = Connectivity.getConnection();
        String sql = "SELECT user_name, wallet_balance FROM users WHERE user_id = ?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, userId);
        resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            user = new User();
            user.setUserName(resultSet.getString("user_name"));
            user.setWalletBalance(resultSet.getDouble("wallet_balance"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (resultSet != null) resultSet.close();
        if (preparedStatement != null) preparedStatement.close();
        if (connection != null) connection.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
        }

        .left-side, .right-side {
            width: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .left-side {
            background-color: #2e3192;
            padding: 20px;
        }

        .right-side {
        background-image: url('https://img.freepik.com/free-vector/indian-rupee-coins-falling-background_23-2148005748.jpg?ga=GA1.1.1636780205.1718340265&semt=sph');
           
            padding: 20px;
        }

        .card {
            width: 400px;
            height: 250px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: white;
            font-size: 1.2em;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card img {
   			width: 100%;
    		height: 100%;
    		object-fit: cover;
    		border-radius: 0px;
		}

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .right-card {
            width: 400px;
            height: 200px;
            border-radius: 10px;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .right-card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .button {
            background-color: #FF9900;
            color: white;
            padding: 10px 80px;
            border: 2px solid black;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .button:hover {
            background-color: #e68a00;
        }

        .button-container {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="left-side">
        <%-- Display the card based on the payment method --%>
        <% if ("Amazon Pay".equals(paymentMethod)) { %>
            <div class="card">
                <img src="https://m.media-amazon.com/images/G/31/img18/AmazonPay/Affordability/CBCC/New_CBCCcard_500x315._CB408517060_.png" alt="Amazon Pay">
            </div>
        <% } else if ("Google Pay".equals(paymentMethod)) { %>
            <div class="card">
                <img src="https://cdn.dribbble.com/users/4016009/screenshots/14104373/dribbble_shot_hd_-_3.png" alt="Google Pay">
            </div>
        <% } else if ("Credit Card".equals(paymentMethod)) { %>
            <div class="card">
                <img src="https://www.liccards.in/card-image/1710148877.png" alt="Credit Card">
            </div>
        <% } else if ("Debit Card".equals(paymentMethod)) { %>
            <div class="card">
                <img src="https://sbi.co.in/documents/16012/41290850/Visa+%281%29.png" alt="Debit Card">
            </div>
        <% } else if ("PhonePe".equals(paymentMethod)) { %>
            <div class="card">
                <img src="https://www.livelaw.in/h-upload/2023/01/05/1500x900_452434-phonepe-and-digipe.webp" alt="PhonePe">
            </div>
        <% } %>
    </div>

    <div class="right-side">
        <div class="right-card">
            <h2>Welcome, <%= user.getUserName() %></h2>
            <p>Your <%= paymentMethod %> balance is <%= user.getWalletBalance() %></p>
            <div class="button-container">
                <form action="AddWalletMoney.jsp" method="post">
                    <input type="hidden" name="userId" value="<%= userId %>">
                    <input type="hidden" name="paymentMethod" value="<%= paymentMethod %>">
                    <button type="submit" class="button">Add Wallet Money</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
