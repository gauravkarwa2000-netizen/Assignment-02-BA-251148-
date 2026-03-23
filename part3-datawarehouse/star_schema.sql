DROP VIEW IF EXISTS cleaned_data;
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_product;

CREATE VIEW cleaned_data AS
SELECT
    CAST(transaction_id AS INTEGER) AS transaction_id,
    "date",
    store_name,
    COALESCE(NULLIF(TRIM(store_city), ''), 'Unknown') AS store_city,
    product_name,
    UPPER(substr(category,1,1)) || LOWER(substr(category,2)) AS category,
    CAST(units_sold AS INTEGER) AS units_sold,
    CAST(unit_price AS REAL) AS unit_price,
    customer_id
FROM retail_transactions;

CREATE TABLE dim_date (
    date_id INTEGER PRIMARY KEY AUTOINCREMENT,
    "date" TEXT
);

CREATE TABLE dim_store (
    store_id INTEGER PRIMARY KEY AUTOINCREMENT,
    store_name TEXT,
    store_city TEXT
);

CREATE TABLE dim_product (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name TEXT,
    category TEXT
);

INSERT INTO dim_date ("date")
SELECT DISTINCT "date"
FROM cleaned_data;

INSERT INTO dim_store (store_name, store_city)
SELECT DISTINCT store_name, store_city
FROM cleaned_data;

INSERT INTO dim_product (product_name, category)
SELECT DISTINCT product_name, category
FROM cleaned_data;

CREATE TABLE fact_sales (
    sales_id INTEGER PRIMARY KEY AUTOINCREMENT,
    transaction_id INTEGER,
    date_id INTEGER,
    store_id INTEGER,
    product_id INTEGER,
    customer_id TEXT,
    units_sold INTEGER,
    unit_price REAL,
    total_sales REAL,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

INSERT INTO fact_sales (
    transaction_id,
    date_id,
    store_id,
    product_id,
    customer_id,
    units_sold,
    unit_price,
    total_sales
)
SELECT
    c.transaction_id,
    d.date_id,
    s.store_id,
    p.product_id,
    c.customer_id,
    COALESCE(c.units_sold, 0),
    COALESCE(c.unit_price, 0),
    COALESCE(c.units_sold, 0) * COALESCE(c.unit_price, 0)
FROM cleaned_data c
JOIN dim_date d 
    ON c."date" = d."date"
JOIN dim_store s 
    ON c.store_name = s.store_name 
    AND c.store_city = s.store_city
JOIN dim_product p 
    ON c.product_name = p.product_name;

SELECT * FROM dim_date;
SELECT * FROM dim_store;
SELECT * FROM dim_product;
SELECT * FROM fact_sales;