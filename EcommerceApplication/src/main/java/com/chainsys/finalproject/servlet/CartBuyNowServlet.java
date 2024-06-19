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

    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	
	private static final String FAILED_ATTRIBUTE = "failed";
	private static final String MESSAGE_ATTRIBUTE = "message";
	private static final String STATUS_ATTRIBUTE = "status";
	private static final String ORDER_ATTRIBUTE = "OrderConfirmation.jsp";
	private static final String SUCCESS_ATTRIBUTE = "Success";

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdStr = request.getParameter("userId");
        String paymentMethod = request.getParameter("paymentMethod");

        if (userIdStr == null || userIdStr.isEmpty()) {
            request.setAttribute(STATUS_ATTRIBUTE, FAILED_ATTRIBUTE);
            request.setAttribute(MESSAGE_ATTRIBUTE, "User ID is missing.");
            request.getRequestDispatcher(ORDER_ATTRIBUTE).forward(request, response);
            return;
        }

        int userId;
        try {
            userId = Integer.parseInt(userIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute(STATUS_ATTRIBUTE, FAILED_ATTRIBUTE);
            request.setAttribute(MESSAGE_ATTRIBUTE, "Invalid User ID.");
            request.getRequestDispatcher(ORDER_ATTRIBUTE).forward(request, response);
            return;
        }

        CartBuyNowDAO cartBuyNowDAO = new CartBuyNowDAO();

        // Step 1: Check wallet balance
        String balanceStatus = cartBuyNowDAO.checkWalletBalance(userId);
        if (!SUCCESS_ATTRIBUTE.equals(balanceStatus)) {
            request.setAttribute(STATUS_ATTRIBUTE, FAILED_ATTRIBUTE);
            request.setAttribute(MESSAGE_ATTRIBUTE, balanceStatus);
            request.getRequestDispatcher(ORDER_ATTRIBUTE).forward(request, response);
            return;
        }

        // Step 2: Update product quantities and user statistics
        String updateStatus = cartBuyNowDAO.updateProductQuantities(userId);
        if (!SUCCESS_ATTRIBUTE.equals(updateStatus)) {
            request.setAttribute(STATUS_ATTRIBUTE, FAILED_ATTRIBUTE);
            request.setAttribute(MESSAGE_ATTRIBUTE, updateStatus);
            request.getRequestDispatcher(ORDER_ATTRIBUTE).forward(request, response);
            return;
        }

        // Step 3: Fill order details
        String orderNumber = cartBuyNowDAO.generateOrderNumber();
        String orderStatus = cartBuyNowDAO.fillOrderDetails(userId, orderNumber);
        if (!SUCCESS_ATTRIBUTE.equals(orderStatus)) {
            request.setAttribute(STATUS_ATTRIBUTE, FAILED_ATTRIBUTE);
            request.setAttribute(MESSAGE_ATTRIBUTE, orderStatus);
            request.getRequestDispatcher(ORDER_ATTRIBUTE).forward(request, response);
            return;
        }

        // Step 4: Fill payment details
        String paymentStatus = cartBuyNowDAO.fillPaymentDetails(userId, orderNumber, paymentMethod);
        if (!SUCCESS_ATTRIBUTE.equals(paymentStatus)) {
            request.setAttribute(STATUS_ATTRIBUTE, FAILED_ATTRIBUTE);
            request.setAttribute(MESSAGE_ATTRIBUTE, paymentStatus);
            request.getRequestDispatcher(ORDER_ATTRIBUTE).forward(request, response);
            return;
        }

        // Step 5: Update wallet balances
        String walletStatus = cartBuyNowDAO.updateWalletBalances(userId, orderNumber);
        if (!SUCCESS_ATTRIBUTE.equals(walletStatus)) {
            request.setAttribute(STATUS_ATTRIBUTE, FAILED_ATTRIBUTE);
            request.setAttribute(MESSAGE_ATTRIBUTE, walletStatus);
            request.getRequestDispatcher(ORDER_ATTRIBUTE).forward(request, response);
            return;
        }

        // Step 6: Mark items as bought
        String markItemsStatus = cartBuyNowDAO.markItemsAsBought(userId);
        if (!SUCCESS_ATTRIBUTE.equals(markItemsStatus)) {
            request.setAttribute(STATUS_ATTRIBUTE, FAILED_ATTRIBUTE);
            request.setAttribute(MESSAGE_ATTRIBUTE, markItemsStatus);
            request.getRequestDispatcher(ORDER_ATTRIBUTE).forward(request, response);
            return;
        }

        boolean emailStatus = cartBuyNowDAO.sendOrderEmails(userId, orderNumber);
        if (!emailStatus) {
            request.setAttribute(STATUS_ATTRIBUTE, FAILED_ATTRIBUTE);
            request.setAttribute(MESSAGE_ATTRIBUTE, "Failed to send order emails.");
            request.getRequestDispatcher(ORDER_ATTRIBUTE).forward(request, response);
            return;
        }

        // Success
        request.setAttribute(STATUS_ATTRIBUTE, "success");
        request.setAttribute(MESSAGE_ATTRIBUTE, "Order placed successfully!");
        request.setAttribute("orderNumber", orderNumber);
        request.getRequestDispatcher("OrderSuccess.jsp").forward(request, response);
    }
}
