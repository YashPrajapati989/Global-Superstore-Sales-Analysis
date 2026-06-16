-- =====================================================
-- STEP 1: Load Customer Dimension
-- =====================================================
INSERT INTO customers
SELECT DISTINCT
    customer_id,
    customer_name,
    segment
FROM superstore;

SELECT COUNT(*) FROM customers;

-- =====================================================
-- STEP 2: Load Product Dimension
-- =====================================================
INSERT INTO products (
    product_id,
    product_name,
    category,
    sub_category
)
SELECT DISTINCT ON (product_id)
       product_id,
       product_name,
       category,
       sub_category
FROM superstore
ORDER BY product_id, product_name;

SELECT COUNT(*) 
FROM products;

-- =====================================================
-- STEP 3: Load Location Dimension
-- =====================================================
INSERT INTO locations (
    city,
    state,
    country,
    region,
    market
)
SELECT DISTINCT
    city,
    state,
    country,
    region,
    market
FROM superstore;


-- =====================================================
-- STEP 4: Load Orders Dimension
-- =====================================================
INSERT INTO orders
SELECT
    order_id,
    MIN(order_date),
    MIN(ship_date),
    MIN(ship_mode),
    MIN(order_priority)
FROM superstore
GROUP BY order_id;

SELECT * FROM orders;

-- One order can contain multiple products.
-- GROUP BY order_id ensures one record per order.


-- =====================================================
-- STEP 5: Load Sales Fact Table
-- =====================================================
INSERT INTO sales (
    row_id,
    order_id,
    customer_id,
    product_id,
    location_id,
    sales,
    quantity,
    discount,
    profit,
    shipping_cost
)
SELECT
    s.row_id,
    s.order_id,
    s.customer_id,
    s.product_id,
    l.location_id,
    s.sales,
    s.quantity,
    s.discount,
    s.profit,
    s.shipping_cost
FROM superstore s
JOIN locations l
ON s.city = l.city
AND s.state = l.state
AND s.country = l.country
AND s.region = l.region
AND s.market = l.market;

SELECT
    (SELECT COUNT(*) FROM superstore) AS superstore_rows,
    (SELECT COUNT(*) FROM sales) AS sales_rows;
	