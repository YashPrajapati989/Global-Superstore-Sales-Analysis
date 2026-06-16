-- =====================================================
-- CUSTOMER ANALYSIS
-- =====================================================


--1. REVENUE BY COUNTRY
SELECT 
	l.country,
	ROUND(SUM(s.sales)) AS revenue
FROM sales s
JOIN locations l
ON s.location_id = l.location_id
GROUP BY l.country
ORDER BY revenue DESC;


--2. TOP 10 COUNTRIES BY REVENUE
SELECT 
	l.country,
	ROUND(SUM(s.sales)) AS revenue
FROM sales s
JOIN locations l
ON s.location_id = l.location_id
GROUP BY l.country
ORDER BY revenue DESC
LIMIT 10;



--3. PROFIT BY COUNTRY
SELECT 
	l.country,
	ROUND(SUM(s.profit)) AS profit
FROM sales s
JOIN locations l
ON s.location_id = l.location_id
GROUP BY l.country
ORDER BY profit DESC;


--4. TOP 10 COUNTRIES BY PROFIT
SELECT 
	l.country,
	ROUND(SUM(s.profit)) AS profit
FROM sales s
JOIN locations l
ON s.location_id = l.location_id
GROUP BY l.country
ORDER BY profit DESC
LIMIT 10;



--5. REVENUE BY REGION
SELECT 
	l.region,
	ROUND(SUM(s.sales)) AS revenue
FROM sales s
JOIN locations l
ON s.location_id = l.location_id
GROUP BY l.region
ORDER BY revenue DESC;



--6. PROFIT BY REGION
SELECT 
	l.region,
	ROUND(SUM(s.profit)) AS profit
FROM sales s
JOIN locations l
ON s.location_id = l.location_id
GROUP BY l.region
ORDER BY profit DESC;


--7. REVENUE BY MARKET
SELECT 
	l.market,
	ROUND(SUM(s.sales)) AS revenue
FROM sales s
JOIN locations l
ON s.location_id = l.location_id
GROUP BY l.market
ORDER BY revenue DESC;



--8. TOP 10 CITIES BY REVENUE
SELECT 
	l.city,
	ROUND(SUM(s.sales)) AS revenue
FROM sales s
JOIN locations l
ON s.location_id = l.location_id
GROUP BY l.city
ORDER BY revenue DESC
LIMIT 10;



--9. TOP 10 CITIES BY PROFIT
SELECT 
	l.city,
	ROUND(SUM(s.profit)) AS profit
FROM sales s
JOIN locations l
ON s.location_id = l.location_id
GROUP BY l.city
ORDER BY profit DESC
LIMIT 10;



--10. LOSS MAKING COUNTRIES
SELECT 
	l.country,
	ROUND(SUM(s.profit)) AS profit
FROM sales s
JOIN locations l
ON s.location_id = l.location_id
GROUP BY l.country
HAVING ROUND(SUM(s.profit)) < 0
ORDER BY profit;


--11. PROFIT MARGIN BY COUNTRY
SELECT
    l.country,
    ROUND(
        SUM(s.profit) * 100.0 /
        SUM(s.sales),
    2) AS profit_margin_pct
FROM sales s
JOIN locations l
ON s.location_id = l.location_id
GROUP BY l.country
ORDER BY profit_margin_pct DESC;


--12. REVENUE CONTRIBUTED BY REGION
SELECT
    l.region,
    ROUND(SUM(s.sales),2) AS revenue,
    ROUND(
        SUM(s.sales) * 100.0 /
        (SELECT SUM(sales) FROM sales),
    2) AS revenue_pct
FROM sales s
JOIN locations l
ON s.location_id = l.location_id
GROUP BY l.region
ORDER BY revenue DESC;