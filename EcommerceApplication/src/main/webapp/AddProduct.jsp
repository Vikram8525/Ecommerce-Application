<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
        }
        .form-group input[type="file"] {
            padding: 3px;
        }
        .form-group textarea {
            resize: vertical;
        }
        .form-group button {
            padding: 10px 20px;
            background: #5cb85c;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        .form-group button:hover {
            background: #4cae4c;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Add Product</h1>
    <form action="AddProductServlet" method="post" enctype="multipart/form-data">
        
        <div class="form-group">
            <label for="user_id">User ID</label>
            <input type="number" id="user_id" name="user_id" required>
        </div>
        <div class="form-group">
            <label for="seller_name">Seller Name</label>
            <input type="text" id="seller_name" name="seller_name" required>
        </div>
        <div class="form-group">
            <label for="category_name">Category Name</label>
            <select id="category_name" name="category_name" required>
                <option value="watch">Watch</option>
                <option value="shoes">Shoes</option>
                <option value="anime_action_figures">Anime Action Figures</option>
                <option value="mobile_phone">Mobile Phone</option>
                <option value="headset">Headset</option>
            </select>
        </div>
        <div class="form-group">
            <label for="product_name">Product Name</label>
            <input type="text" id="product_name" name="product_name" required>
        </div>
        <div class="form-group">
            <label for="product_image">Product Image</label>
            <input type="file" id="product_image" name="product_image" required>
        </div>
        <div class="form-group">
            <label for="sample_image">Sample Image</label>
            <input type="file" id="sample_image" name="sample_image" required>
        </div>
        <div class="form-group">
            <label for="left_image">Left Image</label>
            <input type="file" id="left_image" name="left_image" required>
        </div>
        <div class="form-group">
            <label for="right_image">Right Image</label>
            <input type="file" id="right_image" name="right_image" required>
        </div>
        <div class="form-group">
            <label for="bottom_image">Bottom Image</label>
            <input type="file" id="bottom_image" name="bottom_image" required>
        </div>
        <div class="form-group">
            <label for="product_price">Product Price</label>
            <input type="number" step="0.01" id="product_price" name="product_price" required>
        </div>
        <div class="form-group">
            <label for="product_description">Product Description</label>
            <textarea id="product_description" name="product_description" required></textarea>
        </div>
        <div class="form-group">
            <label for="product_quantity">Product Quantity</label>
            <input type="number" id="product_quantity" name="product_quantity" required>
        </div>
        <div class="form-group">
            <button type="submit">Add Product</button>
        </div>
    </form>
</div>

</body>
</html>