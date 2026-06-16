-- =====================================================
-- SHIPPING ANALYSIS
-- =====================================================



--1. AVERAGE DELIVERY TIME
SELECT 
	ROUND(AVG(ship_date  - order_date),2) AS avg_delivery_days
FROM orders;



--2. FASTEST SHIP MODE
SELECT 
	ship_mode,
	ROUND(AVG(ship_date  - order_date),2) AS avg_delivery_days
FROM orders
GROUP BY ship_mode
ORDER BY avg_delivery_days DESC;


--3. ORDERS BY SHIP MODE
SELECT
	ship_mode,
	COUNT(*) AS total_orders
FROM orders
GROUP BY ship_mode
ORDER BY total_orders DESC;


--4. REVENUE BY SHIP MODE
SELECT
	o.ship_mode,
	SUM(s.sales) AS revenue
FROM sales s
JOIN orders o
ON s.order_id = o.order_id
GROUP BY o.ship_mode
ORDER BY revenue DESC;


--5. PROFIT BY SHIP MODE
SELECT
	o.ship_mode,
	SUM(s.profit) AS profit
FROM sales s
JOIN orders o
ON s.order_id = o.order_id
GROUP BY o.ship_mode
ORDER BY profit DESC;



--6. AVERAGE SHIPPING COST BY SHIP MODE
SELECT
	o.ship_mode,
	ROUND(AVG(s.shipping_cost)) AS avg_shipping_cost
FROM sales s
JOIN orders o
ON s.order_id = o.order_id
GROUP BY o.ship_mode
ORDER BY avg_shipping_cost DESC;


--7. SHIP MODE PROFIT MARGIN
SELECT
    o.ship_mode,
    ROUND(
        SUM(s.profit) * 100.0 /
        SUM(s.sales),
    2) AS profit_margin_pct
FROM sales s
JOIN orders o
ON s.order_id = o.order_id
GROUP BY o.ship_mode
ORDER BY profit_margin_pct DESC;


--8. PRIORITY WISE ORDERS
SELECT 
	order_priority,
	COUNT(*) AS total_orders
FROM orders
GROUP BY order_priority
ORDER BY total_orders DESC;



--9. AVERAGE DELIVERY TIME BY PRIORITY
SELECT 
	order_priority,
	ROUND(AVG(ship_date  - order_date),2) AS avg_delivery_days
FROM orders
GROUP BY order_priority
ORDER BY avg_delivery_days ASC;



--10.REVENUE BY ORDER PRIORITY
SELECT
	o.order_priority,
	SUM(s.sales) AS revenue
FROM sales s
JOIN orders o
ON s.order_id = o.order_id
GROUP BY o.order_priority
ORDER BY revenue DESC;