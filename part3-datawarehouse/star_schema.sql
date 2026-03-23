CREATE TABLE clean_sales AS
SELECT 
    transaction_id,

    TRIM(store_name) AS store_name,
    TRIM(store_city) AS store_city,

    

    COALESCE(units_sold, 0) AS quantity,
    COALESCE(unit_price, 0) AS price,

    -- DATE CLEANING (VERY IMPORTANT)
    CASE 
        WHEN date LIKE '__/__/____' 
            THEN date(substr(date,7,4) || '-' || substr(date,4,2) || '-' || substr(date,1,2))
        
        WHEN date LIKE '__-__-____' 
            THEN date(substr(date,7,4) || '-' || substr(date,4,2) || '-' || substr(date,1,2))
        
        ELSE date(date)
    END AS clean_date

FROM retail_transactions;

--Creating and inserting dim_date table
CREATE TABLE dim_date (
    date_id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_date DATE,
    year INTEGER,
    month INTEGER,
    day INTEGER
);
INSERT INTO dim_date (full_date, year, month, day)
SELECT DISTINCT 
    clean_date,
    strftime('%Y', clean_date),
    strftime('%m', clean_date),
    strftime('%d', clean_date)
FROM clean_sales
WHERE clean_date IS NOT NULL;

--Creating and inserting dim_product table 
CREATE TABLE dim_product (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name TEXT,
    product_category TEXT
);
INSERT INTO dim_product (product_name, product_category)
SELECT DISTINCT product_name, product_category
FROM clean_sales;

--Creating and inserting dim_store table
CREATE TABLE dim_store (
    store_id INTEGER PRIMARY KEY AUTOINCREMENT,
    store_name TEXT,
    store_city TEXT
);
INSERT INTO dim_store (store_name, store_city)
SELECT DISTINCT store_name, store_city
FROM clean_sales;



--Creating and inserting fact_sales table 
CREATE TABLE fact_sales (
    sales_id INTEGER PRIMARY KEY AUTOINCREMENT,

    date_id INTEGER,
    store_id INTEGER,
    product_id INTEGER,

    quantity INTEGER,
    revenue REAL,

    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);
INSERT INTO fact_sales (date_id, store_id, product_id, quantity, revenue)
SELECT 
    d.date_id,
    s.store_id,
    p.product_id,

    c.quantity,
    c.quantity * c.price AS revenue

FROM clean_sales c

JOIN dim_date d 
    ON c.clean_date = d.full_date

JOIN dim_store s 
    ON c.store_name = s.store_name
    AND c.store_city = s.store_city

JOIN dim_product p 
    ON c.product_name = p.product_name
    AND c.product_category = p.product_category

LIMIT 20;

