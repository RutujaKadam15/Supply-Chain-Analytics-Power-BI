-- Customer Analysis.

--Top 10 Customers by Revenue
SELECT TOP 10
    customer_id,
    customer_fname,
    customer_lname,
    SUM(sales) AS total_revenue
FROM Supply_Chain_Data
GROUP BY
    customer_id,
    customer_fname,
    customer_lname
ORDER BY total_revenue DESC;

--Top 10 Customers by Profit
SELECT TOP 10
    customer_id,
    customer_fname,
    customer_lname,
    SUM(benefit_per_order) AS total_profit
FROM Supply_Chain_Data
GROUP BY
    customer_id,
    customer_fname,
    customer_lname
ORDER BY total_profit DESC;

--Top 10 Customers by Profit
SELECT TOP 10 
    customer_id,
    customer_fname,
    customer_lname,
    SUM(benefit_per_order) AS total_profit
FROM Supply_Chain_Data
GROUP BY
    customer_id,
    customer_fname,
    customer_lname
ORDER BY total_profit DESC;

--Which customer segment contributes the highest sales?
SELECT
    customer_segment,
    SUM(sales) AS total_sales
FROM Supply_Chain_Data
GROUP BY customer_segment
ORDER BY total_sales DESC;

--Customer Segment Profit
SELECT
    customer_segment,
    SUM(benefit_per_order) AS total_profit
FROM Supply_Chain_Data
GROUP BY customer_segment
ORDER BY total_profit DESC;

--Customers by Country
SELECT TOP 10
    customer_country,
    COUNT(DISTINCT customer_id) AS total_customers
FROM Supply_Chain_Data
GROUP BY customer_country
ORDER BY total_customers DESC;

--Customers by State
SELECT TOP 10
    customer_state,
    COUNT(DISTINCT customer_id) AS total_customers
FROM Supply_Chain_Data
GROUP BY customer_state
ORDER BY total_customers DESC;

--Customers by City
SELECT TOP 10
    customer_city,
    COUNT(DISTINCT customer_id) AS total_customers
FROM Supply_Chain_Data
GROUP BY customer_city
ORDER BY total_customers DESC;

--Average Spending per Customer
SELECT
    customer_id,
    customer_fname,
    customer_lname,
    AVG(sales) AS average_spending
FROM Supply_Chain_Data
GROUP BY
    customer_id,
    customer_fname,
    customer_lname
ORDER BY average_spending DESC;

--Number of Orders per Customer
SELECT TOP 10
    customer_id,
    customer_fname,
    customer_lname,
    COUNT(DISTINCT order_id) AS total_orders
FROM Supply_Chain_Data
GROUP BY
    customer_id,
    customer_fname,
    customer_lname
ORDER BY total_orders DESC;

--How much revenue has each customer generated over all their orders?
SELECT TOP 10
    customer_id,
    customer_fname,
    customer_lname,
    SUM(sales) AS lifetime_revenue
FROM Supply_Chain_Data
GROUP BY
    customer_id,
    customer_fname,
    customer_lname
ORDER BY lifetime_revenue DESC;
