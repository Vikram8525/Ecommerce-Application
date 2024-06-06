package com.chainsys.finalproject.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chainsys.finalproject.dao.UserDAO;
import com.chainsys.finalproject.model.User;

/**
 * Servlet implementation class IdMailServlet
 */
@WebServlet("/IdMailServlet")
public class IdMailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IdMailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve user details from the database
        User user = new User();
        user.setUserId(Integer.parseInt(request.getParameter("user_id"))); // Ensure user_id is properly retrieved
        user.setUserName(request.getParameter("user_name")); // Adjust based on your implementation
        user.setUserEmail(request.getParameter("user_email")); // Adjust based on your implementation

        UserDAO userDao = new UserDAO();
        boolean isEmailSent = userDao.sendWelcomeEmail(user);
        if (isEmailSent) {
            response.sendRedirect("home.jsp");
        } else {
            String errorMessage = "Error sending welcome email!";
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('" + errorMessage + "');");
            out.println("window.location.href='home.jsp';");
            out.println("</script>");
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
