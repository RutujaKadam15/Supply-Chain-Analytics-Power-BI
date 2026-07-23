/*
Project: Retail Supply Chain Analytics
Module:Advanced SQL 
Author: Rutuja Kadam */

--CASE Statement
--Categorize every order based on sales amount.
SELECT
    order_id,
    sales,
    CASE
        WHEN sales < 100 THEN 'Low Sale'
        WHEN sales BETWEEN 100 AND 500 THEN 'Medium Sale'
        ELSE 'High Sale'
    END AS sales_category
FROM Supply_Chain_Data;

--Categorize Profit
SELECT
    order_id,
    benefit_per_order,
    CASE
        WHEN benefit_per_order < 0 THEN 'Loss'
        WHEN benefit_per_order = 0 THEN 'Break Even'
        ELSE 'Profit'
    END AS profit_status
FROM Supply_Chain_Data;

--Delivery Risk
SELECT
    order_id,
    late_delivery_risk,
    CASE
        WHEN late_delivery_risk = 1 THEN 'Late Delivery'
        ELSE 'On Time'
    END AS delivery_status
FROM Supply_Chain_Data;

--Shipping Speed
SELECT
    order_id,
    days_for_shipping_real,
    CASE
        WHEN days_for_shipping_real <= 2 THEN 'Fast'
        WHEN days_for_shipping_real <= 5 THEN 'Normal'
        ELSE 'Slow'
    END AS shipping_speed
FROM Supply_Chain_Data;

--Delivery Risk
SELECT
    order_id,
    late_delivery_risk,
    CASE
        WHEN late_delivery_risk = 1 THEN 'Risky'
        ELSE 'Safe'
    END AS delivery_risk
FROM Supply_Chain_Data;

--Product Price Category
SELECT
    product_name,
    product_price,
    CASE
        WHEN product_price < 100 THEN 'Budget'
        WHEN product_price BETWEEN 100 AND 500 THEN 'Mid Range'
        ELSE 'Premium'
    END AS price_category
FROM Supply_Chain_Data;

---Common Table Expression
--Customers with Above Average Sales
WITH CustomerSales AS
(
    SELECT
        customer_id,
        customer_fname,
        customer_lname,
        SUM(sales) AS total_sales
    FROM Supply_Chain_Data
    GROUP BY
        customer_id,
        customer_fname,
        customer_lname
)

SELECT
    customer_id,
    customer_fname,
    customer_lname,
    total_sales
FROM CustomerSales
WHERE total_sales >
(
    SELECT AVG(total_sales)
    FROM CustomerSales
)
ORDER BY total_sales DESC;

--Top Products by Revenue
WITH ProductSales AS
(
    SELECT
        product_name,
        SUM(sales) AS total_sales
    FROM Supply_Chain_Data
    GROUP BY product_name
)

SELECT TOP 10
    product_name,
    total_sales
FROM ProductSales
ORDER BY total_sales DESC;

--Category Profit Summary
WITH CategoryProfit AS
(
    SELECT
        category_name,
        SUM(benefit_per_order) AS total_profit
    FROM Supply_Chain_Data
    GROUP BY category_name
)

SELECT
    category_name,
    total_profit
FROM CategoryProfit
WHERE total_profit > 100000
ORDER BY total_profit DESC;

--Region-wise Sales
WITH RegionSales AS
(
    SELECT
        order_region,
        SUM(sales) AS total_sales
    FROM Supply_Chain_Data
    GROUP BY order_region
)

SELECT
    order_region,
    total_sales
FROM RegionSales
ORDER BY total_sales DESC;

--Window Functions
--Rank Products by Sales
SELECT
    product_name,
    SUM(sales) AS total_sales,
    ROW_NUMBER() OVER (
        ORDER BY SUM(sales) DESC
    ) AS row_num
FROM Supply_Chain_Data
GROUP BY product_name;

--Rank Customers by Revenue
SELECT
    customer_id,
    customer_fname,
    customer_lname,
    SUM(sales) AS total_sales,
    ROW_NUMBER() OVER (
        ORDER BY SUM(sales) DESC
    ) AS customer_rank
FROM Supply_Chain_Data
GROUP BY
    customer_id,
    customer_fname,
    customer_lname;

--Highest Revenue Product in Each Category
SELECT
    category_name,
    product_name,
    SUM(sales) AS total_sales,
    ROW_NUMBER() OVER (PARTITION BY category_name ORDER BY SUM(sales) DESC)AS row_num
