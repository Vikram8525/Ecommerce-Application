<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.Base64, java.sql.*, java.io.*, java.util.*, com.chainsys.finalproject.util.Connectivity" %>
    <%@page import="com.chainsys.finalproject.model.User" %>
    <% User user = (User) session.getAttribute("user");
    boolean isLoggedIn = (user != null);
    
    int cartItemCount = 0;
    if (isLoggedIn) {
        int userId = user.getUserId();
        try (Connection conn = Connectivity.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM Cart WHERE user_id = ?");
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                cartItemCount = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    int wishlistItemCount = 0;
    if (isLoggedIn) {
    	int userId = user.getUserId();
    try (Connection conn = Connectivity.getConnection()) {
        PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM wishlist WHERE user_id = ?");
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            wishlistItemCount = rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    }
   %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            padding-top: 70px; /* Ensure the navbar doesn't overlap the content */
            font-family: 'Roboto', sans-serif;
        }
        .navbar {
            background-color: #232F3E;
            color: #ffffff;
        }
        .navbar .navbar-brand,
        .navbar .nav-link {
            color: #ffffff;
        }
        #nav-logo-sprites {
            display: flex;
            align-items: center;
        }
        #nav-logo-sprites img {
            height: 40px; /* Adjust as needed */
            margin-right: 1px; /* Spacing between logo and text */
        }
        #glow-ingress-block {
            font-family: 'Roboto', sans-serif;
            color: #ffffff;
            display: flex;
            align-items: center;
            margin-left: 5px;
        }
        #glow-ingress-block i {
            font-size: 2rem; /* Increased size */
            margin-right: 10px;
            color: #ffffff; /* Icon color white */
        }
        #location-form .btn {
            background-color: transparent;
            border: none;
            color: #ffffff; /* Icon color white */
        }
        #location-form .btn:hover {
            color: #febd69; /* Change icon color on hover */
        }
        #location i {
            font-size: 2rem; /* Increased size for the location icon */
        }
        .nav-item .nav-link {
            color: #ffffff;
        }
        .nav-item .nav-link:hover {
            color: #dddddd;
        }
        .btn-outline-success {
            color: #ffffff;
            border-color: #febd69;
        }
        .btn-outline-success:hover {
            background-color: #febd69;
            color: #232F3E;
        }
        .nav-icons {
            display: flex;
            align-items: center;
        }
        .nav-icons .btn {
            margin-left: 10px;
            color: #ffffff;
            background-color: #232F3E;
            border: none;
        }
        .nav-icons .btn:hover {
            color: #febd69;
        }
        .form-control {
            background-color: #fff;
            color: #000;
            width: 200px; /* Increased width for the search bar */
        }
        .nav-logo-locale {
            padding-left: 1px; /* Adjust padding as needed */
            padding-bottom: 6px;
        }
        .view-products-button-container {
            margin-top: 20px;
            text-align: center;
        }
        .view-products-button {
            background: #007bff;
        }
        .view-products-button:hover {
            background: #0056b3;
        }
    </style>
    
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container-fluid">
            <div class="nav-left d-flex">
                <div id="nav-logo">
                    <a href="#" id="nav-logo-sprites" class="navbar-brand">
                        <img src="homeImage/logo.png" alt="Logo">
                        <span id="logo-ext" class="nav-sprite nav-logo-ext"></span>
                        <span class="nav-logo-locale">.in</span>
                    </a>
                </div>
                <div id="location">
                    
                            <i class="fa fa-map-marker" aria-hidden="true"></i>
                        
                </div>
                
     
                <div id="glow-ingress-block">
                <%if (isLoggedIn){ %>
                <%String a = user.getAddress(); %>
                <h6><%= a %></h6>
                <%} %>
                </div>
            </div>

            <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
                <form class="d-flex mx-auto" action="searchServlet" method="POST" role="search">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
                <div class="nav-icons">
               
              		<% if(isLoggedIn)
              			if (user.isSeller()) { %>
              		
                	<form action="SellerViewProducts.jsp" >
                        <button class="btn btn-secondary" type="submit" name="add_product"><i class="fa fa-plus"></i> Add Product</button>
                    </form>
                   <%} 
                   %>
                    <%if (isLoggedIn && !user.isSeller()){ %>
                    <form action="SellerLogin.jsp" >
                        <button class="btn btn-secondary" type="submit" name="become_seller">Become a Seller</button>
                    </form>
                    <%} %>
                    <%if (!isLoggedIn) { %>
                    <form action="LoginForm.jsp">
                        <button class="btn btn-secondary" type="submit" name="login_signup">Login/Sign Up</button>
                    </form>
                    <%} else {%>
                    <form action="LogoutServlet" method="post">
                        <button class="btn btn-secondary" type="submit" name="logout">Logout</button>
                    </form>
                    <%} %>
                    <form action="AddProfile.jsp"  class="box">
                        <button class="btn btn-secondary" type="submit" name="profile"><i class="fa fa-user-plus"></i></button>
                    </form>
                    <form action="ViewWishlist.jsp" method="POST">
                        <button class="btn btn-secondary" type="submit" name="wishlist"><i class="fa fa-heart-o"></i></button>
                    </form>
                    
                    <form action="ViewCart.jsp" class="box">
                        <button class="btn btn-secondary" type="submit" name="cart"><i class="fa fa-shopping-cart"></i></button>
                    </form>
                </div>
            </div>
        </div>
    </nav>

 <div class="view-products-button-container">
        <form action="ViewProduct.jsp" method="get">
            <button type="submit" class="view-products-button">View Products</button>
        </form>
    </div>
    <!-- Popup Script -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        // Display popup based on status and message received from servlet
        <% if (request.getAttribute("status") != null) { %>
            var status = '<%= request.getAttribute("status") %>';
            var message = '<%= request.getAttribute("message") %>';

            if (status === "success") {
                Swal.fire({
                    icon: 'success',
                    title: 'Profile Updated Successfully!',
                    text: message
                });
            } else if (status === "error") {
                Swal.fire({
                    icon: 'error',
                    title: 'Failed to Update Profile!',
                    text: message
                });
            }
        <% } %>
    </script>
     <script>
        document.addEventListener('DOMContentLoaded', function () {
            function updateCartNotification(count) {
                const cartButton = document.querySelector('.fa-shopping-cart');
                if (count > 0) {
                    const notification = document.createElement('span');
                    notification.className = 'cart-notification';
                    notification.textContent = count;
                    cartButton.parentElement.appendChild(notification);
                }
            }
            
            updateCartNotification(<%= cartItemCount %>); // Update cart count on page load
        });
        
        function updateWishlistNotification(count) {
            const wishlistButton = document.querySelector('.fa-heart-o');
            if (count > 0) {
                const notification = document.createElement('span');
                notification.className = 'wishlist-notification';
                notification.textContent = count;
                wishlistButton.parentElement.appendChild(notification);
            }
        }
        
        document.addEventListener('DOMContentLoaded', function () {

            const wishlistItemCount = <%= wishlistItemCount %>;
            updateWishlistNotification(wishlistItemCount);
        });
        
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
