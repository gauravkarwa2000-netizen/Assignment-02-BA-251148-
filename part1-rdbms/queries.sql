-- Q1: All customers from Mumbai along with their total order value
SELECT 
    customer_name,
    SUM(quantity * unit_price) AS total_order_value
FROM orders_flat
WHERE LOWER(TRIM(customer_city)) = 'mumbai'
GROUP BY customer_id, customer_name;


-- Q2 The top 3 products by total quantity sold
SELECT 
    product_name,
    SUM(quantity) AS total_quantity
FROM orders_flat
GROUP BY product_id, product_name
ORDER BY total_quantity DESC
LIMIT 3;

-- Q3 All sales representives and the number of unique customers they have handeled.
SELECT 
    sales_rep_name,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM orders_flat
GROUP BY sales_rep_id, sales_rep_name;

-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
SELECT 
    order_id,
    SUM(quantity * unit_price) AS total_value
FROM orders_flat
GROUP BY order_id
HAVING total_value > 10000
ORDER BY total_value DESC;


-- Q5: Identify any products that have never been ordered
-- Not possible directly using orders_flat table because it only contains  products that have been ordered. 
-- All the other columns are directly linked with order. If there are no orders then we cannot see any products that have never been sold.
-- There is no separate product master list.