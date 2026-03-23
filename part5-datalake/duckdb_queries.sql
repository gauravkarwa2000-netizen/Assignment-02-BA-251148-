-- Q1: List all customers along with total number of orders
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders
FROM read_csv_auto('customers.csv') c
LEFT JOIN read_json_auto('orders.json') o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC;


-- Q2: Top 3 customers by total order value
SELECT 
    c.name,
    SUM(o.total_amount) AS total_order_value
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
    ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_order_value DESC
LIMIT 3;


-- Q3: Products purchased by customers from Bangalore
SELECT DISTINCT 
    p.product_name
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
    ON c.customer_id = o.customer_id
JOIN read_parquet('products.parquet') p
    ON o.order_id = p.order_id
WHERE c.city = 'Bangalore';


-- Q4: Customer name, order date, product name, quantity
SELECT 
    c.name,
    o.order_date,
    p.product_name,
    p.quantity
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
    ON c.customer_id = o.customer_id
JOIN read_parquet('products.parquet') p
    ON o.order_id = p.order_id
ORDER BY o.order_date;