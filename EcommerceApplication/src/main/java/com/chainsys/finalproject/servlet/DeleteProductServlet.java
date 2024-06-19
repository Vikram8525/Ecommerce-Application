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
 * Servlet implementation class DeleteProductServlet
 */
@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteProductServlet() {
        super();

    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    int productId = Integer.parseInt(request.getParameter("productId"));

	    try (Connection conn = Connectivity.getConnection();
	         PreparedStatement stmt = conn.prepareStatement("UPDATE Products SET is_deleted = '1' WHERE product_id = ?")) {
	        
	        stmt.setInt(1, productId);
	        int rowsDeleted = stmt.executeUpdate();
	        
	        if (rowsDeleted > 0) {
	            response.sendRedirect("SellerViewProducts.jsp?status=deleted");
	        } else {
	            response.sendRedirect("SellerViewProducts.jsp?status=failed");
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        response.sendRedirect("SellerViewProducts.jsp?status=failed");
	    }
	}

}
