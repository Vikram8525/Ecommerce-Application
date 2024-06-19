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

    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	private static final String SCRIPT_START = "<script type=\"text/javascript\">";
    private static final String SCRIPT_END = "</script>";
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String userId = request.getParameter("userId");
        String password = request.getParameter("password");

        try (Connection conn = Connectivity.getConnection()) {
            String selectQuery = "SELECT * FROM users WHERE user_id = ? AND password = ?";
            try (PreparedStatement ps = conn.prepareStatement(selectQuery)) {
                ps.setString(1, userId);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        int isSeller = rs.getInt("is_seller");
                        if (isSeller == 1) {
                            out.println(SCRIPT_START);
                            out.println("window.location='home.jsp?status=success';");
                            out.println(SCRIPT_END);
                        } else {
                            String updateQuery = "UPDATE users SET is_seller = 1 WHERE user_id = ?";
                            try (PreparedStatement updatePs = conn.prepareStatement(updateQuery)) {
                                updatePs.setString(1, userId);
                                updatePs.executeUpdate();

                                out.println(SCRIPT_START);
                                out.println("window.location='home.jsp?status=success';");
                                out.println(SCRIPT_END);
                            }
                        }
                    } else {
                        out.println(SCRIPT_START);
                        out.println("window.location='SellerLogin.jsp?status=failed';");
                        out.println(SCRIPT_END);
                    }
                }
            }
        } catch (SQLException e) {
            out.println(SCRIPT_START);
            out.println("window.location='SellerLogin.jsp?status=error';");
            out.println(SCRIPT_END);
            e.printStackTrace();
        }
    }

}
