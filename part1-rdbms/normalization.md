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