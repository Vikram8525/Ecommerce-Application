<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, java.io.*, com.chainsys.finalproject.util.Connectivity"%>
<%@ page import="com.chainsys.finalproject.model.User, com.chainsys.finalproject.model.Product"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            padding-top: 70px;
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
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
        .checkout-image {
            flex: 1;
            background-image: url('background.jpg');
            background-size: cover;
            background-position: center;
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
        .payment-method {
            font-size: 24px; /* Larger font size */
            color: #800080; /* Purple color */
            font-weight: bold; /* Bold text */
            margin-top: 20px;
        }
        .change-payment-btn {
            margin-top: 10px;
        }
    </style>
    <script type="text/javascript">
        function validateForm() {
            var userId = document.forms["orderForm"]["userId"].value;
            if (userId == null || userId == "") {
                alert("User ID is missing.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container-fluid">
            <form action="home.jsp" method="POST">
                <button class="btn-home" type="submit" name="home">
                    <i class="fa fa-home"></i>
                </button>
            </form>
            <form action="ViewProduct.jsp" method="GET">
                <button type="submit" class="btn btn-outline-secondary">View All Products</button>
            </form>
        </div>
    </nav>

    <div class="checkout-container">
        <div class="checkout-details">
            <h1>Order Details</h1>
            <%
            String paymentMethod = request.getParameter("paymentMethod");
            if (paymentMethod != null && !paymentMethod.isEmpty()) {
            %>
            <h1 class="payment-method">
                Payment Method: <%=paymentMethod%>
            </h1>
            <%
            }
            %>

            <%
            String userIdStr = request.getParameter("userId");
            if (userIdStr == null || userIdStr.isEmpty()) {
                out.println("<p style='color: red;'>User ID is missing.</p>");
                return;
            }

            int userId;
            try {
                userId = Integer.parseInt(userIdStr);
            } catch (NumberFormatException e) {
                out.println("<p style='color: red;'>Invalid User ID.</p>");
                return;
            }

            List<Map<String, Object>> cartItems = new ArrayList<>();
            double totalAmount = 0;

            try (Connection conn = Connectivity.getConnection()) {
                PreparedStatement stmt = conn.prepareStatement(
                    "SELECT c.*, p.product_name, p.category_name, p.product_price, p.product_quantity, u.user_name " +
                    "FROM Cart c " +
                    "JOIN Products p ON c.product_id = p.product_id " +
                    "JOIN Users u ON p.user_id = u.user_id " +
                    "WHERE c.user_id = ? AND c.is_bought = 0"
                );
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    Map<String, Object> item = new HashMap<>();
                    item.put("product_name", rs.getString("product_name"));
                    item.put("product_category", rs.getString("category_name"));
                    item.put("product_price", rs.getDouble("product_price"));
                    item.put("quantity", rs.getInt("quantity"));
                    item.put("seller_name", rs.getString("user_name"));
                    item.put("total_price", rs.getDouble("product_price") * rs.getInt("quantity"));
                    cartItems.add(item);

                    totalAmount += rs.getDouble("product_price") * rs.getInt("quantity");
                }

                // Fetch delivery address
                PreparedStatement addrStmt = conn.prepareStatement(
                    "SELECT state, city, address, pincode FROM Users WHERE user_id = ?"
                );
                addrStmt.setInt(1, userId);
                ResultSet addrRs = addrStmt.executeQuery();

                if (addrRs.next()) {
                    String state = addrRs.getString("state");
                    String city = addrRs.getString("city");
                    String address = addrRs.getString("address");
                    String pincode = addrRs.getString("pincode");
            %>
            <form action="Payment.jsp" method="GET" class="change-payment-btn">
                <input type="hidden" name="userId" value="<%=userId%>">
                <button type="submit" class="btn btn-outline-success">Change Payment Method</button>
            </form>
            <h3>Delivery Address</h3>
            <p>State: <%=state%></p>
            <p>City: <%=city%></p>
            <p>Address: <%=address%></p>
            <p>Pincode: <%=pincode%></p>
            <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p style='color: red;'>Database error occurred.</p>");
            }

            if (!cartItems.isEmpty()) {
                int productIndex = 1;
                for (Map<String, Object> item : cartItems) {
            %>
            <div class="product-details">
                <h4>Product <%=productIndex++%></h4>
                <p>Product Name: <%=item.get("product_name")%></p>
                <p>Product Price: Rs.<%=item.get("product_price")%></p>
                <p>Product Category: <%=item.get("product_category")%></p>
                <p>Seller: <%=item.get("seller_name")%></p>
                <p>Quantity in Cart: <%=item.get("quantity")%></p>
                <p>Total Price of this Product: Rs.<%=item.get("total_price")%></p>
            </div>
            <%
                }
            %>

            <h3>Cart Total: Rs.<%=totalAmount%></h3>
            <form name="orderForm" action="CartBuyNowServlet" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="userId" value="<%=userId%>">
                <input type="hidden" name="paymentMethod" value="<%=paymentMethod%>">
                <button type="submit" class="btn-buy">Buy Now</button>
            </form>
            <%
            } else {
            %>
            <p>Your cart is empty.</p>
            <%
            }
            %>
        </div>
        <div class="checkout-image"></div>
    </div>
	
	<% if ("failed".equals(request.getAttribute("status"))) { %>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: '<%= request.getAttribute("message") %>',
            });
        });
    </script>
<% } %>

	
	
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-d1JcZm8dASb0mPv0RNFRpK0q8/6BJBmQKZNOs1/DYad66OpKefjUlCok2VdHbYD6" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
