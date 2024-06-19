package com.chainsys.finalproject.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chainsys.finalproject.dao.UserDAO;
import com.chainsys.finalproject.model.User;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
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
        User user = new User();
        user.setUserId(Integer.parseInt(request.getParameter("user_id")));
        user.setUserName(request.getParameter("user_name"));
        user.setUserEmail(request.getParameter("user_email"));
        user.setPassword(request.getParameter("password"));

        UserDAO userDao = new UserDAO();
        try {
            if (userDao.isUserExists(user.getUserEmail(), user.getUserId())) {
                response.sendRedirect("RegistrationForm.jsp?registration=user_exists");
            } else {
                boolean isRegistered = userDao.addUser(user);
                if (isRegistered) {
                    response.sendRedirect("IdMailServlet?user_id=" + user.getUserId() + "&registration=success");
                } else {
                    response.sendRedirect("RegistrationForm.jsp?registration=failure");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Database error: " + e.getMessage());
        }
    }
}
