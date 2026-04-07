CREATE DATABASE IF NOT EXISTS Pizza;

USE Pizza;

CREATE TABLE IF NOT EXISTS Pizza_Sales (
    pizza_id INT,
    order_id INT,
    pizza_name_id VARCHAR(50),
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price FLOAT,
    total_price FLOAT,
    pizza_size VARCHAR(10),
    pizza_category VARCHAR(30),
    pizza_ingredients VARCHAR(200),
    pizza_name VARCHAR(100)
);


-- Data Cleaning--
SELECT * FROM Pizza_Sales
WHERE
pizza_id IS NULL OR
order_id IS NULL OR 
pizza_name_id IS NULL OR
quantity IS NULL OR
order_date IS NULL OR
order_time IS NULL OR
unit_price IS NULL OR
total_price IS NULL OR
pizza_size IS NULL OR
pizza_category IS NULL OR
pizza_ingredients IS NULL OR
pizza_name IS NULL;

-- Data Exploration--

-- 1. Total Revenue:
SELECT SUM(total_price) AS total_revenue
FROM Pizza_Sales;

-- 2. Average Order Value:
SELECT SUM(total_price)/ COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM Pizza_Sales;

-- 3. Total Pizzas Sold
SELECT SUM(quantity) AS total_pizzas_sold
FROM Pizza_Sales;

-- 4. Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM Pizza_Sales;

-- 5. Average Pizzas Per Order
SELECT SUM(quantity) * 1.0 / COUNT(DISTINCT order_id) AS Avg_Pizzas_per_order
FROM pizza_sales;

-- 6. Daily Trend for Total Orders
SELECT DAYNAME(order_date) AS order_day,
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date), DAYOFWEEK(order_date)
ORDER BY DAYOFWEEK(order_date);

-- 7. Monthly Trend for Orders
SELECT MONTH(order_date) AS month_no,
	MONTHNAME(order_date) AS month_name,
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY MONTH(order_date);

-- 8. % of Sales by Pizza Category
SELECT pizza_category,
	SUM(total_price) AS total_revenue,
	(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales)) AS percentage_sales
FROM pizza_sales
GROUP BY pizza_category;

-- 9. % of Sales by Pizza Size
SELECT pizza_size,
	SUM(total_price) AS total_revenue,
	(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales)) AS percentage_sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY percentage_sales DESC;

-- 10. Total Pizzas Sold by Pizza Category
SELECT pizza_category,
	SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_pizzas_sold DESC;

-- 11. Top 5 Pizzas by Revenue
SELECT pizza_name,
	SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;

-- 12. Bottom 5 Pizzas by Revenue
SELECT pizza_name,
		SUM(total_price) AS total_revenue
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 5;

-- 13. Top 5 Pizzas Sold  by Quantity
SELECT pizza_name,
		SUM(quantity) AS total_pizza_sold
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY total_pizza_sold DESC
LIMIT 5;

-- 14. Bottom 5 Pizzas Sold by Quantity
SELECT pizza_name,
		SUM(quantity) AS total_pizza_sold
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY total_pizza_sold ASC
LIMIT 5;

-- 15. Top 5 Pizzas by Total Orders
SELECT pizza_name,
		COUNT(DISTINCT order_id) AS total_orders
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY total_orders DESC
LIMIT 5;

-- 16. Buttom 5 Pizzas by Total Orders
SELECT pizza_name,
		COUNT(DISTINCT order_id) AS total_orders
FROM Pizza_Sales
GROUP BY pizza_name
ORDER BY total_orders ASC
limit 5;