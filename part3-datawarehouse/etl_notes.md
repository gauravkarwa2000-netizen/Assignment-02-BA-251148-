ETL Decisions
Decision 1 — Standardizing Date Formats

Problem:
The raw dataset contained inconsistent date formats such as DD/MM/YYYY, DD-MM-YYYY, and YYYY-MM-DD. This caused issues when performing joins with the date dimension and aggregating data by month or year.

Resolution:
I standardized all date values into the YYYY-MM-DD format using conditional logic in SQLite. I used substr() and date() functions to transform different formats into a uniform structure and stored the result in a new column clean_date. This ensured compatibility with the dim_date table and enabled accurate time-based analysis.

Decision 2 — Handling Missing Store City Values

Problem:
The store_city column contained blank or missing values. This created issues when building the dim_store table because it could lead to incomplete or duplicate store records, and inaccurate grouping of sales by location in analytical queries.

Resolution:
I handled missing store_city values by first identifying and removing rows where the city information was completely absent using a filtering condition (WHERE store_city IS NOT NULL AND store_city != ''). This ensured that only valid and reliable location data was included in the dimension table. As a result, the integrity of the dim_store table was maintained, and location-based analysis (such as top-performing stores by city) remained accurate.

Decision 3 — Normalizing Product Category Casing

Problem:
The product_category column had inconsistent casing (e.g., "Electronics", "electronics", "ELECTRONICS"), which would result in incorrect grouping and duplicate categories during analysis.

Resolution:
I standardized all category values by converting them to lowercase using the LOWER() function and trimming extra spaces with TRIM(). This ensured consistent grouping in analytical queries and accurate aggregation of revenue by category.