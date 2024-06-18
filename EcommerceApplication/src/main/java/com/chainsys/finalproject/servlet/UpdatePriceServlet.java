package com.chainsys.finalproject.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chainsys.finalproject.util.Connectivity;

/**
 * Servlet implementation class UpdatePriceServlet
 */
@WebServlet("/UpdatePriceServlet")
public class UpdatePriceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdatePriceServlet() {
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
	        int productId = Integer.parseInt(request.getParameter("productId"));
	        double newPrice = Double.parseDouble(request.getParameter("newPrice"));

	        // Perform the database update operation here

	        try (Connection conn = Connectivity.getConnection()) {
	            String sql = "UPDATE Products SET product_price = ? WHERE product_id = ?";
	            PreparedStatement stmt = conn.prepareStatement(sql);
	            stmt.setDouble(1, newPrice);
	            stmt.setInt(2, productId);
	            int rowsUpdated = stmt.executeUpdate();
	            if (rowsUpdated > 0) {
	                response.sendRedirect("SellerViewProducts.jsp?status=success");
	            } else {
	                response.sendRedirect("SellerViewProducts.jsp?status=failed");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	            response.sendRedirect("SellerViewProducts.jsp?status=failed");
	        }
	    }
}
