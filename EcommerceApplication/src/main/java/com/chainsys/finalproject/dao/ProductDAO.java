package com.chainsys.finalproject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.chainsys.finalproject.model.Product;
import com.chainsys.finalproject.util.Connectivity;

public class ProductDAO {
	
	public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (user_id, seller_name, category_name, product_name, product_image, sample_image, left_image, right_image, bottom_image, product_price, product_description, product_quantity) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = Connectivity.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, product.getUserId());
            statement.setString(2, product.getSellerName());
            statement.setString(3, product.getCategoryName());
            statement.setString(4, product.getProductName());
            statement.setBytes(5, product.getProductImage());
            statement.setBytes(6, product.getSampleImage());
            statement.setBytes(7, product.getLeftImage());
            statement.setBytes(8, product.getRightImage());
            statement.setBytes(9, product.getBottomImage());
            statement.setDouble(10, product.getProductPrice());
            statement.setString(11, product.getProductDescription());
            statement.setInt(12, product.getProductQuantity());
            

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
	
	
}
