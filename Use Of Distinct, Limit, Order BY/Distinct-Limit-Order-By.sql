
-- //// SECTION 1: USING DISTINCT (BASICS)

-- Q1. List all unique product names ordered by customers

SELECT DISTINCT
    product_name
FROM orders;

-- Q2. Count unique products ordered by each customer

SELECT
    customer_id,
    COUNT(DISTINCT product_name) AS unique_product_count
FROM orders
GROUP BY customer_id;

-- Q3. Find total number of unique products on the platform

SELECT
    COUNT(DISTINCT product_name) AS total_unique_products
FROM orders;

-- Q4. Get the 3 most recently ordered distinct products

SELECT DISTINCT
    product_name
FROM orders
ORDER BY order_date DESC
LIMIT 3;



-- //// SECTION 2: DISTINCT WITH WHERE, ORDER BY, AND LIMIT


-- Q1. Top 2 distinct products ordered in the last 1 month

SELECT DISTINCT
    product_name
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL 1 MONTH
ORDER BY order_date DESC
LIMIT 2;

-- Q2. Last 3 distinct products ordered by a specific customer (Customer ID = 200)

SELECT DISTINCT
    product_name
FROM orders
WHERE customer_id = 200
ORDER BY order_date DESC
LIMIT 3;

-- Q3. Top 5 most ordered products (based on distinct orders)

SELECT
    product_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY product_name
ORDER BY total_orders DESC
LIMIT 5;

-- Q4. Count of unique orders per product

SELECT
    product_name,
    COUNT(DISTINCT order_id) AS order_count
FROM orders
GROUP BY product_name
ORDER BY order_count DESC;


-- //// SECTION 3: QUERY OPTIMIZATION & INDEXING

-- Create a composite index to improve filtering and DISTINCT

CREATE INDEX idx_orders_date_product
ON orders (order_date, product_name);

-- Optimized query: distinct products ordered in last month

SELECT DISTINCT
    product_name
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL 1 MONTH;


-- //// SECTION 4: EXECUTION PLAN & PERFORMANCE ANALYSIS

-- Q1. Analyze execution plan for most ordered products (30 days)

EXPLAIN
SELECT
    product_name,
    COUNT(*) AS total_orders
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL 30 DAY
GROUP BY product_name
ORDER BY total_orders DESC
LIMIT 10;

-- Optimized alternative using GROUP BY instead of DISTINCT

SELECT
    product_name
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL 30 DAY
GROUP BY product_name
ORDER BY MAX(order_date) DESC
LIMIT 5;


-- //// SECTION 5: REAL-WORLD SCENARIOS (ADVANCED QUERIES)

-- Q1. Top 10 most recently ordered products
SELECT
    product_name,
    MAX(order_date) AS last_order_date
FROM orders
GROUP BY product_name
ORDER BY last_order_date DESC
LIMIT 10;

-- Q2. Most recent customer for each product
SELECT
    o.product_name,
    o.customer_id,
    o.order_date
FROM orders o
JOIN (
    SELECT
        product_name,
        MAX(order_date) AS latest_order_date
    FROM orders
    GROUP BY product_name
) latest
ON o.product_name = latest.product_name
AND o.order_date = latest.latest_order_date
ORDER BY o.order_date DESC
LIMIT 10;

-- END OF FILE
