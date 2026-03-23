-- Q1: Total sales revenue by product category for each month


SELECT 
    dp.product_category,
    dd.year,
    dd.month,
    SUM(fs.revenue) AS total_revenue
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id = dp.product_id
JOIN dim_date dd ON fs.date_id = dd.date_id
GROUP BY dp.product_category, dd.year, dd.month
ORDER BY dd.year, dd.month;

-- Q2: Top 2 performing stores by total revenue

SELECT 
    ds.store_name,
    ds.store_city,
    SUM(fs.revenue) AS total_revenue
FROM fact_sales fs
JOIN dim_store ds ON fs.store_id = ds.store_id
GROUP BY ds.store_name, ds.store_city
ORDER BY total_revenue DESC
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores
SELECT 
    dd.year,
    dd.month,
    SUM(fs.revenue) AS monthly_revenue
FROM fact_sales fs
JOIN dim_date dd ON fs.date_id = dd.date_id
GROUP BY dd.year, dd.month
ORDER BY dd.year, dd.month;