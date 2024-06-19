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
 * Servlet implementation class DeleteCartServlet
 */
@WebServlet("/DeleteCartServlet")
public class DeleteCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCartServlet() {
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
	 private static final String STATUS_FAILURE = "failure";
	    private static final String PARAM_CART_ID = "cart_id";

	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        String cartIdStr = request.getParameter(PARAM_CART_ID);

	        if (cartIdStr == null) {
	            response.getWriter().write(STATUS_FAILURE);
	            return;
	        }

	        try {
	            int cartId = Integer.parseInt(cartIdStr);
	            boolean deletionSuccess = deleteCart(cartId);

	            if (deletionSuccess) {
	                response.getWriter().write("success");
	            } else {
	                response.getWriter().write(STATUS_FAILURE);
	            }

	        } catch (NumberFormatException | SQLException e) {
	            e.printStackTrace();
	            response.getWriter().write(STATUS_FAILURE);
	        }
	    }

	    private boolean deleteCart(int cartId) throws SQLException {
	        String deleteQuery = "DELETE FROM Cart WHERE cart_id = ?";
	        try (Connection conn = Connectivity.getConnection();
	             PreparedStatement stmt = conn.prepareStatement(deleteQuery)) {
	            
	            stmt.setInt(1, cartId);
	            int rowsDeleted = stmt.executeUpdate();
	            return rowsDeleted > 0;
	        }
	    }
}
