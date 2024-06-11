package com.chainsys.finalproject.model;

import java.sql.Timestamp;
import java.util.Arrays;

public class Cart {
	
	private int cartId;
    private int userId;
    private int productId;
    private String productName;
    private byte[] productImage;
    private int quantity;
    private Timestamp dateAdded;
    private double totalPrice;
	public int getCartId() {
		return cartId;
	}
	public void setCartId(int cartId) {
		this.cartId = cartId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public byte[] getProductImage() {
		return productImage;
	}
	public void setProductImage(byte[] productImage) {
		this.productImage = productImage;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public Timestamp getDateAdded() {
		return dateAdded;
	}
	public void setDateAdded(Timestamp dateAdded) {
		this.dateAdded = dateAdded;
	}
	public double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}
	public Cart(int cartId, int userId, int productId, String productName, byte[] productImage, int quantity,
			Timestamp dateAdded, double totalPrice) {
		this.cartId = cartId;
		this.userId = userId;
		this.productId = productId;
		this.productName = productName;
		this.productImage = productImage;
		this.quantity = quantity;
		this.dateAdded = dateAdded;
		this.totalPrice = totalPrice;
	}
	public Cart() {
		
	}
	@Override
	public String toString() {
		return "Cart [cartId=" + cartId + ", userId=" + userId + ", productId=" + productId + ", productName="
				+ productName + ", productImage=" + Arrays.toString(productImage) + ", quantity=" + quantity
				+ ", dateAdded=" + dateAdded + ", totalPrice=" + totalPrice + "]";
	}
    
    
}
