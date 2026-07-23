/*
Project: Retail Supply Chain Analytics
Module:Supply Chain Analysis
Author: Rutuja Kadam
*/

--Which shipping mode is used the most?
SELECT
    shipping_mode,
    COUNT(*) AS total_orders
FROM Supply_Chain_Data
GROUP BY shipping_mode
ORDER BY total_orders DESC;

--Orders by Delivery Status
SELECT
    delivery_status,
    COUNT(*) AS total_orders
FROM Supply_Chain_Data
GROUP BY delivery_status
ORDER BY total_orders DESC;

--How many orders are at risk of being delivered late?
SELECT
    late_delivery_risk,    ---0 = no risk , 1 = risk
    COUNT(*) AS total_orders
FROM Supply_Chain_Data
GROUP BY late_delivery_risk;

--Average Actual Shipping Days
SELECT
    AVG(days_for_shipping_real) AS average_shipping_days
FROM Supply_Chain_Data;

--Average Scheduled Shipping Days
SELECT
    AVG(days_for_shipment_scheduled) AS Scheduled_Shipping_Days  
FROM Supply_Chain_Data;

--Compare Scheduled vs Actual Shipping
SELECT
    AVG(days_for_shipment_scheduled) AS scheduled_days,
    AVG(days_for_shipping_real) AS actual_days
FROM Supply_Chain_Data;

--Shipping Performance by Mode
--This helps identify which shipping mode is the fastest.
SELECT
    shipping_mode,
    AVG(days_for_shipping_real) AS average_shipping_days
FROM Supply_Chain_Data
GROUP BY shipping_mode
ORDER BY average_shipping_days;

--Delivery Status by Shipping Mode
SELECT
    shipping_mode,
    delivery_status,
    COUNT(*) AS total_orders
FROM Supply_Chain_Data
GROUP BY
    shipping_mode,
    delivery_status
ORDER BY
    shipping_mode,
    total_orders DESC;

--Regions with Highest Late Delivery Risk
SELECT
    order_region,
    SUM(late_delivery_risk) AS total_late_orders
FROM Supply_Chain_Data
GROUP BY order_region
ORDER BY total_late_orders DESC;

SELECT
    order_region,
    SUM(CAST(late_delivery_risk AS INT)) AS total_late_orders
FROM Supply_Chain_Data
GROUP BY order_region
ORDER BY total_late_orders DESC;

--Which shipping mode handles the highest revenue?
SELECT
    shipping_mode,
    SUM(sales) AS total_revenue
FROM Supply_Chain_Data
GROUP BY shipping_mode
ORDER BY total_revenue DESC;


