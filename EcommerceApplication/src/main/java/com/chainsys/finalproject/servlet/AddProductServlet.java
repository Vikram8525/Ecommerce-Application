package com.chainsys.finalproject.servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Base64;

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
        try {
            // Debugging: Print incoming parameters
            System.out.println("User ID: " + request.getParameter("user_id"));
            System.out.println("Seller Name: " + request.getParameter("seller_name"));
            System.out.println("Category Name: " + request.getParameter("category_name"));
            System.out.println("Product Name: " + request.getParameter("product_name"));
            System.out.println("Product Price: " + request.getParameter("product_price"));
            System.out.println("Product Description: " + request.getParameter("product_description"));
            System.out.println("Product Quantity: " + request.getParameter("product_quantity"));

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
                request.setAttribute("status", "success");
                request.setAttribute("message", "Product added successfully!");
            } else {
                request.setAttribute("status", "error");
                request.setAttribute("message", "Failed to add product.");
            }
        } catch (Exception e) {
            request.setAttribute("status", "error");
            request.setAttribute("message", "Error: " + e.getMessage());
            e.printStackTrace();
        }

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
