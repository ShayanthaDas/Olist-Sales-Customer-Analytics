CREATE DATABASE olist_db;
USE olist_db;
CREATE TABLE orders (
	order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_purchase_timestamp DATETIME,
    order_year INT,
    order_month INT,
    order_day INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);
SELECT * FROM orders LIMIT 10;
SELECT COUNT(*) AS total_orders
FROM orders;
SELECT order_year, COUNT(*) AS total_orders
FROM orders
GROUP BY order_year
ORDER BY order_year;
SELECT order_month, COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY order_month;
SELECT customer_city, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_city
ORDER BY total_orders DESC
LIMIT 100;
SELECT customer_state, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_state
ORDER BY total_orders DESC;
SELECT order_year, order_month, COUNT(*) AS total_orders
FROM orders
GROUP BY order_year, order_month
ORDER BY order_year, order_month;
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;
SELECT COUNT(*) AS repeat_customers
FROM (
	SELECT customer_id
    FROM orders
	GROUP BY customer_id
    HAVING COUNT(order_id) > 1
) AS sub;
SELECT COUNT(*) AS new_customers
FROM (
	SELECT customer_id
    FROM orders
	GROUP BY customer_id
    HAVING COUNT(order_id) = 1
) AS sub;
SELECT
	order_month,
    COUNT(*) AS total_orders,
    LAG(COUNT(*)) OVER (ORDER BY order_month) AS prev_month,
    (COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY order_month))
    / LAG(COUNT(*)) OVER (ORDER BY order_month) AS growth_rate
FROM orders
GROUP BY order_month;