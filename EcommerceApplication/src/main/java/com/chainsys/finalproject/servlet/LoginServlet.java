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

	    String userIdStr = request.getParameter("userId");
	    String password = request.getParameter("password");

	    if (userIdStr != null && !userIdStr.isEmpty() && password != null && !password.isEmpty()) {
	        try {
	            int userId = Integer.parseInt(userIdStr);
	            UserDAO userDAO = new UserDAO();
	            User user = userDAO.getUserByIdAndPassword(userId, password);
	            if (user != null) {
	                HttpSession session = request.getSession();
	                session.setAttribute("user", user);

	                // Redirect to the originally requested URL
	                String redirectUrl = (String) session.getAttribute("redirectUrl");
	                if (redirectUrl != null) {
	                    session.removeAttribute("redirectUrl");
	                    response.sendRedirect(redirectUrl);
	                } else {
	                    response.sendRedirect("home.jsp");
	                }
	            } else {
	                response.sendRedirect("LoginForm.jsp?status=failed");
	            }
	        } catch (NumberFormatException | SQLException e) {
	            e.printStackTrace();
	            response.sendRedirect("LoginForm.jsp?status=error");
	        }
	    } else {
	        response.sendRedirect("LoginForm.jsp?status=failed");
	    }
	}

}
