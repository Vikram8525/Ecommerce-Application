package com.chainsys.finalproject.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chainsys.finalproject.util.Connectivity;

/**
 * Servlet implementation class SellerLoginServlet
 */
@WebServlet("/SellerLoginServlet")
public class SellerLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SellerLoginServlet() {
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
	        response.setContentType("text/html");
	        PrintWriter out = response.getWriter();

	        String userId = request.getParameter("userId");
	        String password = request.getParameter("password");

	        try (Connection conn = Connectivity.getConnection()) {
	            String selectQuery = "SELECT * FROM users WHERE user_id = ? AND password = ?";
	            PreparedStatement ps = conn.prepareStatement(selectQuery);
	            ps.setString(1, userId);
	            ps.setString(2, password);
	            ResultSet rs = ps.executeQuery();

	            if (rs.next()) {
	                int isSeller = rs.getInt("is_seller");
	                if (isSeller == 1) {
	                    out.println("<script type=\"text/javascript\">");
	                    out.println("window.location='home.jsp?status=success';");
	                    out.println("</script>");
	                } else {
	                    String updateQuery = "UPDATE users SET is_seller = 1 WHERE user_id = ?";
	                    PreparedStatement updatePs = conn.prepareStatement(updateQuery);
	                    updatePs.setString(1, userId);
	                    updatePs.executeUpdate();

	                    out.println("<script type=\"text/javascript\">");
	                    out.println("window.location='home.jsp?status=success';");
	                    out.println("</script>");
	                }
	            } else {
	                out.println("<script type=\"text/javascript\">");
	                out.println("window.location='SellerLogin.jsp?status=failed';");
	                out.println("</script>");
	            }
	        } catch (SQLException e) {
	            out.println("<script type=\"text/javascript\">");
	            out.println("window.location='SellerLogin.jsp?status=error';");
	            out.println("</script>");
	            e.printStackTrace();
	        }
	    }

}
