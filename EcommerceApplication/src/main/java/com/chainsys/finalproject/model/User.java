package com.chainsys.finalproject.model;

import java.sql.Timestamp;

public class User {
    private int userId;
    private String userName;
    private String userEmail;
    private String password;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private boolean isSeller;
    private boolean isDeleted;
    private int numItemsBought;
    private int numItemsSold;
    private double walletBalance;
    private String firstName;
    private String lastName;
    private String address;
    private String state;
    private String city;
    private String pincode;

    
    // Getters and Setters
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getUserEmail() {
        return userEmail;
    }
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
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
    public boolean isSeller() {
        return isSeller;
    }
    public void setSeller(boolean isSeller) {
        this.isSeller = isSeller;
    }
    public boolean isDeleted() {
        return isDeleted;
    }
    public void setDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }
    public int getNumItemsBought() {
        return numItemsBought;
    }
    public void setNumItemsBought(int numItemsBought) {
        this.numItemsBought = numItemsBought;
    }
    public int getNumItemsSold() {
        return numItemsSold;
    }
    public void setNumItemsSold(int numItemsSold) {
        this.numItemsSold = numItemsSold;
    }
    public double getWalletBalance() {
        return walletBalance;
    }
    public void setWalletBalance(double walletBalance) {
        this.walletBalance = walletBalance;
    }
    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getState() {
        return state;
    }
    public void setState(String state) {
        this.state = state;
    }
    public String getCity() {
        return city;
    }
    public void setCity(String city) {
        this.city = city;
    }
    public String getPincode() {
        return pincode;
    }
    public void setPincode(String pincode) {
        this.pincode = pincode;
    }
	public User(int userId, String userName, String userEmail, String password, Timestamp createdAt,
			Timestamp updatedAt, boolean isSeller, boolean isDeleted, int numItemsBought, int numItemsSold,
			double walletBalance, String firstName, String lastName, String address, String state, String city,
			String pincode) {
		
		this.userId = userId;
		this.userName = userName;
		this.userEmail = userEmail;
		this.password = password;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.isSeller = isSeller;
		this.isDeleted = isDeleted;
		this.numItemsBought = numItemsBought;
		this.numItemsSold = numItemsSold;
		this.walletBalance = walletBalance;
		this.firstName = firstName;
		this.lastName = lastName;
		this.address = address;
		this.state = state;
		this.city = city;
		this.pincode = pincode;
	}
	
	
	@Override
	public String toString() {
		return "User [userId=" + userId + ", userName=" + userName + ", userEmail=" + userEmail + ", password="
				+ password + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", isSeller=" + isSeller
				+ ", isDeleted=" + isDeleted + ", numItemsBought=" + numItemsBought + ", numItemsSold=" + numItemsSold
				+ ", walletBalance=" + walletBalance + ", firstName=" + firstName + ", lastName=" + lastName
				+ ", address=" + address + ", state=" + state + ", city=" + city + ", pincode=" + pincode + "]";
	}
	
	public User(int userId, String userName, String userEmail, String password) {
        this.userId = userId;
        this.userName = userName;
        this.userEmail = userEmail;
        this.password = password;
    }
	
	public User() {
		
	}
    
    
}

