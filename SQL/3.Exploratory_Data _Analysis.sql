/*
Project: Retail Supply Chain Analytics
Module:Exploratory Data Analysis
Author: Rutuja Kadam
*/

--1.Total Revenue
SELECT
    SUM(sales) AS total_revenue
FROM Supply_Chain_Data;

--2.Total SELECT
  SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM Supply_Chain_Data;

--3.Total Customers
SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM Supply_Chain_Data;

--4.Average Sales per Order
SELECT
    AVG(sales) AS average_sales
FROM Supply_Chain_Data;

--5.Total Profit
SELECT
    SUM(benefit_per_order) AS total_profit
FROM Supply_Chain_Data;

--6.Top 10 Products
SELECT TOP 10
    product_name,
    SUM(sales) AS total_sales
FROM Supply_Chain_Data
GROUP BY product_name
ORDER BY total_sales DESC;

--7.Top Categories
SELECT
    category_name,
    SUM(sales) AS total_sales
FROM Supply_Chain_Data
GROUP BY category_name
ORDER BY total_sales DESC;

--8.Sales by Customer Segment
SELECT
    customer_segment,
    SUM(sales) AS total_sales
FROM Supply_Chain_Data
GROUP BY customer_segment
ORDER BY total_sales DESC;

--9.Sales by Country
SELECT 
    customer_country,
    SUM(sales) AS total_sales
FROM Supply_Chain_Data
GROUP BY customer_country
ORDER BY total_sales DESC;

--10.Shipping Modes
SELECT
    shipping_mode,
    COUNT(*) AS total_orders
FROM Supply_Chain_Data
GROUP BY shipping_mode
ORDER BY total_orders DESC;
