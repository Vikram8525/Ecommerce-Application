<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Base64, java.sql.*, java.io.*, java.util.*, com.chainsys.finalproject.util.Connectivity, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Product Details</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        .container {
            margin-top: 20px;
        }
        .carousel-inner img {
            max-width: 100%;
            height: 550px;
            object-fit: cover;
        }
        .best-seller {
            background-color: gold;
            color: black;
            padding: 5px;
            font-weight: bold;
            display: inline-block;
            margin-top: 10px;
        }
        .availability {
            font-size: 18px;
            margin-top: 10px;
        }
        .availability.in-stock {
            color: green;
        }
        .availability.limited-stock {
            color: yellow;
        }
        .availability.out-of-stock {
            color: red;
        }
        .button-group button {
            width: 600px;
            margin-right: 30px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="4" aria-label="Slide 5"></button>
                    </div>
                    <div class="carousel-inner">
                        <%
                            int productId = Integer.parseInt(request.getParameter("productId"));
                            Connection conn = null;
                            List<String> imageBase64List = new ArrayList<>();
                            String productName = "";
                            String productDescription = "";
                            double productPrice = 0;
                            int productQuantity = 0;
                            int userId = 0;
                            String sellerName = "";
                            String sellerState = "";
                            String sellerCity = "";
                            boolean isBestSeller = false;

                            try {
                                conn = Connectivity.getConnection();
                                Statement stmt = conn.createStatement();

                                // Get product details
                                ResultSet rsProduct = stmt.executeQuery("SELECT * FROM Products WHERE product_id = " + productId + " AND is_deleted = 0");
                                if (rsProduct.next()) {
                                    productName = rsProduct.getString("product_name");
                                    productDescription = rsProduct.getString("product_description");
                                    productPrice = rsProduct.getDouble("product_price");
                                    productQuantity = rsProduct.getInt("product_quantity");
                                    userId = rsProduct.getInt("user_id");

                                    // Collect all product images
                                    for (String column : Arrays.asList("product_image", "sample_image", "left_image", "right_image", "bottom_image")) {
                                        Blob blob = rsProduct.getBlob(column);
                                        if (blob != null) {
                                            byte[] imageBytes = blob.getBytes(1, (int) blob.length());
                                            String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                                            imageBase64List.add(base64Image);
                                        }
                                    }
                                }

                                // Get seller details
                                ResultSet rsSeller = stmt.executeQuery("SELECT * FROM Users WHERE user_id = " + userId);
                                if (rsSeller.next()) {
                                    sellerName = rsSeller.getString("user_name");
                                    sellerState = rsSeller.getString("state");
                                    sellerCity = rsSeller.getString("city");
                                }

                                // Check if the user has the maximum num_items_sold
                                ResultSet rsMaxItemsSold = stmt.executeQuery("SELECT MAX(num_items_sold) AS max_sold FROM Users");
                                if (rsMaxItemsSold.next()) {
                                    int maxItemsSold = rsMaxItemsSold.getInt("max_sold");

                                    ResultSet rsUserItemsSold = stmt.executeQuery("SELECT num_items_sold FROM Users WHERE user_id = " + userId);
                                    if (rsUserItemsSold.next()) {
                                        int userItemsSold = rsUserItemsSold.getInt("num_items_sold");
                                        if (userItemsSold == maxItemsSold) {
                                            isBestSeller = true;
                                        }
                                    }
                                }

                            } catch (SQLException ex) {
                                ex.printStackTrace();
                            } finally {
                                if (conn != null) {
                                    try {
                                        conn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }

                            for (int i = 0; i < imageBase64List.size(); i++) {
                                String base64Image = imageBase64List.get(i);
                        %>
                                <div class="carousel-item <%= i == 0 ? "active" : "" %>">
                                    <img src="data:image/jpeg;base64,<%= base64Image %>" class="d-block w-100" alt="Product <%= i + 1 %>">
                                </div>
                        <%
                            }
                        %>
                    </div>
                    
                </div>
            </div>
            <div class="col-md-6">
                <h2><%= productName %></h2>
                <p><%= productDescription %></p>
                <h3>Rs. <%= productPrice %></h3>
                <%
                    SimpleDateFormat sdf = new SimpleDateFormat("MMMM dd, yyyy");
                    Calendar cal = Calendar.getInstance();
                    cal.add(Calendar.DAY_OF_MONTH, 7);
                    String deliveryDate = sdf.format(cal.getTime());
                %>
                <p>Delivered to your address by <%= deliveryDate %></p>
                <% if (isBestSeller) { %>
                    <div class="best-seller">Best Seller</div>
                <% } %>
                <p>Seller: <%= sellerName %></p>
                <p>State: <%= sellerState %></p>
                <p>City: <%= sellerCity %></p>
                <div class="availability <%= productQuantity > 10 ? "in-stock" : (productQuantity > 0 ? "limited-stock" : "out-of-stock") %>">
                    <%= productQuantity > 10 ? "Stock available in store" : (productQuantity > 0 ? "Final few stocks" : "Out of stock") %>
                </div>
                <div class="button-group">
                    <form action="CartServlet" method="POST" style="display:inline;">
                        <input type="hidden" name="productId" value="<%= productId %>">
                        <input type="hidden" name="action" value="addToCart">
                        <button type="submit" class="btn btn-success">Add to Cart</button>
                    </form>
                    <form action="AddToCart.jsp" method="POST" style="display:inline;">
                        <input type="hidden" name="productId" value="<%= productId %>">
                        <input type="hidden" name="action" value="wishlist">
                        <button type="submit" class="btn btn-primary">Add to Wishlist</i></button>
                    </form>
                    <form action="AddToCart.jsp" method="POST" style="display:inline;">
                        <input type="hidden" name="productId" value="<%= productId %>">
                        <input type="hidden" name="action" value="buyNow">
                        <button type="submit" class="btn btn-danger">Buy Now</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