FROM Supply_Chain_Data
GROUP BY
    category_name,
    product_name;

----Top Selling Product from Each Category
WITH ProductRank AS
(
    SELECT
        category_name,
        product_name,
        SUM(sales) AS total_sales,
        ROW_NUMBER() OVER(PARTITION BY category_name ORDER BY SUM(sales) DESC)AS row_num
    FROM Supply_Chain_Data
    GROUP BY
        category_name,
        product_name
)

SELECT
    category_name,
    product_name,
    total_sales
FROM ProductRank
WHERE row_num = 1
ORDER BY category_name;

--Most Profitable Customer in Each Country
WITH CustomerProfit AS
(
    SELECT
        customer_country,
        customer_id,
        customer_fname,
        customer_lname,
        SUM(benefit_per_order) AS total_profit,
        ROW_NUMBER() OVER
        (PARTITION BY customer_country ORDER BY SUM(benefit_per_order) DESC) AS row_num
    FROM Supply_Chain_Data
    GROUP BY
        customer_country,
        customer_id,
        customer_fname,
        customer_lname
)

SELECT
    customer_country,
    customer_id,
    customer_fname,
    customer_lname,
    total_profit
FROM CustomerProfit
WHERE row_num = 1
ORDER BY customer_country;

--Rank Products by Sales
SELECT
    product_name,
    SUM(sales) AS total_sales,
    RANK() OVER(ORDER BY SUM(sales) DESC) AS sales_rank
FROM Supply_Chain_Data
GROUP BY product_name;

---Top 3 Products in Each Category
WITH ProductRank AS
(
    SELECT
        category_name,
        product_name,
        SUM(sales) AS total_sales,
        RANK() OVER( PARTITION BY category_name ORDER BY SUM(sales) DESC) AS sales_rank
    FROM Supply_Chain_Data
    GROUP BY
        category_name,
        product_name
)

SELECT
    category_name,
    product_name,
    total_sales,
    sales_rank
FROM ProductRank
WHERE sales_rank <= 3
ORDER BY
    category_name,
    sales_rank;

--Dense Rank Products
SELECT
    product_name,
    SUM(sales) AS total_sales,
    DENSE_RANK() OVER(ORDER BY SUM(sales) DESC) AS dense_rank
FROM Supply_Chain_Data
GROUP BY product_name;

--Dense Rank Customers
SELECT
    customer_id,
    customer_fname,
    customer_lname,
    SUM(sales) AS total_sales,
    DENSE_RANK() OVER (ORDER BY SUM(sales) DESC) AS customer_rank
FROM Supply_Chain_Data
GROUP BY
    customer_id,
    customer_fname,
    customer_lname;

--Dense Rank Products by Category
SELECT
    category_name,
    product_name,
    SUM(sales) AS total_sales,
    DENSE_RANK() OVER(PARTITION BY category_name ORDER BY SUM(sales) DESC) AS category_rank
FROM Supply_Chain_Data
GROUP BY
    category_name,
    product_name;

---NTILE()
--Divide Customers into 4 Revenue Groups
SELECT
    customer_id,
    customer_fname,
    customer_lname,
    SUM(sales) AS total_sales,
    NTILE(4) OVER(ORDER BY SUM(sales) DESC) AS revenue_quartile
FROM Supply_Chain_Data
GROUP BY
    customer_id,
    customer_fname,
    customer_lname;

---Divide Products into 5 Sales Groups
SELECT
    product_name,
    SUM(sales) AS total_sales,
    NTILE(5) OVER( ORDER BY SUM(sales) DESC) AS product_group
FROM Supply_Chain_Data
GROUP BY product_name;

--Divide Countries into 3 Revenue Tiers
SELECT
    customer_country,
    SUM(sales) AS total_sales,
    NTILE(3) OVER
    (
        ORDER BY SUM(sales) DESC
    ) AS country_tier
FROM Supply_Chain_Data
GROUP BY customer_country;

---LAG()
---Compare Product Sales
SELECT
    product_name,
    SUM(sales) AS total_sales,
    LEAD(SUM(sales)) OVER
    (
        ORDER BY SUM(sales) DESC
    ) AS next_product_sales
FROM Supply_Chain_Data
GROUP BY product_name;

--Compare Customer Revenue
SELECT
    customer_id,
    SUM(sales) AS total_sales,
    LEAD(SUM(sales)) OVER
    (
        ORDER BY SUM(sales) DESC
    ) AS next_customer_sales
