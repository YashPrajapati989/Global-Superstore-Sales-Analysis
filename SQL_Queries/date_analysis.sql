-- =========================================
-- DATE ANALYSIS
-- =========================================


-- 1. Convert Order Date & Ship Date (if not already done)
-- (Skip if already handled in cleaning step)

-- ALTER TABLE orders
-- ALTER COLUMN order_date TYPE DATE USING order_date::DATE;

-- ALTER TABLE orders
-- ALTER COLUMN ship_date TYPE DATE USING ship_date::DATE;



-- 1. Year-wise Sales Trend
SELECT 
    EXTRACT(YEAR FROM o.order_date) AS order_year,
    SUM(s.sales) AS total_sales
FROM sales s
JOIN orders o
ON s.order_id = o.order_id
GROUP BY order_year
ORDER BY order_year;



-- 2. Month-wise Sales Trend
SELECT 
    TO_CHAR(o.order_date, 'Month') AS month_name,
    EXTRACT(MONTH FROM o.order_date) AS month_no,
    SUM(s.sales) AS total_sales
FROM sales s
JOIN orders o
ON s.order_id = o.order_id
GROUP BY month_name, month_no
ORDER BY month_no;



-- 3. Quarterly Sales Analysis
SELECT 
    EXTRACT(YEAR FROM o.order_date) AS year,
    EXTRACT(QUARTER FROM o.order_date) AS quarter,
    SUM(s.sales) AS total_sales
FROM sales s
JOIN orders o
ON s.order_id = o.order_id
GROUP BY year, quarter
ORDER BY year, quarter;



-- 4. Monthly Orders Count Trend
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    COUNT(order_id) AS total_orders
FROM orders 
GROUP BY month
ORDER BY month;



-- 5. Day-wise Order Pattern (Weekday Analysis)
SELECT 
    TO_CHAR(order_date, 'Day') AS weekday,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY weekday
ORDER BY total_orders DESC;



-- 6. Average Delivery Time (Shipping Performance)
SELECT 
    ROUND(AVG(ship_date - order_date),2) AS avg_shipping_days
FROM orders;



-- 7. Fastest vs Slowest Shipping Orders
SELECT 
    order_id,
    order_date,
    ship_date,
    (ship_date - order_date) AS shipping_days
FROM orders
ORDER BY shipping_days DESC
LIMIT 10;



-- 8. Year-Month Revenue Trend (Best for dashboard)
SELECT 
    TO_CHAR(o.order_date, 'YYYY-MM') AS year_month,
    SUM(s.sales) AS total_revenue
FROM sales s
JOIN orders o
ON s.order_id = o.order_id
GROUP BY year_month
ORDER BY year_month;



-- 9. Peak Sales Day (Best performing dates)
SELECT 
    o.order_date,
    SUM(s.sales) AS daily_sales
FROM sales s
JOIN orders o
ON s.order_id = o.order_id
GROUP BY order_date
ORDER BY daily_sales DESC
LIMIT 10;