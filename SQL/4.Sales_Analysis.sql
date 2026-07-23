/*
Project: Retail Supply Chain Analytics
Module: Sales Analysis
Author: Rutuja Kadam
*/
--Revenue by Category
SELECT
    category_name,
    SUM(sales) AS total_revenue
FROM Supply_Chain_Data
GROUP BY category_name
ORDER BY total_revenue DESC;

--Revenue by Market
SELECT
    market,
    SUM(sales) AS total_revenue
FROM Supply_Chain_Data
GROUP BY market
ORDER BY total_revenue DESC;

--Revenue by Region
SELECT
    order_region,
    SUM(sales) AS total_revenue
FROM Supply_Chain_Data
GROUP BY order_region
ORDER BY total_revenue DESC;

--Top 10 States
SELECT TOP 10
    order_state,
    SUM(sales) AS total_revenue
FROM Supply_Chain_Data
GROUP BY order_state
ORDER BY total_revenue DESC;

--Average Order Value
SELECT
    AVG(sales) AS average_order_value
FROM Supply_Chain_Data;