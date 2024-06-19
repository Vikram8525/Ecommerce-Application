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

    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	private static final String FAILURE_MESSAGE = "failure";
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cartIdStr = request.getParameter("cart_id");

        if (cartIdStr == null) {
            response.getWriter().write(FAILURE_MESSAGE);
            return;
        }

        try {
            int cartId = Integer.parseInt(cartIdStr);
            boolean deletionSuccess = deleteCart(cartId);

            if (deletionSuccess) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write(FAILURE_MESSAGE);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().write(FAILURE_MESSAGE);
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write(FAILURE_MESSAGE);
        }
    }

    private boolean deleteCart(int cartId) throws SQLException {
        try (Connection conn = Connectivity.getConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM Cart WHERE cart_id = ?")) {
            stmt.setInt(1, cartId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        }
    }


}
