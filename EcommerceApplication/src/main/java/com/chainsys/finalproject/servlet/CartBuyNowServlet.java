package com.chainsys.finalproject.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chainsys.finalproject.dao.CartBuyNowDAO;

/**
 * Servlet implementation class CartBuyNowServlet
 */
@WebServlet("/CartBuyNowServlet")
public class CartBuyNowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartBuyNowServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdStr = request.getParameter("userId");
        String paymentMethod = request.getParameter("paymentMethod");

        if (userIdStr == null || userIdStr.isEmpty()) {
            request.setAttribute("status", "failed");
            request.setAttribute("message", "User ID is missing.");
            request.getRequestDispatcher("OrderConfirmation.jsp").forward(request, response);
            return;
        }

        int userId;
        try {
            userId = Integer.parseInt(userIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("status", "failed");
            request.setAttribute("message", "Invalid User ID.");
            request.getRequestDispatcher("OrderConfirmation.jsp").forward(request, response);
            return;
        }

        CartBuyNowDAO cartBuyNowDAO = new CartBuyNowDAO();

        // Step 1: Check wallet balance
        String balanceStatus = cartBuyNowDAO.checkWalletBalance(userId);
        if (!"Success".equals(balanceStatus)) {
            request.setAttribute("status", "failed");
            request.setAttribute("message", balanceStatus);
            request.getRequestDispatcher("OrderConfirmation.jsp").forward(request, response);
            return;
        }

        // Step 2: Update product quantities and user statistics
        String updateStatus = cartBuyNowDAO.updateProductQuantities(userId);
        if (!"Success".equals(updateStatus)) {
            request.setAttribute("status", "failed");
            request.setAttribute("message", updateStatus);
            request.getRequestDispatcher("OrderConfirmation.jsp").forward(request, response);
            return;
        }

        // Step 3: Fill order details
        String orderNumber = cartBuyNowDAO.generateOrderNumber();
        String orderStatus = cartBuyNowDAO.fillOrderDetails(userId, orderNumber);
        if (!"Success".equals(orderStatus)) {
            request.setAttribute("status", "failed");
            request.setAttribute("message", orderStatus);
            request.getRequestDispatcher("OrderConfirmation.jsp").forward(request, response);
            return;
        }

        // Step 4: Fill payment details
        String paymentStatus = cartBuyNowDAO.fillPaymentDetails(userId, orderNumber, paymentMethod);
        if (!"Success".equals(paymentStatus)) {
            request.setAttribute("status", "failed");
            request.setAttribute("message", paymentStatus);
            request.getRequestDispatcher("OrderConfirmation.jsp").forward(request, response);
            return;
        }

        // Step 5: Update wallet balances
        String walletStatus = cartBuyNowDAO.updateWalletBalances(userId, orderNumber);
        if (!"Success".equals(walletStatus)) {
            request.setAttribute("status", "failed");
            request.setAttribute("message", walletStatus);
            request.getRequestDispatcher("OrderConfirmation.jsp").forward(request, response);
            return;
        }

        // Step 6: Mark items as bought
        String markItemsStatus = cartBuyNowDAO.markItemsAsBought(userId);
        if (!"Success".equals(markItemsStatus)) {
            request.setAttribute("status", "failed");
            request.setAttribute("message", markItemsStatus);
            request.getRequestDispatcher("OrderConfirmation.jsp").forward(request, response);
            return;
        }

        boolean emailStatus = cartBuyNowDAO.sendOrderEmails(userId, orderNumber);
        if (!emailStatus) {
            request.setAttribute("status", "failed");
            request.setAttribute("message", "Failed to send order emails.");
            request.getRequestDispatcher("OrderConfirmation.jsp").forward(request, response);
            return;
        }

        // Success
        request.setAttribute("status", "success");
        request.setAttribute("message", "Order placed successfully!");
        request.setAttribute("orderNumber", orderNumber);
        request.getRequestDispatcher("OrderSuccess.jsp").forward(request, response);
    }
}
