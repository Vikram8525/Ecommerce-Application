package com.chainsys.finalproject.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chainsys.finalproject.dao.UserDAO;
import com.chainsys.finalproject.model.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
	        
	        String userIdStr = request.getParameter("userId");
	        String password = request.getParameter("password");
	        
	        if (userIdStr != null && !userIdStr.isEmpty() && password != null && !password.isEmpty()) {
	            try {
	                int userId = Integer.parseInt(userIdStr);
	                UserDAO userDAO = new UserDAO();
	                User user = userDAO.getUserByIdAndPassword(userId, password);
	                if (user != null) {
	                    // User authenticated, redirect to home page
	                    HttpSession session = request.getSession();
	                    session.setAttribute("user", user);
	                    response.sendRedirect("home.jsp");
	                } else {
	                    // Show login failed notification using SweetAlert
	                    response.sendRedirect("LoginForm.jsp?status=failed");
	                }
	            } catch (NumberFormatException e) {
	                // userIdStr is not a valid integer
	                response.sendRedirect("LoginForm.jsp?status=failed");
	            } catch (SQLException ex) {
	                ex.printStackTrace();
	                response.sendRedirect("LoginForm.jsp?status=error");
	            }
	        } else {
	            response.sendRedirect("LoginForm.jsp?status=failed");
	        }
	    }
}
