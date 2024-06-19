package com.chainsys.finalproject.servlet;

import java.io.IOException;
import java.sql.Timestamp;


import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chainsys.finalproject.dao.ProductDAO;
import com.chainsys.finalproject.model.Product;

/**
 * Servlet implementation class AddProductServlet
 */
@WebServlet("/AddProductServlet")
@MultipartConfig
public class AddProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProductServlet() {
        super();

    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	
	private static final String MESSAGE_ATTRIBUTE = "message";
	private static final String STATUS_ATTRIBUTE = "status";

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {


            int userId = Integer.parseInt(request.getParameter("user_id"));
            String sellerName = request.getParameter("seller_name");
            String categoryName = request.getParameter("category_name");
            String productName = request.getParameter("product_name");
            byte[] productImage = request.getPart("product_image").getInputStream().readAllBytes();
            byte[] sampleImage = request.getPart("sample_image").getInputStream().readAllBytes();
            byte[] leftImage = request.getPart("left_image").getInputStream().readAllBytes();
            byte[] rightImage = request.getPart("right_image").getInputStream().readAllBytes();
            byte[] bottomImage = request.getPart("bottom_image").getInputStream().readAllBytes();
            double productPrice = Double.parseDouble(request.getParameter("product_price"));
            String productDescription = request.getParameter("product_description");
            int productQuantity = Integer.parseInt(request.getParameter("product_quantity"));

            Product product = new Product();
            product.setUserId(userId);
            product.setSellerName(sellerName);
            product.setCategoryName(categoryName);
            product.setProductName(productName);
            product.setProductImage(productImage);
            product.setSampleImage(sampleImage);
            product.setLeftImage(leftImage);
            product.setRightImage(rightImage);
            product.setBottomImage(bottomImage);
            product.setProductPrice(productPrice);
            product.setProductDescription(productDescription);
            product.setProductQuantity(productQuantity);
            product.setDeleted(false);
            product.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            product.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

            ProductDAO productDAO = new ProductDAO();
            boolean isProductAdded = productDAO.addProduct(product);

            if (isProductAdded) {
                request.setAttribute(STATUS_ATTRIBUTE, "success");
                request.setAttribute(MESSAGE_ATTRIBUTE, "Product added successfully!");
            } else {
                request.setAttribute(STATUS_ATTRIBUTE, "error");
                request.setAttribute(MESSAGE_ATTRIBUTE, "Failed to add product.");
            }
        } catch (Exception e) {
            request.setAttribute(STATUS_ATTRIBUTE, "error");
            request.setAttribute(MESSAGE_ATTRIBUTE, "Error: " + e.getMessage());
            e.printStackTrace();
        }

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
