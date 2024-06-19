package com.chainsys.finalproject.model;

import java.sql.Timestamp;
import java.util.Arrays;

public class Product {
    private int productId;
    private int userId;
    private String sellerName;
    private String categoryName;
    private String productName;
    private byte[] productImage;
    private byte[] sampleImage;
    private byte[] leftImage;
    private byte[] rightImage;
    private byte[] bottomImage;
    private double productPrice;
    private String productDescription;
    private int productQuantity;
    private boolean isDeleted;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private boolean available;
    private int quantity;
    
    // Getters and Setters
    public int getProductId() {
        return productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getSellerName() {
        return sellerName;
    }
    
    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }
    
    public String getCategoryName() {
        return categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
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
    
    public byte[] getSampleImage() {
        return sampleImage;
    }
    
    public void setSampleImage(byte[] sampleImage) {
        this.sampleImage = sampleImage;
    }
    
    public byte[] getLeftImage() {
        return leftImage;
    }
    
    public void setLeftImage(byte[] leftImage) {
        this.leftImage = leftImage;
    }
    
    public byte[] getRightImage() {
        return rightImage;
    }
    
    public void setRightImage(byte[] rightImage) {
        this.rightImage = rightImage;
    }
    
    public byte[] getBottomImage() {
        return bottomImage;
    }
    
    public void setBottomImage(byte[] bottomImage) {
        this.bottomImage = bottomImage;
    }
    
    public double getProductPrice() {
        return productPrice;
    }
    
    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }
    
    public String getProductDescription() {
        return productDescription;
    }
    
    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }
    
    public int getProductQuantity() {
        return productQuantity;
    }
    
    public void setProductQuantity(int productQuantity) {
        this.productQuantity = productQuantity;
    }
    
    public boolean isDeleted() {
        return isDeleted;
    }
    
    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    
	public boolean isAvailable() {
		return available;
	}

	public void setAvailable(boolean available) {
		this.available = available;
	}

	
	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Product() {
		

	}

	public Product(int productId, int userId, String sellerName, String categoryName, String productName,
			byte[] productImage, byte[] sampleImage, byte[] leftImage, byte[] rightImage, byte[] bottomImage,
			double productPrice, String productDescription, int productQuantity, boolean isDeleted, Timestamp createdAt,
			Timestamp updatedAt) {
		super();
		this.productId = productId;
		this.userId = userId;
		this.sellerName = sellerName;
		this.categoryName = categoryName;
		this.productName = productName;
		this.productImage = productImage;
		this.sampleImage = sampleImage;
		this.leftImage = leftImage;
		this.rightImage = rightImage;
		this.bottomImage = bottomImage;
		this.productPrice = productPrice;
		this.productDescription = productDescription;
		this.productQuantity = productQuantity;
		this.isDeleted = isDeleted;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}

	@Override
	public String toString() {
		return "Product [productId=" + productId + ", userId=" + userId + ", sellerName=" + sellerName
				+ ", categoryName=" + categoryName + ", productName=" + productName + ", productImage="
				+ Arrays.toString(productImage) + ", sampleImage=" + Arrays.toString(sampleImage) + ", leftImage="
				+ Arrays.toString(leftImage) + ", rightImage=" + Arrays.toString(rightImage) + ", bottomImage="
				+ Arrays.toString(bottomImage) + ", productPrice=" + productPrice + ", productDescription="
				+ productDescription + ", productQuantity=" + productQuantity + ", isDeleted=" + isDeleted
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
	}
    
	public Product(int productId, String productName, double productPrice, byte[] productImage, boolean available) {
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productImage = productImage;
        this.available = available;
    }
	
	
	
}
