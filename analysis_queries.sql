1.How many customers are registered?
Select count(*) as total_customers from customers;

2.How many customers are active?
Select count(*) as active_customers from customer_churn 
where churn_status= 'Active';

3.How many customers have churned?
Select count(*) as churned_customers from customer_churn 
where churn_status= 'Churned';

4.What is the overall customer churn rate?
select ROUND(
(COUNT(CASE WHEN churn_status='Churned' THEN 1 END)*100.0)/COUNT(*),2)
FROM Customer_churn;

5.Which customers have not placed an order in the last 90 days?
Select customer_id,last_order_date FROM Customer_churn
where inactive_days >90;

6.Which city has the highest number of churned customers?
select c.city,count(*) AS churn_count
FROM Customers C
JOIN Customer_churn cc
ON c.customer_id=cc.customer_id
WHERE cc.churn_status='Churned'
GROUP BY c.city
ORDER BY churn_count DESC;

7.Which age group has the highest churn rate?
Select
CASE 
WHEN age BETWEEN 18 and 25 THEN '18-25'
WHEN age BETWEEN 26 and 35 THEN '26-35'
WHEN age BETWEEN 36 and 45 THEN '36-45'
ELSE '46+'
END AS age_group,
COUNT(*) AS churn_count
FROM Customers c
JOIN Customer_churn cc
ON c.customer_id=cc.customer_id
WHERE cc.churn_status='Churned'
GROUP BY age_group
ORDER BY churn_count DESC;

8.Which gender has the highest churn rate?
Select gender,COUNT(*) AS churn_count
FROM customers c
JOIN customer_churn cc
ON c.customer_id=cc.customer_id
WHERE cc.churn_status='Churned'
GROUP BY gender
ORDER BY churn_count DESC;

9.Which customers have placed only one order and never returned?
Select customer_id,count(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id)=1;

10.Which customers have the highest inactive days?
Select customer_id,inactive_days FROM Customer_churn
ORDER BY inactive_days DESC;

11.What are the top reasons for customer churn?
select churn_reason,COUNT(*) AS total
FROM Customer_churn
GROUP BY churn_reason
ORDER BY total DESC;

12.Which churn reason is most common?
select churn_reason,COUNT(*) AS total
FROM Customer_churn
GROUP BY churn_reason
ORDER BY total DESC
LIMIT 1;

13.Which customers churned due to poor service?
Select customer_id FROM customer_churn
WHERE churn_reason='Poor Service';

14.Which customers churned due to relocated?
Select customer_id FROM customer_churn
WHERE churn_reason='Relocated';

15.Which customers churned due to Price?
Select customer_id FROM customer_churn
WHERE churn_reason='Price';

16.Which customers churned due to other reason?
Select customer_id FROM customer_churn
WHERE churn_reason='other';

17.Which customers churned after raising customer support complaints?
Select DISTINCT cs.customer_id FROM Customer_Support cs
JOIN Customer_Churn cc
ON cs.customer_id=cc.customer_id
WHERE cc.churn_status='Churned';

18.Which customers churned despite using discount offers?
SELECT DISTINCT o.customer_id
FROM Orders o
JOIN Order_Offers oo
ON o.order_id=oo.order_id
JOIN Customer_Churn cc
ON o.customer_id=cc.customer_id
WHERE cc.churn_status='Churned';

19.Which customers churned after giving low ratings?
SELECT DISTINCT customer_id
FROM Customer_Feedback
WHERE rating<=2;

20.Which restaurant has the highest number of churned customers?
SELECT r.restaurant_name,
COUNT(*) churn_count
FROM Orders o
JOIN Restaurants r
ON o.restaurant_id=r.restaurant_id
JOIN Customer_Churn cc
ON o.customer_id=cc.customer_id
WHERE cc.churn_status='Churned'
GROUP BY r.restaurant_name
ORDER BY churn_count DESC;

21.Which restaurant has the lowest customer retention?
SELECT r.restaurant_name,
COUNT(cc.customer_id) churned
FROM Restaurants r
JOIN Orders o
ON r.restaurant_id=o.restaurant_id
JOIN Customer_Churn cc
ON o.customer_id=cc.customer_id
WHERE cc.churn_status='Churned'
GROUP BY r.restaurant_name
ORDER BY churned DESC;

22.Which cuisine has the highest churn rate?
SELECT cu.cuisine_name,
COUNT(*) churn_count
FROM Restaurants r
JOIN Cuisine cu
ON r.cuisine_id=cu.cuisine_id
JOIN Orders o
ON r.restaurant_id=o.restaurant_id
JOIN Customer_Churn cc
ON o.customer_id=cc.customer_id
WHERE cc.churn_status='Churned'
GROUP BY cu.cuisine_name
ORDER BY churn_count DESC;


23.Which restaurants receive the most low-rated feedback?
SELECT r.restaurant_name,
AVG(cf.rating) avg_rating
FROM Customer_Feedback cf
JOIN Orders o
ON cf.order_id=o.order_id
JOIN Restaurants r
ON o.restaurant_id=r.restaurant_id
GROUP BY r.restaurant_name
ORDER BY avg_rating;

