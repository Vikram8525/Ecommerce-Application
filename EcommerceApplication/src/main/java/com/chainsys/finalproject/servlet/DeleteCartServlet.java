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
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        int cartId = Integer.parseInt(request.getParameter("cartId"));

        try (Connection conn = Connectivity.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM Cart WHERE cart_id = ?");
            stmt.setInt(1, cartId);
            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                request.getSession().setAttribute("deleteSuccess", true);
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
