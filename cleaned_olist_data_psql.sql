CREATE DATABASE olist_db;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    customer_unique_id TEXT,
    customer_zip_code_prefix INT,
    customer_city TEXT,
    customer_state TEXT,
    order_year INT,
    order_month INT,
    order_day INT
);
COPY orders
FROM 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_olist_data.csv'
DELIMITER ','
CSV HEADER;
SELECT * FROM orders LIMIT 10;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM orders WHERE order_purchase_timestamp IS NULL;
SELECT COUNT(*) AS total_orders FROM orders;
SELECT order_status, COUNT(*) AS total
FROM orders
GROUP BY order_status
ORDER BY total DESC;
SELECT order_month, COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY order_month;
SELECT order_year, COUNT(*) 
FROM orders
GROUP BY order_year;
SELECT customer_city, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_city
ORDER BY total_orders DESC
LIMIT 10;
SELECT customer_state, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_state
ORDER BY total_orders DESC;
SELECT
	DATE_TRUNC('month', order_purchase_timestamp) AS month,
	COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;
SELECT
	DATE(order_purchase_timestamp) AS order_date,
	COUNT(*) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY order_date;
SELECT
	DATE(order_purchase_timestamp) AS order_date,
	COUNT(*) AS daily_orders,
	SUM(COUNT(*)) OVER (ORDER BY DATE(order_purchase_timestamp)) AS running_total	
FROM orders
GROUP BY order_date;
SELECT
	customer_city,
	COUNT(*) AS total_orders,
	RANK() OVER (ORDER BY COUNT(*) DESC) AS rank	
FROM orders
GROUP BY customer_city;