24.Which restaurants have the highest order cancellation rate?
SELECT r.restaurant_name,
COUNT(*) cancelled
FROM Orders o
JOIN Restaurants r
ON o.restaurant_id=r.restaurant_id
JOIN Order_Status os
ON o.order_status_id=os.order_status_id
WHERE os.status_name='Cancelled'
GROUP BY r.restaurant_name
ORDER BY cancelled DESC;

25.What is the average order value of churned customers?
SELECT AVG(total_amount) avg_order_value
FROM Orders o
JOIN Customer_Churn cc
ON o.customer_id=cc.customer_id
WHERE cc.churn_status='Churned';

26.What is the average order value of active customers?
SELECT AVG(total_amount)
FROM Orders o
JOIN Customer_Churn cc
ON o.customer_id=cc.customer_id
WHERE cc.churn_status='Active';

27.Which payment method is most used by churned customers?
SELECT p.payment_method,
COUNT(*) total
FROM Payments p
JOIN Orders o
ON p.payment_id=o.payment_id
JOIN Customer_Churn cc
ON o.customer_id=cc.customer_id
WHERE cc.churn_status='Churned'
GROUP BY p.payment_method
ORDER BY total DESC;


28.Do customers who use offers churn less than those who don't?
SELECT
CASE
WHEN oo.offer_id IS NULL THEN 'No Offer'
ELSE 'Offer'
END AS offer_status,
COUNT(*) customers
FROM Orders o
LEFT JOIN Order_Offers oo
ON o.order_id=oo.order_id
GROUP BY offer_status;

29.Which offer is most effective in retaining customers?
SELECT o.offer_name,
COUNT(*)  AS usage_count
FROM Offers o
JOIN Order_Offers oo
ON o.offer_id=oo.offer_id
GROUP BY o.offer_name
ORDER BY usage_count DESC;

30.What is the average delivery time for churned customers?
SELECT AVG(TIMESTAMPDIFF(MINUTE,pickup_time,delivery_time))
AS avg_delivery
FROM Deliveries d
JOIN Orders o
ON d.order_id=o.order_id
JOIN Customer_Churn cc
ON o.customer_id=cc.customer_id
WHERE cc.churn_status='Churned';

31.Which delivery partner handled the most churned customers?
SELECT dp.partner_name,
COUNT(*) total
FROM Deliveries d
JOIN Delivery_Partners dp
ON d.partner_id=dp.partner_id
JOIN Orders o
ON d.order_id=o.order_id
JOIN Customer_Churn cc
ON o.customer_id=cc.customer_id
WHERE cc.churn_status='Churned'
GROUP BY dp.partner_name
ORDER BY total DESC;

32.Is there a relationship between delivery delays and customer churn?
SELECT cc.churn_status,
AVG(TIMESTAMPDIFF(MINUTE,pickup_time,delivery_time))
AS avg_time
FROM Deliveries d
JOIN Orders o
ON d.order_id=o.order_id
JOIN Customer_Churn cc
ON o.customer_id=cc.customer_id
GROUP BY cc.churn_status;

33.How many churned customers experienced delayed deliveries?
SELECT COUNT(DISTINCT cc.customer_id)
FROM Deliveries d
JOIN Orders o
ON d.order_id=o.order_id
JOIN Customer_Churn cc
ON o.customer_id=cc.customer_id
WHERE TIMESTAMPDIFF(MINUTE,pickup_time,delivery_time)>60
AND cc.churn_status='Churned';

34.Which city has the highest average delivery time?
SELECT dp.city,
AVG(TIMESTAMPDIFF(MINUTE,pickup_time,delivery_time))
AS avg_time
FROM Deliveries d
JOIN Delivery_Partners dp
ON d.partner_id=dp.partner_id
GROUP BY dp.city
ORDER BY avg_time DESC;

35.Which month recorded the highest number of churned customers?
SELECT MONTH(churn_date) month,
COUNT(*) total
FROM Customer_Churn
GROUP BY MONTH(churn_date)
ORDER BY total DESC;

36.What is the monthly churn trend?
SELECT DATE_FORMAT(churn_date,'%Y-%m') month,
COUNT(*) total
FROM Customer_Churn
GROUP BY DATE_FORMAT(churn_date,'%Y-%m')
ORDER BY month;

37.Which customers are at high risk of churning based on inactivity?
SELECT customer_id,inactive_days
FROM Customer_Churn
WHERE inactive_days>=60
AND churn_status='Active';

38.Which customers should receive a retention offer?
SELECT customer_id
FROM Customer_Churn
WHERE inactive_days>=45
AND churn_status='Active';

39.Which customers returned after being marked as churned?
SELECT customer_id
FROM Customer_Churn
WHERE churn_status='Active'
AND inactive_days<30;

40.What are the top five factors contributing to customer churn?
SELECT churn_reason,
COUNT(*) total
FROM Customer_Churn
GROUP BY churn_reason
ORDER BY total DESC
LIMIT 5;
