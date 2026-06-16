-- =====================================================
-- PRODUCT ANALYSIS
-- =====================================================

SELECT * FROM products;

--1. REVENUE BY CATEGORY
SELECT 
	p.category, 
	SUM(s.sales) AS total_revenue
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;


--2. REVENUE BY SUB_CATEGORY
SELECT 
	p.sub_category, 
	SUM(s.sales) AS total_revenue
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.sub_category
ORDER BY total_revenue DESC;



--3. PROFIT BY CATEGORY
SELECT 
	p.category, 
	SUM(s.profit) AS profit
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY profit DESC;



--4. PROFIT BY SUB_CATEGORY
SELECT 
	p.sub_category,
	ROUND(SUM(s.profit)) AS profit
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.sub_category
ORDER BY profit DESC;



--5. TOP 10 PRODUCTS BY REVENUE
SELECT 
	p.product_name,
	p.category, 
	SUM(s.sales) AS revenue
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.product_name, p.category
ORDER BY revenue DESC
LIMIT 10;



--6.  TOP 10 PRODUCTS BY PROFIT
SELECT 
	p.product_name,
	p.category, 
	SUM(s.profit) AS profit
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.product_name, p.category
ORDER BY profit DESC
LIMIT 10;



--7. PRODUCTS GENERATING LOSS
SELECT 
	p.product_name,
	p.category, 
	SUM(s.profit) AS profit
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.product_name, p.category
HAVING SUM(s.profit) < 0;



--8. TOP 10 MOST SOLD PRODUCTS
SELECT 
	p.product_name, 
	COUNT(DISTINCT s.order_id) AS sold_count
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY sold_count DESC
LIMIT 10;



--9. TOP 10 LEAST SOLD PRODUCTS
SELECT 
	p.product_name, 
	COUNT(DISTINCT s.order_id) AS sold_count
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY sold_count ASC
LIMIT 10;



--10. PRODUCTS SOLD BY CATEGORY 
SELECT 
	p.category, 
	COUNT(DISTINCT s.order_id) AS sold_count
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY sold_count DESC;



--11. PRODUCTS SOLD BY SUB_CATEGORY 
SELECT 
	p.sub_category, 
	COUNT(DISTINCT s.order_id) AS sold_count
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.sub_category
ORDER BY sold_count DESC;



--12. AVERAGE DISCOUNT BY CATEGORY
SELECT 
	p.category, 
	ROUND(AVG(s.discount),2) AS avg_discount
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY avg_discount DESC;



--13. AVERAGE DISCOUNT BY SUB_CATEGORY
SELECT 
	p.sub_category, 
	ROUND(AVG(s.discount),2) AS avg_discount
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.sub_category
ORDER BY avg_discount DESC;



--14. TOP 10 MOST DISCOUNTED PRODUCTS
SELECT 
	p.product_name, 
	ROUND(AVG(s.discount),2) AS discount
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY discount DESC
LIMIT 10;



--15. TOP 10 LEAST DISCOUNTED PRODUCTS
SELECT 
	p.product_name, 
	ROUND(AVG(s.discount),2) AS discount
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY discount ASC
LIMIT 10;



--16. PROFIT MARGIN BY CATEGORY
SELECT
    p.category,
    ROUND(
        SUM(s.profit) * 100.0 /
        SUM(s.sales),2) 
		AS profit_margin_pct
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY profit_margin_pct DESC;



--17. PROFIT MARGIN BY SUB_CATEGORY
SELECT
    p.sub_category,
    ROUND(
        SUM(s.profit) * 100.0 /
        SUM(s.sales),2) 
		AS profit_margin_pct
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.sub_category
ORDER BY profit_margin_pct DESC;



--18.CATEGORY REVENUE CONTRIBUTION
SELECT
    p.category,
    ROUND(SUM(s.sales),2) AS revenue,
    ROUND(
        SUM(s.sales) * 100.0 /
        (SELECT SUM(sales) FROM sales),
    2) AS revenue_pct
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;



--19. CATEGORIES WITH MOST LOSS MAKING PRODUCTS
SELECT
    p.category,
    COUNT(*) AS loss_products
FROM (
    SELECT
        product_id
    FROM sales
    GROUP BY product_id
    HAVING SUM(profit) < 0
) lp
JOIN products p
ON lp.product_id = p.product_id
GROUP BY p.category
ORDER BY loss_products DESC;



--20. RELATIONSHIP BETWEEN DISCOUNT AND PROFIT
SELECT
    ROUND(discount,2) AS discount,
    ROUND(AVG(profit),2) AS avg_profit
FROM sales
GROUP BY discount
ORDER BY discount;