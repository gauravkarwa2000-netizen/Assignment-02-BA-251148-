## Anomaly Analysis


1. Insert Anomaly

Product information such as product_name, product_id, category and unit_price is stored only within order records. 
A new product cannot be inserted independently without creating an order entry, resulting in an insert anomaly.
There are all product related dependencies on the order, if there is order then only product is created.
There is no free will, if I want to add new product. If there are products which are never sold, then it would have not been in the dataset, since no order is created. 

2. Update Anomaly

Customer details such as customer_name, customer_email, and customer_city are repeated across multiple rows for the same customer_id. 
Although the current dataset shows consistent values, any update to customer information (e.g., change in city or customer email) would require modifying multiple rows. 
Failure to update all rows may lead to data inconsistency, indicating an update anomaly.

3. Delete Anomaly

Deleting a single order row removes associated customer, product, and sales representative information.
For example, I want to delete one product category 
entry from the dataset. This results in loss of product, order_id, customer data from the dataset, which can cause loss in valuable data.


## Normalisation Justification

While keeping all data in a single table may appear simpler at first, it introduces significant data integrity and maintenance issues, as observed in the given dataset. The flat file stores customer, product, order, and sales representative information together, leading to heavy redundancy. For example, the same customer_name, customer_email, and customer_city are repeated across multiple rows for every order placed by that customer. If a customer relocates, updating their city would require modifying multiple rows, increasing the risk of inconsistencies—this is a classic update anomaly.

Similarly, product details such as product_name and unit_price are repeated for every order containing that product. Any change in price would need to be updated across all related rows. This not only increases the chance of errors but also violates data consistency principles. Additionally, the dataset suffers from insert anomalies; for instance, a new product cannot be added unless an order is created for it. Delete anomalies are also evident—removing the last order of a product or customer would result in the unintended loss of their information.

By normalizing the data into separate tables such as customers, products, orders, and sales representatives, each entity is stored independently, eliminating redundancy and ensuring data consistency. Although normalization introduces multiple tables and relationships, it significantly improves data integrity, scalability, and ease of maintenance. Therefore, normalization is not over-engineering but a necessary design approach for reliable database systems.