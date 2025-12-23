-- ============================================
-- Review table date cleanup
-- ============================================

UPDATE review_order
SET review_creation_date =
    STR_TO_DATE(review_creation_date, '%d-%m-%Y %H:%i')
WHERE review_creation_date IS NOT NULL;

UPDATE review_order
SET review_answer_timestamp =
    STR_TO_DATE(review_answer_timestamp, '%d-%m-%Y %H:%i')
WHERE review_answer_timestamp IS NOT NULL;

-- ============================================
-- Orders table date cleanup
-- ============================================

UPDATE orders
SET order_delivered_customer_date = NULL
WHERE order_delivered_customer_date = '';

UPDATE orders
SET order_estimated_delivery_date = NULL
WHERE order_estimated_delivery_date = '';

-- ============================================
-- Delivery days calculations
-- ============================================

ALTER TABLE orders ADD COLUMN nDays INT;
UPDATE orders 
SET nDays = DATEDIFF(order_delivered_customer_date, order_purchase_timestamp);

ALTER TABLE orders ADD COLUMN Est_nDays INT;
UPDATE orders 
SET Est_nDays = DATEDIFF(order_estimated_delivery_date, order_purchase_timestamp);

-- ============================================
-- Price + Freight calculation
-- ============================================

ALTER TABLE order_items ADD COLUMN price_freight DOUBLE;
UPDATE order_items 
SET price_freight = ROUND(price + freight_value, 2);


-- ============================================
-- Sanity checks after transformation
-- ============================================

SELECT DISTINCT payment_type FROM order_pay;
SELECT DISTINCT customer_city FROM customers;
SELECT DISTINCT seller_city FROM sellers;

SELECT * 
FROM order_items 
WHERE price_freight < 0;