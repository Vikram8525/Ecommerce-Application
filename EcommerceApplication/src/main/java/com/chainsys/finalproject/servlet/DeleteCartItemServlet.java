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
 * Servlet implementation class DeleteCartItemServlet
 */
@WebServlet("/DeleteCartItemServlet")
public class DeleteCartItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCartItemServlet() {
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
	        String cartIdStr = request.getParameter("cart_id");

	        if (cartIdStr == null) {
	            response.getWriter().write("failure");
	            return;
	        }

	        try {
	            int cartId = Integer.parseInt(cartIdStr);

	            try (Connection conn = Connectivity.getConnection()) {
	                PreparedStatement stmt = conn.prepareStatement("DELETE FROM Cart WHERE cart_id = ?");
	                stmt.setInt(1, cartId);
	                int rowsDeleted = stmt.executeUpdate();

	                if (rowsDeleted > 0) {
	                    response.getWriter().write("success");
	                } else {
	                    response.getWriter().write("failure");
	                }
	            } catch (SQLException e) {
	                e.printStackTrace();
	                response.getWriter().write("failure");
	            }
	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	            response.getWriter().write("failure");
	        }
	    }
}
