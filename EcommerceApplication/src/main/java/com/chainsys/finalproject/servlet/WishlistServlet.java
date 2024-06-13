package com.chainsys.finalproject.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chainsys.finalproject.model.User;
import com.chainsys.finalproject.util.Connectivity;

/**
 * Servlet implementation class WishlistServlet
 */
@WebServlet("/WishlistServlet")
public class WishlistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WishlistServlet() {
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
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        HttpSession session = request.getSession(false);
	        User currentUser = (User) session.getAttribute("user");

	        if (currentUser == null) {
	            response.sendRedirect("LoginForm.jsp");
	            return;
	        }

	        int userId = currentUser.getUserId();
	        int productId = Integer.parseInt(request.getParameter("productId"));
	        String productName = null;
	        byte[] productImage = null;

	        try (Connection conn = Connectivity.getConnection()) {
	            // Retrieve product details
	            String productQuery = "SELECT product_name, product_image FROM products WHERE product_id = ?";
	            try (PreparedStatement productStmt = conn.prepareStatement(productQuery)) {
	                productStmt.setInt(1, productId);
	                try (ResultSet productRs = productStmt.executeQuery()) {
	                    if (productRs.next()) {
	                        productName = productRs.getString("product_name");
	                        productImage = productRs.getBytes("product_image");
	                    }
	                }
	            }

	            // Check if the product is already in the wishlist for the user
	            String checkWishlistQuery = "SELECT * FROM wishlist WHERE user_id = ? AND product_id = ?";
	            boolean productExistsInWishlist = false;
	            try (PreparedStatement checkWishlistStmt = conn.prepareStatement(checkWishlistQuery)) {
	                checkWishlistStmt.setInt(1, userId);
	                checkWishlistStmt.setInt(2, productId);
	                try (ResultSet checkWishlistRs = checkWishlistStmt.executeQuery()) {
	                    if (checkWishlistRs.next()) {
	                        productExistsInWishlist = true;
	                    }
	                }
	            }

	            if (!productExistsInWishlist) {
	                // Product does not exist in wishlist, insert new row
	                String insertWishlistQuery = "INSERT INTO wishlist (user_id, product_id, product_name, product_image) VALUES (?, ?, ?, ?)";
	                try (PreparedStatement insertWishlistStmt = conn.prepareStatement(insertWishlistQuery)) {
	                    insertWishlistStmt.setInt(1, userId);
	                    insertWishlistStmt.setInt(2, productId);
	                    insertWishlistStmt.setString(3, productName);
	                    insertWishlistStmt.setBytes(4, productImage);
	                    insertWishlistStmt.executeUpdate();
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	            response.sendRedirect("error.jsp");
	            return;
	        }

	        // Redirect to wishlist page or display success message
	        response.sendRedirect("ViewProduct.jsp");
	    }

}
