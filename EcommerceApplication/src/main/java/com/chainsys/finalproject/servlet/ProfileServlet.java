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

import com.chainsys.finalproject.model.User;
import com.chainsys.finalproject.util.Connectivity;

/**
 * Servlet implementation class ProfileServlet
 */
@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileServlet() {
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
	        try {
	            // Get parameters from the form
	            int userId = Integer.parseInt(request.getParameter("user_id"));
	            String firstName = request.getParameter("first_name");
	            String lastName = request.getParameter("last_name");
	            String address = request.getParameter("address");
	            String state = request.getParameter("state");
	            String city = request.getParameter("city");
	            String pincode = request.getParameter("pincode");

	            // Create a new User object
	            User user = new User();
	            user.setUserId(userId);
	            user.setFirstName(firstName);
	            user.setLastName(lastName);
	            user.setAddress(address);
	            user.setState(state);
	            user.setCity(city);
	            user.setPincode(pincode);

	            // Update user in the database
	            boolean updateSuccess = updateUser(user);

	            // Set status and message attributes for the home page
	            if (updateSuccess) {
	                request.setAttribute("status", "success");
	                request.setAttribute("message", "Profile updated successfully!");
	            } else {
	                request.setAttribute("status", "error");
	                request.setAttribute("message", "Failed to update profile. Please try again later.");
	            }

	            // Forward to home page
	            request.getRequestDispatcher("home.jsp").forward(request, response);

	        } catch (Exception ex) {
	            ex.printStackTrace();
	            request.setAttribute("status", "error");
	            request.setAttribute("message", "An error occurred while updating profile.");
	            request.getRequestDispatcher("home.jsp").forward(request, response);
	        }
	    }

	    private boolean updateUser(User user) throws SQLException {
	        String sql = "UPDATE users SET first_name=?, last_name=?, address=?, state=?, city=?, pincode=? WHERE user_id=?";
	        try (Connection conn = Connectivity.getConnection();
	             PreparedStatement stmt = conn.prepareStatement(sql)) {

	            stmt.setString(1, user.getFirstName());
	            stmt.setString(2, user.getLastName());
	            stmt.setString(3, user.getAddress());
	            stmt.setString(4, user.getState());
	            stmt.setString(5, user.getCity());
	            stmt.setString(6, user.getPincode());
	            stmt.setInt(7, user.getUserId());

	            int rowsUpdated = stmt.executeUpdate();
	            return rowsUpdated > 0;
	        }
	    }
}
