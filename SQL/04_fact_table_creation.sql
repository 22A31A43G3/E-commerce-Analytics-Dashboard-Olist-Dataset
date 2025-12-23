-- ============================================
-- Fact Table Creation (Order-level aggregation)
-- Created just to learning purpose
-- ============================================

-- Drop and recreate fact table if needed
DROP TABLE IF EXISTS fact_order_items;

CREATE TABLE fact_order_items (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    zip_code INT,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    order_status VARCHAR(20),
    delivery_days INT
);

-- ============================================
-- Populate Order-level Fact Table
-- Grain: One row per order
-- ============================================

INSERT INTO fact_order_items (
    order_id,
    customer_id,
    zip_code,
    price,
    freight_value,
    order_status,
    delivery_days
)
SELECT
    o.order_id,
    o.customer_id,
    c.customer_zip_code_prefix,
    ROUND(SUM(oi.price), 2) AS price,
    ROUND(SUM(oi.freight_value), 2) AS freight_value,
    o.order_status,
    o.nDays
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
JOIN customers c 
    ON o.customer_id = c.customer_id
GROUP BY
    o.order_id,
    o.customer_id,
    c.customer_zip_code_prefix,
    o.order_status,
    o.nDays;

-- ============================================
-- Validation: Ensure 1 row per order
-- ============================================

SELECT 
    order_id,
    customer_id,
    COUNT(*) AS row_count
FROM fact_order_items
GROUP BY order_id, customer_id
HAVING COUNT(*) > 1;