/*
Project: Retail Supply Chain Analytics
Module: Product Analysis
Author: Rutuja Kadam
Description: Product performance analysis using aggregate functions.
*/

--Top 10 Best Selling Products
SELECT TOP 10
    product_name,
    SUM(sales) AS total_sales
FROM Supply_Chain_Data
GROUP BY product_name
ORDER BY total_sales DESC;

----Bottom 10 Best Selling Products
SELECT TOP 10
    product_name,
    SUM(sales) AS total_sales
FROM Supply_Chain_Data
GROUP BY product_name
ORDER BY total_sales ASC;

--Top Products by Profit
SELECT TOP 10
    product_name,
    SUM(benefit_per_order) AS total_profit
FROM Supply_Chain_Data
GROUP BY product_name
ORDER BY total_profit DESC;

--Which products are causing losses?
SELECT
    product_name,
    SUM(benefit_per_order) AS total_profit
FROM Supply_Chain_Data
GROUP BY product_name
HAVING SUM(benefit_per_order) < 0
ORDER BY total_profit;

--Average Product Price by Category
SELECT
    category_name,
    AVG(product_price) AS average_price
FROM Supply_Chain_Data
GROUP BY category_name
ORDER BY average_price DESC;

--Number of Products in Each Category
SELECT
    category_name,
    COUNT(DISTINCT product_name) AS total_products
FROM Supply_Chain_Data
GROUP BY category_name
ORDER BY total_products DESC;

--Total Quantity Sold by Product
SELECT TOP 10
    product_name,
    SUM(order_item_quantity) AS total_quantity
FROM Supply_Chain_Data
GROUP BY product_name
ORDER BY total_quantity DESC;

--Highest Revenue Categories
SELECT
    category_name,
    SUM(sales) AS total_revenue
FROM Supply_Chain_Data
GROUP BY category_name
ORDER BY total_revenue DESC;

--Highest Profit Categories
SELECT
    category_name,
    SUM(benefit_per_order) AS total_profit
FROM Supply_Chain_Data
GROUP BY category_name
ORDER BY total_profit DESC;

--Product Performance Summary
SELECT
    product_name,
    SUM(sales) AS total_sales,
    SUM(benefit_per_order) AS total_profit,
    AVG(product_price) AS average_price
FROM Supply_Chain_Data
GROUP BY product_name
ORDER BY total_sales DESC;

