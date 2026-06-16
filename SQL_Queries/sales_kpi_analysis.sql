-- =====================================================
-- SALES KPI ANALYSIS
-- =====================================================

SELECT * FROM sales;


--1.TOTAL SALES GENERATED
SELECT 
	ROUND(SUM(sales)) 
	AS total_sales_generated 
FROM sales;


--2.TOTAL PROFIT EARNED
SELECT 
	ROUND(SUM(profit)) 
	AS total_profit
FROM sales;


--3.TOTAL QUANTITY SOLD
SELECT 
	SUM(quantity) 
	AS total_quantity_sold
FROM sales;


--4.AVERAGE SALES PER ORDER
SELECT 
	ROUND(SUM(sales) / COUNT(DISTINCT order_id)) 
	AS average_sales_per_order
FROM sales;


--5.TOTAL NUMBER OF ORDERS
SELECT 
	COUNT(DISTINCT order_id) 
	AS total_orders
FROM sales;


--6.TOTAL PROFIT EARNED
SELECT 
	ROUND(SUM(profit),2) 
	AS total_profit
FROM sales;


--7.TOTAL CUSTOMERS
SELECT 
	COUNT(DISTINCT customer_id) 
	AS total_customers
FROM sales;


--8.TOTAL PRODUCTS SOLD
SELECT 
	SUM(quantity) 
	AS total_quantity
FROM sales;


--9.PROFIT MARGIN %
SELECT 
	ROUND(
    	SUM(profit) * 100 / SUM(sales),2) 
		AS profit_margin_pct
FROM sales;


--10.AVERAGE DISCOUNT
SELECT 
	ROUND(AVG(discount),2)
FROM sales;

--11.AVERAGE SHIPPING COST
SELECT 
	ROUND(AVG(shipping_cost),2)
FROM sales;


--12.AVERGAE DELIVERY DAYS
SELECT 
	ROUND(
    	AVG(ship_date - order_date),
	2)
FROM orders;