FROM Supply_Chain_Data
GROUP BY customer_id;

----Difference Between Current and Previous Product
WITH ProductSales AS
(
    SELECT
        product_name,
        SUM(sales) AS total_sales
    FROM Supply_Chain_Data
    GROUP BY product_name
)
SELECT
    product_name,
    total_sales,
    LAG(total_sales) OVER(ORDER BY total_sales DESC)AS previous_sales,
    total_sales - LAG(total_sales) OVER(ORDER BY total_sales DESC) AS sales_difference
FROM ProductSales;

--Running Total
--Running Total of Product Sales
WITH ProductSales AS
(
    SELECT
        product_name,
        SUM(sales) AS total_sales
    FROM Supply_Chain_Data
    GROUP BY product_name
)
SELECT
    product_name,
    total_sales,
    ROUND (SUM(total_sales) OVER(ORDER BY total_sales DESC),2)AS running_total
FROM ProductSales;

--Running Total by Customer
WITH CustomerSales AS
(
    SELECT
        customer_id,
        customer_fname,
        customer_lname,
        SUM(sales) AS total_sales
    FROM Supply_Chain_Data
    GROUP BY
        customer_id,
        customer_fname,
        customer_lname
)
SELECT
    customer_id,
    customer_fname,
    customer_lname,
    total_sales,
    ROUND (SUM(total_sales) OVER(ORDER BY total_sales DESC),2) AS running_total
FROM CustomerSales;

--Moving Average of Product Sales
WITH ProductSales AS
(
    SELECT
        product_name,
        SUM(sales) AS total_sales
    FROM Supply_Chain_Data
    GROUP BY product_name
)
SELECT
    product_name,
    total_sales,
    ROUND(AVG(total_sales) OVER
    (ORDER BY total_sales DESC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ),2) AS moving_average
FROM ProductSales;

--View
--Create Sales Summary View
CREATE VIEW vw_sales_summary AS
SELECT
    category_name,
    SUM(sales) AS total_sales,
    SUM(benefit_per_order) AS total_profit
FROM Supply_Chain_Data
GROUP BY category_name;

SELECT *
FROM vw_sales_summary;

--Create Customer Summary View
CREATE VIEW vw_customer_summary AS
SELECT
    customer_id,
    customer_fname,
    customer_lname,
    SUM(sales) AS total_sales
FROM Supply_Chain_Data
GROUP BY
    customer_id,
    customer_fname,
    customer_lname;

SELECT *
FROM vw_customer_summary; 

--Subqueries
---Products Above Average Sales
SELECT
    product_name,
    SUM(sales) AS total_sales
FROM Supply_Chain_Data
GROUP BY product_name
HAVING SUM(sales) >
(
    SELECT AVG(product_sales)
    FROM
    (
        SELECT SUM(sales) AS product_sales
        FROM Supply_Chain_Data
        GROUP BY product_name
    ) AS AvgSales
);

--Customers Above Average Revenue
SELECT
    customer_id,
    customer_fname,
    customer_lname,
    SUM(sales) AS total_sales
FROM Supply_Chain_Data
GROUP BY
    customer_id,
    customer_fname,
    customer_lname
HAVING SUM(sales) >
(
    SELECT AVG(customer_sales)
    FROM
    (
        SELECT SUM(sales) AS customer_sales
        FROM Supply_Chain_Data
        GROUP BY customer_id
    ) AS AvgCustomerSales
);

--Highest Selling Product in Each Category
SELECT
    p1.category_name,
    p1.product_name,
    SUM(p1.sales) AS total_sales
FROM Supply_Chain_Data p1
GROUP BY
    p1.category_name,
    p1.product_name
HAVING SUM(p1.sales) >= ALL
(
    SELECT SUM(p2.sales)
    FROM Supply_Chain_Data p2
    WHERE p2.category_name = p1.category_name
    GROUP BY p2.product_name
);

--Top Customer in Each Country
SELECT
    s1.customer_country,
    s1.customer_id,
    s1.customer_fname,
    s1.customer_lname,
    SUM(s1.sales) AS total_sales
FROM Supply_Chain_Data s1
GROUP BY
    s1.customer_country,
    s1.customer_id,
    s1.customer_fname,
    s1.customer_lname
HAVING SUM(s1.sales) >= ALL
(
    SELECT SUM(s2.sales)
    FROM Supply_Chain_Data s2
    WHERE s2.customer_country = s1.customer_country
    GROUP BY s2.customer_id
);