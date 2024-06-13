<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, java.io.*, com.chainsys.finalproject.util.Connectivity"%>
<%@ page import="com.chainsys.finalproject.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller View Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style>
        body {
            padding-top: 70px;
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
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
            width: 400px;
        }

        .offcanvas-body {
            padding: 15px;
        }

        .btn-outline-success {
            color: #f1f1f1;
            border-color: #febd69;
        }

        .btn-outline-success:hover {
            background-color: #febd69;
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

        .search-bar {
            width: 50%;
            margin: auto;
        }

        .card {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            max-width: 300px;
            margin: 20px;
            text-align: center;
            font-family: arial;
            float: left;
            cursor: pointer;
            transition: transform 0.2s;
            position: relative;
        }

        .card img {
            max-width: 100%;
            height: 300px;
            object-fit: cover;
        }

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .price {
            color: grey;
            font-size: 22px;
        }

        .card button {
            border: none;
            outline: 0;
            padding: 12px;
            color: white;
            text-align: center;
            cursor: pointer;
            width: 100%;
            font-size: 18px;
        }

        .card .add-to-cart {
            background-color: #000;
        }

        .card .add-to-wishlist {
            background-color: #f44336;
        }

        .card button:hover {
            opacity: 0.7;
        }

        .best-seller {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: gold;
            color: black;
            padding: 5px;
            font-weight: bold;
        }

        #noProductsFoundMessage {
            display: none;
            color: red;
            font-weight: bold;
            text-align: center;
            margin-top: 20px;
        }

        .nav-icons {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-icons form {
            display: inline-block;
            margin: 0;
        }

        .nav-icons .btn {
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
            background-color: #232F3E;
            color: #ffffff;
            font-size: 20px;
            border-radius: 5px;
            padding: 8px 12px;
        }

        .nav-icons .btn:hover {
            background-color: #febd69;
            color: #232F3E;
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
        
        <form action="ViewProduct.jsp" method="GET">
        <button type="submit" class="btn btn-outline-secondary">Back to Products</button>
    </form>
    </div>

    
</nav>

<div class="container mt-5">
    <h1 class="mt-4">Your Products</h1>
    <%
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            String requestURI = request.getRequestURI() + "?" + request.getQueryString();
            session.setAttribute("redirectUrl", requestURI);
            response.sendRedirect("LoginForm.jsp");
            return;
        }

        String status = request.getParameter("status");
        int userId = currentUser.getUserId();
        List<Map<String, Object>> products = new ArrayList<>();

        try (Connection conn = Connectivity.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Products WHERE user_id = ? and is_deleted ='0'");
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> product = new HashMap<>();
                product.put("product_id", rs.getInt("product_id"));
                product.put("product_name", rs.getString("product_name"));
                product.put("product_price", rs.getDouble("product_price"));
                product.put("product_quantity", rs.getInt("product_quantity"));
                Blob blob = rs.getBlob("product_image");
                byte[] imageBytes = blob.getBytes(1, (int) blob.length());
                String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                product.put("product_image", base64Image);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
    <% if (products.isEmpty()) { %>
        <p>You have no products listed.</p>
    <% } else { %>
        <div class="row">
            <% for (Map<String, Object> product : products) { %>
                <div class="col-md-4 mb-3">
                    <div class="card">
                        <img src="data:image/jpeg;base64,<%= product.get("product_image") %>" class="card-img-top" alt="Product Image">
                        <div class="card-body">
                            <h5 class="card-title"><%= product.get("product_name") %></h5>
                            <p class="card-text">Price: Rs.<%= product.get("product_price") %></p>
                            <p class="card-text">Available Quantity: <%= product.get("product_quantity") %></p>
                            <form action="UpdatePriceServlet" method="POST">
                                <div class="input-group mb-3">
                                    <input type="number" class="form-control" name="newPrice" value="<%= product.get("product_price") %>" step="100">
                                    <input type="hidden" name="productId" value="<%= product.get("product_id") %>">
                                    <button class="btn btn-primary" type="submit" name="updatePrice">Update Price</button>
                                </div>
                            </form>
                            <form action="UpdateProductServlet" method="POST">
                                <div class="input-group mb-3">
                                    <input type="number" class="form-control" name="newQuantity" value="<%= product.get("product_quantity") %>" min="1">
                                    <input type="hidden" name="productId" value="<%= product.get("product_id") %>">
                                    <button class="btn btn-success" type="submit" name="updateProduct">Add Stock</button>
                                </div>
                            </form>
                            <form action="DeleteProductServlet" method="POST">
                                <input type="hidden" name="productId" value="<%= product.get("product_id") %>">
                                <button class="btn btn-danger" type="submit" name="deleteProduct">Delete Product</button>
                            </form>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    <% } %>
    <div class="mt-4">
        <form action="AddProduct.jsp" method="GET">
            <button type="submit" class="btn btn-primary">Add New Product</button>
        </form>
    </div>
    <div class="mt-4">
    <form action="SellerDeletedProduct.jsp">
            <button type="submit" class="btn btn-primary">Add Deleted Product again</button>
        </form>
        </div>
</div>

<script src="vendor/jquery/jquery.min.js"></script>
<script src="js/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<% if ("success".equals(status)) { %>
    <script type="text/javascript">
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: 'Product Updated successfully!'
        });
    </script>
<% } else if ("deleted".equals(status)) { %>
    <script type="text/javascript">
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: 'Product deleted successfully!'
        });
    </script>
<% } else if ("added".equals(status)) { %>
    <script type="text/javascript">
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: 'Product Added Again Successfully!'
        });
    </script>
<% } else if ("failed".equals(status)) { %>
    <script type="text/javascript">
        Swal.fire({
            icon: 'error',
            title: 'Failed!',
            text: 'An error occurred!'
        });
    </script>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz4fnFO9gybBogGz7RHEUks7R3GSIb4H1rQ1g1rVu0Z43VJykHa8QlqdAI"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
        integrity="sha384-ho+j7jyWK8fNQe+a1iZ7tka9A8wDL01eJ4ZgYvZQWmT5rG8XDhFPpKT6nf7KxwXK"
        crossorigin="anonymous"></script>
</body>
</html>
