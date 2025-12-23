-- ============================================
-- Data Validation & Integrity Checks
-- ============================================

-- Row counts
SELECT COUNT(*) AS total_orders FROM orders;
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_order_items FROM order_items;
SELECT COUNT(*) AS total_payments FROM order_pay;
SELECT COUNT(*) AS total_reviews FROM review_order;

-- NULL checks
SELECT COUNT(*) AS null_order_id FROM orders WHERE order_id IS NULL;
SELECT COUNT(*) AS null_customer_id FROM orders WHERE customer_id IS NULL;

SELECT COUNT(*) AS null_price 
FROM order_items 
WHERE price IS NULL OR freight_value IS NULL;

SELECT COUNT(*) AS null_payment_values
FROM order_pay 
WHERE payment_value IS NULL OR payment_installments IS NULL;

-- Duplicate checks
SELECT order_id, COUNT(*) 
FROM orders 
GROUP BY order_id 
HAVING COUNT(*) > 1;

SELECT customer_id, COUNT(*) 
FROM customers 
GROUP BY customer_id 
HAVING COUNT(*) > 1;

-- Distinct categorical values
SELECT DISTINCT order_status FROM orders;
SELECT DISTINCT payment_type FROM order_pay;

-- Review dates validation
SELECT COUNT(*) 
FROM review_order 
WHERE review_creation_date IS NULL;

SHOW WARNINGS;
