package com.chainsys.finalproject.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class Connectivity {
    static {
        try {
            // Load MySQL JDBC driver class
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("Error loading MySQL JDBC driver", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/ecom"; // Database URL
        String user = "root"; // Database username
        String password = "Vikram@8525"; // Database password
        return DriverManager.getConnection(url, user, password);
    }
   
}
