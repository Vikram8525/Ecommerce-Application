package com.chainsys.finalproject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.chainsys.finalproject.model.User;
import com.chainsys.finalproject.util.Connectivity;

public class UserDAO {
	public boolean addUser(User user) throws SQLException {
	    String insertUserQuery = "INSERT INTO users (user_id, user_name, user_email, password) VALUES (?, ?, ?, ?)";
	    String updateWalletQuery = "UPDATE users SET wallet_balance = 100000 WHERE user_id = ?";

	    try (Connection conn = Connectivity.getConnection(); 
	         PreparedStatement insertStmt = conn.prepareStatement(insertUserQuery);
	         PreparedStatement updateStmt = conn.prepareStatement(updateWalletQuery)) {

	        // Insert the new user
	        insertStmt.setInt(1, user.getUserId());
	        insertStmt.setString(2, user.getUserName());
	        insertStmt.setString(3, user.getUserEmail());
	        insertStmt.setString(4, user.getPassword());
	        int rowsInserted = insertStmt.executeUpdate();

	        // If the user was successfully added, update the wallet balance
	        if (rowsInserted > 0) {
	            updateStmt.setInt(1, user.getUserId());
	            int rowsUpdated = updateStmt.executeUpdate();
	            return rowsUpdated > 0;
	        } else {
	            return false;
	        }
	    }
	}


    public int generateUniqueUserId() throws SQLException {
        String query = "SELECT user_id FROM users WHERE user_id = ?";
        Random random = new Random();
        int userId;
        boolean unique;
        do {
            userId = 1000 + random.nextInt(9000);
            try (Connection conn = Connectivity.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, userId);
                try (ResultSet rs = stmt.executeQuery()) {
                    unique = !rs.next();
                }
            }
        } while (!unique);
        return userId;
    }

    public boolean sendWelcomeEmail(User user) {
        final String username = "osonlineshopping614@gmail.com";
        final String password = "eaer hvch jsje qspy";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            // Fetch user details from the database if not set
            if (user.getUserName() == null || user.getUserName().isEmpty() || user.getUserEmail() == null || user.getUserEmail().isEmpty()) {
                User dbUser = getUserDetailsFromDatabase(user.getUserId());
                if (dbUser == null) {
                    throw new IllegalArgumentException("User details not found in the database");
                }
                if (user.getUserName() == null || user.getUserName().isEmpty()) {
                    user.setUserName(dbUser.getUserName());
                }
                if (user.getUserEmail() == null || user.getUserEmail().isEmpty()) {
                    user.setUserEmail(dbUser.getUserEmail());
                }
            }

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(user.getUserEmail()));
            message.setSubject("Welcome to our E-commerce Application");

            // Construct the email body
            StringBuilder emailBody = new StringBuilder();
            emailBody.append("Dear " + user.getUserName() + ",<br><br>");
            emailBody.append("Welcome to our E-commerce Application!<br><br>");
            emailBody.append("Your user ID is: <b>" + user.getUserId() + "</b><br><br>");
            emailBody.append("Please remember your user ID for future reference.<br><br>");
            emailBody.append("Thank you for joining us!");

            message.setContent(emailBody.toString(), "text/html");

            Transport.send(message);

            return true;
        } catch (MessagingException | IllegalArgumentException e) {
            e.printStackTrace();
            return false;
        }
    }

    private User getUserDetailsFromDatabase(int userId) {
        String query = "SELECT user_name, user_email FROM users WHERE user_id = ?";
        try (Connection conn = Connectivity.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String userName = rs.getString("user_name");
                    String userEmail = rs.getString("user_email");
                    return new User(userId, userName, userEmail, null); // assuming password is not needed here
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public User getUserByIdAndPassword(int userId, String password) throws SQLException {
        User user = null;
        String query = "SELECT user_name, user_email,is_seller FROM users WHERE user_id = ? AND password = ?";
        
        try (Connection conn = Connectivity.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, userId);
            stmt.setString(2, password);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String userName = rs.getString("user_name");
                    String userEmail = rs.getString("user_email");
                    boolean isSeller =rs.getBoolean("is_seller");
                    user = new User(userId, userName, userEmail, password,isSeller);
                    System.out.println(userName);
                }
            }
        }
        
        return user;
    }
}
