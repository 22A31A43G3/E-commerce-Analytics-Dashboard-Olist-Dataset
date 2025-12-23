-- ============================================
-- BUSINESS ANALYSIS QUERIES
-- ============================================

-- ------------------------------------------------
-- ORDER STATUS OVERVIEW
-- ------------------------------------------------
SELECT DISTINCT order_status FROM orders;


-- ------------------------------------------------
-- REVENUE ANALYSIS
-- ------------------------------------------------

-- Total Revenue (Delivered Orders Only)
SELECT 
    SUM(payment_value) AS total_revenue
FROM orders o
JOIN order_pay op 
    ON o.order_id = op.order_id
WHERE o.order_status = 'delivered';


-- Monthly Revenue Trend
SELECT 
    YEAR(o.order_delivered_customer_date) AS Y,
    MONTH(o.order_delivered_customer_date) AS M,
    SUM(payment_value) AS monthly_revenue
FROM orders o
JOIN order_pay op 
    ON o.order_id = op.order_id
WHERE o.order_status = 'delivered'
GROUP BY Y, M
ORDER BY Y, M;


-- ------------------------------------------------
-- CUSTOMER ANALYSIS
-- ------------------------------------------------

-- New vs Repeat Customers
SELECT 
    new_vs_repeat, 
    COUNT(*) AS users_count
FROM (
    SELECT 
        customer_id,
        COUNT(*) AS order_count,
        CASE
            WHEN COUNT(*) = 1 THEN 'new'
            ELSE 'repeat'
        END AS new_vs_repeat
    FROM orders
    WHERE order_status = 'delivered'
    GROUP BY customer_id
) AS x
GROUP BY new_vs_repeat;


-- Top Revenue-Generating Customers
SELECT 
    o.customer_id,
    SUM(op.payment_value) AS revenue,
    COUNT(DISTINCT op.order_id) AS no_of_orders
FROM orders o
JOIN order_pay op 
    ON o.order_id = op.order_id
WHERE o.order_status = 'delivered'
GROUP BY o.customer_id
ORDER BY revenue DESC
LIMIT 10;


-- ------------------------------------------------
-- PAYMENT ANALYSIS
-- ------------------------------------------------

-- Preferred Payment Methods (Direct Join)
SELECT 
    op.payment_type AS payment_method,
    SUM(op.payment_value) AS revenue,
    COUNT(DISTINCT o.order_id) AS no_of_orders
FROM orders o
JOIN order_pay op 
    ON o.order_id = op.order_id
WHERE o.order_status = 'delivered'
GROUP BY op.payment_type
ORDER BY revenue DESC;


-- ------------------------------------------------
-- PRODUCT ANALYSIS
-- ------------------------------------------------

-- Top Products by Demand
SELECT 
    p.product_id,
    ct.product_category_name_english AS category,
    COUNT(*) AS units_ordered
FROM order_items oi
JOIN prods p 
    ON oi.product_id = p.product_id
JOIN cat_translation ct 
    ON p.product_category_name = ct.product_category_name
JOIN orders o 
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY category, p.product_id
ORDER BY units_ordered DESC
LIMIT 10;


-- Top Product Categories by Demand
SELECT 
    ct.product_category_name_english AS category,
    COUNT(*) AS units_ordered
FROM order_items oi
JOIN prods p 
    ON oi.product_id = p.product_id
JOIN cat_translation ct 
    ON p.product_category_name = ct.product_category_name
JOIN orders o 
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY units_ordered DESC
LIMIT 10;


-- Low-Demand Products (Discontinuation Candidates)
SELECT 
    p.product_id,
    ct.product_category_name_english AS category,
    COUNT(*) AS units_ordered,
    SUM(oi.price_freight) AS revenue
FROM order_items oi
JOIN prods p 
    ON oi.product_id = p.product_id
JOIN cat_translation ct 
    ON p.product_category_name = ct.product_category_name
JOIN orders o 
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY category, p.product_id
ORDER BY units_ordered ASC, revenue ASC
LIMIT 10;


-- ------------------------------------------------
-- GEO & LOCATION ANALYSIS
-- ------------------------------------------------

-- Category Demand by Customer State
SELECT 
    c.customer_state,
    ct.product_category_name_english AS category,
    COUNT(*) AS units_sold,
    SUM(oi.price_freight) AS revenue
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
JOIN order_items oi 
    ON o.order_id = oi.order_id
JOIN prods p 
    ON oi.product_id = p.product_id
JOIN cat_translation ct 
    ON p.product_category_name = ct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state, category
ORDER BY units_sold DESC;


-- ------------------------------------------------
-- CUSTOMER SATISFACTION ANALYSIS
-- ------------------------------------------------

-- Review Score Classification
SELECT 
    rating, 
    COUNT(rating) AS review_count
FROM (
    SELECT 
        o.order_id,
        o.customer_id,
        ro.review_score,
        CASE
            WHEN ro.review_score >= 4 THEN 'satisfied'
            WHEN ro.review_score > 2 AND ro.review_score < 4 THEN 'neutral'
            ELSE 'unsatisfied'
        END AS rating
    FROM orders o
    JOIN review_order ro 
        ON o.order_id = ro.order_id
) x
GROUP BY rating;
