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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = new User();
        user.setUserId(Integer.parseInt(request.getParameter("user_id")));
        user.setUserName(request.getParameter("user_name"));
        user.setUserEmail(request.getParameter("user_email"));

        UserDAO userDao = new UserDAO();
        boolean isEmailSent = userDao.sendWelcomeEmail(user);
        if (isEmailSent) {
            response.sendRedirect("home.jsp?registration=success");
        } else {
            handleEmailError(response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void handleEmailError(HttpServletResponse response) throws IOException {
        String errorMessage = "Error sending welcome email!";
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<script type=\"text/javascript\">");
        out.println("alert('" + errorMessage + "');");
        out.println("window.location.href='Home.jsp';");
        out.println("</script>");
    }
}
