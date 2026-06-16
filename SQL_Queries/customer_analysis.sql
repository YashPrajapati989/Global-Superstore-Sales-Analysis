-- =====================================================
-- CUSTOMER ANALYSIS
-- =====================================================


--1. TOP 10 CUSTOMERS BY REVENUE
SELECT 
	c.customer_name,
	ROUND(SUM(s.sales)) AS revenue
FROM sales s 
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY revenue DESC
LIMIT 10;


--2. TOP 10 CUSTOMERS BY PROFIT
SELECT 
	c.customer_name,
	ROUND(SUM(s.profit)) AS profit
FROM sales s 
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY profit DESC
LIMIT 10;


--3. FIND CUSTOMER LIFETIME VALUE
SELECT 
	c.customer_name,
	ROUND(SUM(s.sales)) AS CLV
FROM sales s 
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY CLV DESC;


--4. TOP 10 CUSTOMERS WITH MOST ORDERS
SELECT 
	c.customer_name,
	COUNT(DISTINCT s.order_id) AS total_orders
FROM sales s 
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC
LIMIT 10;



--5. REVENUE BY CUSTOMER SEGMENT
SELECT 
	c.segment,
	ROUND(SUM(s.sales)) AS revenue
FROM sales s 
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY revenue DESC;



--6. PROFIT BY CUSTOMER SEGMENT
SELECT 
	c.segment,
	ROUND(SUM(s.profit)) AS profit
FROM sales s 
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY profit DESC;



--7. AVERAGE ORDER VALUE BY CUSTOMER SEGMENT
SELECT
    c.segment,
    ROUND(
        SUM(s.sales) /
        COUNT(DISTINCT s.order_id),
    2) AS avg_order_value
FROM sales s
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY avg_order_value DESC;



--8. CUSTOMERS GENERATING LOSSES
SELECT
    c.customer_name,
    ROUND(SUM(s.profit),2) AS total_profit
FROM sales s
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING SUM(s.profit) < 0
ORDER BY total_profit;



--9. TOP CUSTOMERS BY QUANTITY PURCHASED
SELECT 
	c.customer_name,
	SUM(s.quantity) AS total_quantity
FROM sales s 
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_quantity DESC
LIMIT 10;



--10. REVENUE CONTRIBUTION BY SEGMENT
SELECT
    c.segment,
    ROUND(SUM(s.sales),2) AS revenue,
    ROUND(
        SUM(s.sales) * 100.0 /
        (SELECT SUM(sales) FROM sales),
    2) AS revenue_pct
FROM sales s
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY revenue DESC;


--11. MOST VALUABLE CUSTOMER
SELECT
    c.customer_name,
    COUNT(DISTINCT s.order_id) AS total_orders
FROM sales s
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING COUNT(DISTINCT s.order_id) > 10
ORDER BY total_orders DESC;