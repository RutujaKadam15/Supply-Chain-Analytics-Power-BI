/*
Project: Retail Supply Chain Analytics
Module: Database Creation And Data Importing Using BULK INSERT
Author: Rutuja Kadam
*/
-- * Create Database *
CREATE DATABASE retailsupplychain;
GO

USE retailsupplychain;

-- * Create Table *
CREATE TABLE SupplyChainData        
(
    [Type] VARCHAR(20),
    [Days for shipping (real)] INT,
    [Days for shipment (scheduled)] INT,
    [Benefit per order] DECIMAL(18,2),
    [Sales per customer] DECIMAL(18,2),
    [Delivery Status] VARCHAR(50),
    [Late_delivery_risk] INT,
    [Category Id] INT,
    [Category Name] VARCHAR(100),
    [Customer City] VARCHAR(100),
    [Customer Country] VARCHAR(100),
    [Customer Email] VARCHAR(150),
    [Customer Fname] VARCHAR(100),
    [Customer Id] INT,
    [Customer Lname] VARCHAR(100),
    [Customer Password] VARCHAR(100),
    [Customer Segment] VARCHAR(100),
    [Customer State] VARCHAR(100),
    [Customer Street] VARCHAR(255),
    [Customer Zipcode] INT,
    [Department Id] INT,
    [Department Name] VARCHAR(100),
    [Latitude] DECIMAL(10,6),
    [Longitude] DECIMAL(10,6),
    [Market] VARCHAR(100),
    [Order City] VARCHAR(100),
    [Order Country] VARCHAR(100),
    [Order Customer Id] INT,
    [order date (DateOrders)] VARCHAR(50),
    [Order Id] INT,
    [Order Item Cardprod Id] INT,
    [Order Item Discount] DECIMAL(18,2),
    [Order Item Discount Rate] DECIMAL(18,4),
    [Order Item Id] INT,
    [Order Item Product Price] DECIMAL(18,2),
    [Order Item Profit Ratio] DECIMAL(18,4),
    [Order Item Quantity] INT,
    [Sales] DECIMAL(18,2),
    [Order Item Total] DECIMAL(18,2),
    [Order Profit Per Order] DECIMAL(18,2),
    [Order Region] VARCHAR(100),
    [Order State] VARCHAR(100),
    [Order Status] VARCHAR(100),
    [Order Zipcode] FLOAT,
    [Product Card Id] INT,
    [Product Category Id] INT,
    [Product Description] VARCHAR(MAX),
    [Product Image] VARCHAR(500),
    [Product Name] VARCHAR(255),
    [Product Price] DECIMAL(18,2),
    [Product Status] INT,
    [shipping date (DateOrders)] VARCHAR(50),
    [Shipping Mode] VARCHAR(100)
);

SELECT * FROM supplychaindata;

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;

BULK INSERT SupplyChainData
FROM 'C:\Users\asdf\Downloads\DataCoSupplyChainDataset.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    CODEPAGE = '65001',
    TABLOCK
);

-- * Importing Data *

BULK INSERT SupplyChainData
FROM 'C:\sqldata\DataCoSupplyChainDataset.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    CODEPAGE = 'ACP',
    TABLOCK
);

SELECT * FROM SupplyChainData; 
sp_help SupplyChainData;


EXEC sp_rename 'SupplyChainData', 'retail_supply_chain';--change table name

SELECT * FROM retail_supply_chain;

--Rename Columns
EXEC sp_rename 'retail_supply_chain.[Customer Fname]', 'customer_fname', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Customer Lname]', 'customer_lname', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Customer City]', 'customer_city', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Customer Country]', 'customer_country', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Customer State]', 'customer_state', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Product Name]', 'product_name', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Product Price]', 'product_price', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Category Name]', 'category_name', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Category Id]', 'category_id', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Order Status]', 'order_status', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Order Id]', 'order_id', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Order Region]', 'order_region', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Order State]', 'order_state', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Shipping Mode]', 'shipping_mode', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Delivery Status]', 'delivery_status', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Benefit per order]', 'benefit_per_order', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Sales per customer]', 'sales_per_customer', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Late_delivery_risk]', 'late_delivery_risk', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Days for shipping (real)]', 'days_for_shipping_real', 'COLUMN';

EXEC sp_rename 'retail_supply_chain.[Days for shipment (scheduled)]', 'days_for_shipment_scheduled', 'COLUMN';

SELECT TOP 5 *
FROM retail_supply_chain;





