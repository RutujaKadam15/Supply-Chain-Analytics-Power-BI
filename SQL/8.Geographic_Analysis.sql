/*
Project: Retail Supply Chain Analytics
Module:Geographic Analysis
Author: Rutuja Kadam
*/

--Revenue by Country
SELECT
    customer_country,
    SUM(sales) AS total_revenue
FROM Supply_Chain_Data
GROUP BY customer_country
ORDER BY total_revenue DESC;

--Profit by Country
SELECT
    customer_country,
    SUM(benefit_per_order) AS total_profit
FROM Supply_Chain_Data
GROUP BY customer_country
ORDER BY total_profit DESC;

--Top 10 Cities by Revenue
SELECT TOP 10
    customer_city,
    SUM(sales) AS total_revenue
FROM Supply_Chain_Data
GROUP BY customer_city
ORDER BY total_revenue DESC;

--Top 10 States by Revenue
SELECT TOP 10
    customer_state,
    SUM(sales) AS total_revenue
FROM Supply_Chain_Data
GROUP BY customer_state
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

--Average Revenue by Country
SELECT
    customer_country,
    AVG(sales) AS average_revenue
FROM Supply_Chain_Data
GROUP BY customer_country
ORDER BY average_revenue DESC;

--Total Customers by Country
SELECT
    customer_country,
    COUNT(DISTINCT customer_id) AS total_customers
FROM Supply_Chain_Data
GROUP BY customer_country
ORDER BY total_customers DESC;

--Revenue per Customer by Country
SELECT
    customer_country,
    SUM(sales) / COUNT(DISTINCT customer_id) AS revenue_per_customer
FROM Supply_Chain_Data
GROUP BY customer_country
ORDER BY revenue_per_customer DESC;

--Geographic Performance Summary
SELECT
    customer_country,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(sales) AS total_revenue,
    SUM(benefit_per_order) AS total_profit
FROM Supply_Chain_Data
GROUP BY customer_country
ORDER BY total_revenue DESC;