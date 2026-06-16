-- =====================================================
-- STEP 1: Create Raw Table
-- =====================================================
CREATE TABLE superstore_raw (
    category TEXT,
    city TEXT,
    country TEXT,
    customer_id TEXT,
    customer_name TEXT,
    discount TEXT,
    market TEXT,
    record_count TEXT,
    order_date TEXT,
    order_id TEXT,
    order_priority TEXT,
    product_id TEXT,
    product_name TEXT,
    profit TEXT,
    quantity TEXT,
    region TEXT,
    row_id TEXT,
    sales TEXT,
    segment TEXT,
    ship_date TEXT,
    ship_mode TEXT,
    shipping_cost TEXT,
    state TEXT,
    sub_category TEXT,
    year TEXT,
    market2 TEXT,
    weeknum TEXT
);


-- =====================================================
-- STEP 2: Create Cleaned Table
-- =====================================================
CREATE TABLE superstore AS
SELECT
    category,
    city,
    country,
    customer_id,
    customer_name,
    discount::NUMERIC(5,2) AS discount,
    market,
    record_count::INT AS record_count,
    TO_DATE(order_date,'DD-MM-YYYY') AS order_date,
    order_id,
    order_priority,
    product_id,
    product_name,
    profit::NUMERIC(12,2) AS profit,
    quantity::INT AS quantity,
    region,
    row_id::INT AS row_id,
    sales::NUMERIC(12,2) AS sales,
    segment,
    TO_DATE(ship_date,'DD-MM-YYYY') AS ship_date,
    ship_mode,
    shipping_cost::NUMERIC(12,2) AS shipping_cost,
    state,
    sub_category,
    year::INT AS year,
    market2,
    weeknum::INT AS weeknum
FROM superstore_raw;

SELECT *
FROM superstore
LIMIT 5;


-- =====================================================
-- STEP 3: Create Customers Dimension
-- =====================================================
CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50)
);


-- =====================================================
-- STEP 4: Create Products Dimension
-- =====================================================
CREATE TABLE products (
    product_id VARCHAR(30) PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(100),
    sub_category VARCHAR(100)
);


-- =====================================================
-- STEP 4: Create Location Dimension
-- =====================================================
CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    region VARCHAR(100),
    market VARCHAR(50),
    market2 VARCHAR(50)
);


-- =====================================================
-- STEP 5: Create Orders Dimension
-- =====================================================
CREATE TABLE orders (
    order_id VARCHAR(30) PRIMARY KEY,
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    order_priority VARCHAR(50)
);


-- =====================================================
-- STEP 7: Create Sales Fact Table
-- =====================================================
CREATE TABLE sales (
    row_id INT PRIMARY KEY,
    order_id VARCHAR(30),
    customer_id VARCHAR(20),
    product_id VARCHAR(30),
    location_id INT,
    sales NUMERIC(12,2),
    quantity INT,
    discount NUMERIC(5,2),
    profit NUMERIC(12,2),
    shipping_cost NUMERIC(12,2)
);

-- =====================================================
-- STEP 8: Added Foreign Key Constraints
-- =====================================================
ALTER TABLE sales
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE sales
ADD CONSTRAINT fk_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

ALTER TABLE sales
ADD CONSTRAINT fk_location
FOREIGN KEY (location_id)
REFERENCES locations(location_id);

ALTER TABLE sales
ADD CONSTRAINT fk_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);



