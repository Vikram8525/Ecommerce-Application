package com.chainsys.finalproject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.chainsys.finalproject.util.Connectivity;

public class CartBuyNowDAO {

	public String checkWalletBalance(int userId) {
	    try (Connection conn = Connectivity.getConnection()) {
	        String query = "SELECT SUM(p.product_price * c.quantity) AS total_amount, u.wallet_balance " +
	                       "FROM Cart c JOIN Products p ON c.product_id = p.product_id " +
	                       "JOIN Users u ON c.user_id = u.user_id " +
	                       "WHERE c.user_id = ? AND c.is_bought = 0";
	        PreparedStatement stmt = conn.prepareStatement(query);
	        stmt.setInt(1, userId);
	        ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	            double totalAmount = rs.getDouble("total_amount");
	            double walletBalance = rs.getDouble("wallet_balance");
	            if (walletBalance < totalAmount) {
	                return "Insufficient wallet balance.";
	            }
	            return "Success";
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return "Failed to check wallet balance.";
	}

    public String updateProductQuantities(int userId) {
        try (Connection conn = Connectivity.getConnection()) {
            conn.setAutoCommit(false);

            // Get all products in the cart
            String query = "SELECT c.product_id, c.quantity, p.product_quantity, p.user_id AS seller_id " +
                           "FROM Cart c JOIN Products p ON c.product_id = p.product_id " +
                           "WHERE c.user_id = ? AND c.is_bought = 0";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");
                int productQuantity = rs.getInt("product_quantity");
                int sellerId = rs.getInt("seller_id");

                // Update product quantity
                String updateProduct = "UPDATE Products SET product_quantity = product_quantity - ? WHERE product_id = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateProduct);
                updateStmt.setInt(1, quantity);
                updateStmt.setInt(2, productId);
                updateStmt.executeUpdate();

                // Update num_items_sold for seller
                String updateSeller = "UPDATE Users SET num_items_sold = num_items_sold + ? WHERE user_id = ?";
                PreparedStatement updateSellerStmt = conn.prepareStatement(updateSeller);
                updateSellerStmt.setInt(1, quantity);
                updateSellerStmt.setInt(2, sellerId);
                updateSellerStmt.executeUpdate();
            }

            // Update num_items_bought for buyer
            String updateBuyer = "UPDATE Users SET num_items_bought = num_items_bought + (SELECT SUM(quantity) FROM Cart WHERE user_id = ? AND is_bought = 0) WHERE user_id = ?";
            PreparedStatement updateBuyerStmt = conn.prepareStatement(updateBuyer);
            updateBuyerStmt.setInt(1, userId);
            updateBuyerStmt.setInt(2, userId);
            updateBuyerStmt.executeUpdate();

            conn.commit();
            return "Success";
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Failed to update product quantities.";
    }

    public String fillOrderDetails(int userId, String orderNumber) {
        try (Connection conn = Connectivity.getConnection()) {
            conn.setAutoCommit(false);

            String query = "SELECT c.product_id, c.quantity, p.product_name, p.product_image, p.product_price " +
                           "FROM Cart c JOIN Products p ON c.product_id = p.product_id " +
                           "WHERE c.user_id = ? AND c.is_bought = 0";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            String insertOrder = "INSERT INTO order_details (user_id, product_id, order_number, product_name, product_image, quantity, total_price) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertOrder);

            while (rs.next()) {
                int productId = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");
                String productName = rs.getString("product_name");
                byte[] productImage = rs.getBytes("product_image");
                double productPrice = rs.getDouble("product_price");
                double totalPrice = quantity * productPrice;

                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, productId);
                insertStmt.setString(3, orderNumber);
                insertStmt.setString(4, productName);
                insertStmt.setBytes(5, productImage);
                insertStmt.setInt(6, quantity);
                insertStmt.setDouble(7, totalPrice);
                insertStmt.executeUpdate();
            }

            conn.commit();
            return "Success";
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Failed to fill order details.";
    }

    public String fillPaymentDetails(int userId, String orderNumber, String paymentMethod) {
        try (Connection conn = Connectivity.getConnection()) {
            conn.setAutoCommit(false);

            String query = "SELECT order_id, total_price FROM order_details WHERE user_id = ? AND order_number = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            stmt.setString(2, orderNumber);
            ResultSet rs = stmt.executeQuery();

            String insertPayment = "INSERT INTO payments (order_id, user_id, payment_method, payment_status, amount) VALUES (?, ?, ?, 'Completed', ?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertPayment);

            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                double totalPrice = rs.getDouble("total_price");

                insertStmt.setInt(1, orderId);
                insertStmt.setInt(2, userId);
                insertStmt.setString(3, paymentMethod);
                insertStmt.setDouble(4, totalPrice);
                insertStmt.executeUpdate();
            }

            conn.commit();
            return "Success";
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Failed to fill payment details.";
    }

    public String updateWalletBalances(int userId, String orderNumber) {
        try (Connection conn = Connectivity.getConnection()) {
            conn.setAutoCommit(false);

            String query = "SELECT od.product_id, od.total_price, p.user_id AS seller_id " +
                           "FROM order_details od JOIN Products p ON od.product_id = p.product_id " +
                           "WHERE od.user_id = ? AND od.order_number = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            stmt.setString(2, orderNumber);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("product_id");
                double totalPrice = rs.getDouble("total_price");
                int sellerId = rs.getInt("seller_id");

                // Subtract from buyer's wallet
                String updateBuyerWallet = "UPDATE Users SET wallet_balance = wallet_balance - ? WHERE user_id = ?";
                PreparedStatement updateBuyerStmt = conn.prepareStatement(updateBuyerWallet);
                updateBuyerStmt.setDouble(1, totalPrice);
                updateBuyerStmt.setInt(2, userId);
                updateBuyerStmt.executeUpdate();

                // Add to seller's wallet
                String updateSellerWallet = "UPDATE Users SET wallet_balance = wallet_balance + ? WHERE user_id = ?";
                PreparedStatement updateSellerStmt = conn.prepareStatement(updateSellerWallet);
                updateSellerStmt.setDouble(1, totalPrice);
                updateSellerStmt.setInt(2, sellerId);
                updateSellerStmt.executeUpdate();
            }

            conn.commit();
            return "Success";
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Failed to update wallet balances.";
    }

    public String generateOrderNumber() {
        return "ORD-" + System.currentTimeMillis();
    }
    
    public String markItemsAsBought(int userId) {
        try (Connection conn = Connectivity.getConnection()) {
            String updateQuery = "UPDATE Cart SET is_bought = 1 WHERE user_id = ? AND is_bought = 0";
            PreparedStatement stmt = conn.prepareStatement(updateQuery);
            stmt.setInt(1, userId);
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                return "Success";
            } else {
                return "No items found in the cart to mark as bought.";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Failed to update cart items.";
    }
    public boolean sendOrderEmails(int userId, String orderNumber) {
        final String username = "tarzan.in.shopping@gmail.com";
        final String password = "belm plgh kvfk udpr";

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

        try (Connection conn = Connectivity.getConnection()) {
            // Get buyer details
            String buyerQuery = "SELECT user_name, user_email, address, city, state, pincode FROM Users WHERE user_id = ?";
            PreparedStatement buyerStmt = conn.prepareStatement(buyerQuery);
            buyerStmt.setInt(1, userId);
            ResultSet buyerRs = buyerStmt.executeQuery();
            String buyerName = "", buyerEmail = "", buyerAddress = "", buyerCity = "", buyerState = "", buyerPincode = "";
            if (buyerRs.next()) {
                buyerName = buyerRs.getString("user_name");
                buyerEmail = buyerRs.getString("user_email");
                buyerAddress = buyerRs.getString("address");
                buyerCity = buyerRs.getString("city");
                buyerState = buyerRs.getString("state");
                buyerPincode = buyerRs.getString("pincode");
            }

            // Get order and seller details
            String orderQuery = "SELECT od.product_id, od.product_name, od.quantity, p.user_id AS seller_id, u.user_name AS seller_name, u.user_email AS seller_email " +
                                "FROM order_details od " +
                                "JOIN Products p ON od.product_id = p.product_id " +
                                "JOIN Users u ON p.user_id = u.user_id " +
                                "WHERE od.user_id = ? AND od.order_number = ?";
            PreparedStatement orderStmt = conn.prepareStatement(orderQuery);
            orderStmt.setInt(1, userId);
            orderStmt.setString(2, orderNumber);
            ResultSet orderRs = orderStmt.executeQuery();

            while (orderRs.next()) {
                String productName = orderRs.getString("product_name");
                int quantity = orderRs.getInt("quantity");
                String sellerName = orderRs.getString("seller_name");
                String sellerEmail = orderRs.getString("seller_email");

                // Send email to seller
                Message sellerMessage = new MimeMessage(session);
                sellerMessage.setFrom(new InternetAddress(username));
                sellerMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(sellerEmail));
                sellerMessage.setSubject("New Order Notification");

                StringBuilder sellerEmailBody = new StringBuilder();
                sellerEmailBody.append("Dear ").append(sellerName).append(",<br><br>");
                sellerEmailBody.append("The user with ID ").append(userId).append(" (").append(buyerName)
                               .append(") has ordered your product ID ")
                               .append(orderRs.getInt("product_id")).append(" (").append(productName).append(") for the quantity of ")
                               .append(quantity).append(".<br>");
                sellerEmailBody.append("Order number: ").append(orderNumber).append("<br>");
                sellerEmailBody.append("The customer address is: ").append(buyerAddress).append(", ")
                               .append(buyerCity).append(", ").append(buyerState).append(", ").append(buyerPincode).append("<br>");
                sellerEmailBody.append("Please deliver the product from your store to the customer as soon as possible.<br><br>");
                sellerEmailBody.append("Thank you!");

                sellerMessage.setContent(sellerEmailBody.toString(), "text/html");
                Transport.send(sellerMessage);
            }

            // Send email to buyer
            Message buyerMessage = new MimeMessage(session);
            buyerMessage.setFrom(new InternetAddress(username));
            buyerMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(buyerEmail));
            buyerMessage.setSubject("Order Confirmation");

            StringBuilder buyerEmailBody = new StringBuilder();
            buyerEmailBody.append("Dear ").append(buyerName).append(",<br><br>");
            buyerEmailBody.append("Thank you for shopping with us.<br><br>");
            buyerEmailBody.append("Your order with the following details will be received on or before ")
                           .append(calculateDeliveryDate()).append(":<br>");

            // Reset order query to fetch product details for the buyer email
            orderStmt.clearParameters();
            orderStmt.setInt(1, userId);
            orderStmt.setString(2, orderNumber);
            orderRs = orderStmt.executeQuery();

            while (orderRs.next()) {
                buyerEmailBody.append(orderRs.getString("product_name")).append(" - Quantity: ")
                              .append(orderRs.getInt("quantity")).append("<br>");
            }

            buyerEmailBody.append("<br>Your order ID is ").append(orderNumber).append(".<br><br>");
            buyerEmailBody.append("Please ensure someone is available to receive the package.<br><br>");
            buyerEmailBody.append("Thank you!");

            buyerMessage.setContent(buyerEmailBody.toString(), "text/html");
            Transport.send(buyerMessage);

            return true;
        } catch (SQLException | MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    private String calculateDeliveryDate() {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, 7);
        Date deliveryDate = cal.getTime();
        return deliveryDate.toString();
    }
}

