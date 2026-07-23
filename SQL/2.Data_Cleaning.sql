/*
Project: Retail Supply Chain Analytics
Module: Understanding Data And Data Cleaning
Author: Rutuja Kadam
*/

--Count Records
SELECT COUNT(*) AS Total_Records
FROM Supply_Chain_Data;

--View the Data
SELECT TOP 10 *
FROM Supply_Chain_Data;

--List All Columns
SELECT COLUMN_NAME,
       DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='Supply_Chain_Data';

--Understand the Table Structure
sp_help Supply_Chain_Data;

--* Data Cleaning *

--Count total rows
SELECT COUNT(*) AS total_records
FROM Supply_Chain_Data;

--View sample data
SELECT TOP 10 *
FROM Supply_Chain_Data;

--Check table structure
EXEC sp_help Supply_Chain_Data;

--Find NULL values
SELECT
    COUNT(*) AS total_rows,
    COUNT(customer_fname) AS customer_fname,
    COUNT(customer_lname) AS customer_lname,
    COUNT(customer_city) AS customer_city,
    COUNT(customer_country) AS customer_country,
    COUNT(product_name) AS product_name,
    COUNT(category_name) AS category_name,
    COUNT(order_id) AS order_id,
    COUNT(sales) AS sales,
    COUNT(product_price) AS product_price
FROM Supply_Chain_Data;

--Check duplicates
SELECT
    order_id,
    COUNT(*) AS total_records
FROM Supply_Chain_Data
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY total_records DESC;

--Check Distinct Customer Segments
SELECT DISTINCT customer_segment
FROM Supply_Chain_Data;

--Check Delivery Status
SELECT
    delivery_status,
    COUNT(*) AS total_orders
FROM Supply_Chain_Data
GROUP BY delivery_status
ORDER BY total_orders DESC;

--Check Shipping Modes
SELECT
    shipping_mode,
    COUNT(*) AS total_orders
FROM Supply_Chain_Data
GROUP BY shipping_mode
ORDER BY total_orders DESC;

--Check Category Names
SELECT
    category_name,
    COUNT(*) AS total_products
FROM Supply_Chain_Data
GROUP BY category_name
ORDER BY total_products DESC;

--Check Negative Values
SELECT *
FROM Supply_Chain_Data
WHERE sales < 0
   OR product_price < 0
   OR benefit_per_order < 0;

--Check Blank Strings
SELECT *
FROM Supply_Chain_Data
WHERE customer_fname = ''
   OR customer_lname = ''
   OR customer_city = '';

--Check Date Columns
SELECT
    MIN(order_date_dateOrders) AS first_order,
    MAX(order_date_DateOrders) AS last_order
FROM Supply_Chain_Data;

SELECT * FROM supply_chain_data
