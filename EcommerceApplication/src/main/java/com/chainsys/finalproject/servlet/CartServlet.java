package com.chainsys.finalproject.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chainsys.finalproject.model.User;
import com.chainsys.finalproject.util.Connectivity;

/**
 * Servlet implementation class CartServlet
 */
@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	 protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        HttpSession session = request.getSession(false);
	        User currentUser = (User) session.getAttribute("user");

	        if (currentUser == null) {
	            // Redirect to login page if user is not logged in
	            response.sendRedirect("LoginForm.jsp");
	            return;
	        }

	        int userId = currentUser.getUserId();
	        int productId = Integer.parseInt(request.getParameter("productId"));
	        String productName = null;
	        byte[] productImage = null;
	        double productPrice = 0;

	        try (Connection conn = Connectivity.getConnection()) {
	            // Retrieve product details
	            String productQuery = "SELECT product_name, product_image, product_price FROM products WHERE product_id = ?";
	            try (PreparedStatement productStmt = conn.prepareStatement(productQuery)) {
	                productStmt.setInt(1, productId);
	                try (ResultSet productRs = productStmt.executeQuery()) {
	                    if (productRs.next()) {
	                        productName = productRs.getString("product_name");
	                        productImage = productRs.getBytes("product_image");
	                        productPrice = productRs.getDouble("product_price");
	                    }
	                }
	            }

	            // Check if the product is already in the cart for the user
	            String checkCartQuery = "SELECT * FROM cart WHERE user_id = ? AND product_id = ? AND is_bought = 0";
	            boolean productExistsInCart = false;
	            int currentQuantity = 0;
	            try (PreparedStatement checkCartStmt = conn.prepareStatement(checkCartQuery)) {
	                checkCartStmt.setInt(1, userId);
	                checkCartStmt.setInt(2, productId);
	                try (ResultSet checkCartRs = checkCartStmt.executeQuery()) {
	                    if (checkCartRs.next()) {
	                        productExistsInCart = true;
	                        currentQuantity = checkCartRs.getInt("quantity");
	                    }
	                }
	            }

	            // Calculate total price (assuming quantity is 1 for simplicity)
	            double totalPrice = productPrice;

	            if (productExistsInCart) {
	                // Product already exists in cart, update quantity
	                int newQuantity = currentQuantity + 1;
	                String updateCartQuery = "UPDATE cart SET quantity = ?, total_price = ? WHERE user_id = ? AND product_id = ?";
	                try (PreparedStatement updateCartStmt = conn.prepareStatement(updateCartQuery)) {
	                    updateCartStmt.setInt(1, newQuantity);
	                    updateCartStmt.setDouble(2, totalPrice * newQuantity);
	                    updateCartStmt.setInt(3, userId);
	                    updateCartStmt.setInt(4, productId);
	                    updateCartStmt.executeUpdate();
	                }
	            } else {
	                // Product does not exist in cart, insert new row
	                String insertCartQuery = "INSERT INTO cart (user_id, product_id, product_name, product_image, quantity, date_added, total_price) VALUES (?, ?, ?, ?, ?, ?, ?)";
	                try (PreparedStatement insertCartStmt = conn.prepareStatement(insertCartQuery)) {
	                    insertCartStmt.setInt(1, userId);
	                    insertCartStmt.setInt(2, productId);
	                    insertCartStmt.setString(3, productName);
	                    insertCartStmt.setBytes(4, productImage);
	                    insertCartStmt.setInt(5, 1); // Quantity is 1
	                    insertCartStmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
	                    insertCartStmt.setDouble(7, totalPrice);
	                    insertCartStmt.executeUpdate();
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	            response.sendRedirect("error.jsp");
	            return;
	        }

	        // Redirect to cart page or display success message
	        response.sendRedirect("ViewProduct.jsp");
	    }

}
