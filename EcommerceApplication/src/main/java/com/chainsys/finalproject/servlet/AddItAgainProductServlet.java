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
 * Servlet implementation class AddItAgainProductServlet
 */
@WebServlet("/AddItAgainProductServlet")
public class AddItAgainProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddItAgainProductServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));

        String sql = "UPDATE Products SET is_deleted = '0' WHERE product_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = Connectivity.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            int rowsDeleted = stmt.executeUpdate();

            if (rowsDeleted > 0) {
                response.sendRedirect("SellerViewProducts.jsp?status=added");
            } else {
                response.sendRedirect("SellerViewProducts.jsp?status=failed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("SellerViewProducts.jsp?status=failed");
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
