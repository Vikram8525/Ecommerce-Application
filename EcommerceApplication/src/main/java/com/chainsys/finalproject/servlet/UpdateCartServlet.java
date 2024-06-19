package com.chainsys.finalproject.servlet;

import java.io.IOException;
import java.io.PrintWriter;
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
 * Servlet implementation class UpdateCartServlet
 */
@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCartServlet() {
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
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        int cartId = Integer.parseInt(request.getParameter("cartId"));
        int newQuantity = Integer.parseInt(request.getParameter("newQuantity"));

        try (Connection conn = Connectivity.getConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE Cart SET quantity = ? WHERE cart_id = ?")) {

            stmt.setInt(1, newQuantity);
            stmt.setInt(2, cartId);
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                request.getSession().setAttribute("updateSuccess", true);
                out.write("success");
            } else {
                out.write("fail");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.write("fail");
        }
    }
}
