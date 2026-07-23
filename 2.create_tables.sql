 CREATE DATABASE OnlineFoodDeliveryDB;
 USE OnlineFoodDeliveryDB;
 
 1.CUSTOMERS
 CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    age INT,
    phone VARCHAR(15),
    email VARCHAR(100),
    city VARCHAR(50),customers
    join_date DATE
);
select * from customers;

2.CUISINE
CREATE TABLE Cuisine (
    cuisine_id INT PRIMARY KEY AUTO_INCREMENT,
    cuisine_name VARCHAR(50) NOT NULL
);
select * from Cuisine

3.RESTAURANTS
CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_name VARCHAR(100) NOT NULL,
    cuisine_id INT,
    city VARCHAR(50),
    rating DECIMAL(2,1),
    opening_time TIME,
    closing_time TIME,
    FOREIGN KEY (cuisine_id)
    REFERENCES Cuisine(cuisine_id)
);
select * from Restaurants

4.MENU ITEMS
CREATE TABLE Menu_Items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT,
    item_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    availability VARCHAR(20),
    FOREIGN KEY (restaurant_id)
    REFERENCES Restaurants(restaurant_id)
);
select * from menu_items

5.PAYMENTS
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    payment_method VARCHAR(30),
    payment_status VARCHAR(20),
    payment_date DATE
);
select * from Payments;

6.ORDER STATUS
CREATE TABLE Order_Status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);
select * from order_status;

7.ORDERS
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2),
    delivery_fee DECIMAL(10,2),
    order_rating INT,
    payment_id INT,
    order_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id),
    FOREIGN KEY (payment_id) REFERENCES Payments(payment_id),
    FOREIGN KEY (order_status_id) REFERENCES Order_Status(order_status_id)
);
select * from orders;

8.ORDER DETAILS
CREATE TABLE Order_Details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    item_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES Menu_Items(item_id)
);
select * from order_details;

9.DELIVERY PARTNERS
CREATE TABLE Delivery_Partners (
    partner_id INT AUTO_INCREMENT PRIMARY KEY,
    partner_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    vehicle_type VARCHAR(30),
    city VARCHAR(50)
);
select * from delivery_partners;

10.DELIVERIES
CREATE TABLE Deliveries (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    partner_id INT NOT NULL,
    pickup_time DATETIME,
    delivery_time DATETIME,
    delivery_status VARCHAR(30),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (partner_id) REFERENCES Delivery_Partners(partner_id)
);
select * from deliveries;

11.CUSTOMER FEEDBACK
CREATE TABLE Customer_Feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    rating INT,
    review VARCHAR(255),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
select * from customer_feedback;

12.OFFERS
CREATE TABLE Offers (
    offer_id INT AUTO_INCREMENT PRIMARY KEY,
    offer_name VARCHAR(100) NOT NULL,
    discount_percent INT,
    start_date DATE,
    end_date DATE
);
select * from offers;

13.ORDER OFFERS
CREATE TABLE Order_Offers (
    order_offer_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    offer_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (offer_id) REFERENCES Offers(offer_id)
);
select * from order_offers;

14.CUSTOMER CHURN
CREATE TABLE Customer_Churn (
    churn_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    last_order_date DATE,
    inactive_days INT,
    churn_date DATE,
    churn_status VARCHAR(10),
    churn_reason VARCHAR(100),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
select * from customer_churn;

15.CUSTOMER SUPPORT
CREATE TABLE Customer_Support (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_id INT NOT NULL,
    issue_type VARCHAR(100),
    complaint_date DATE,
    resolution_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
select * from customer_support;


