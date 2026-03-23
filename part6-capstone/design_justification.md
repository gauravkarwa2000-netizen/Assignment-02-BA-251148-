## Storage Systems

In this architecture, different storage systems are used based on the type and purpose of data. For transactional patient data such as admissions, treatment history, and billing, a relational database (OLTP system like PostgreSQL) is used because it supports fast updates and ensures data consistency.

For raw and unstructured data such as doctor notes, logs, and historical records, a data lake is used. This allows scalable and cost-effective storage of large volumes of data in its original format. For structured analytics and reporting, a data warehouse is used where cleaned and transformed data is stored. This helps in generating monthly reports like bed occupancy and department-wise costs efficiently.

For real-time ICU monitoring, a streaming system (Kafka) is used to ingest data continuously, which is then stored in a time-series database. This enables efficient querying and visualization of real-time patient vitals.

To support natural language queries from doctors, a vector database is used. Doctor notes and patient records are converted into embeddings using an embedding model and stored in the vector database, enabling semantic search.

## OLTP vs OLAP Boundary

The OLTP system consists of the transactional database that handles real-time operations such as patient admissions, updates, and billing. This system is optimized for fast inserts and updates and ensures data integrity.

The OLAP system begins when data is extracted from the OLTP database and moved into the data lake through ETL pipelines. From the data lake, processed data is loaded into the data warehouse for analytical purposes. The data warehouse is used to generate reports and dashboards for hospital management.

Additionally, the machine learning models and vector database operate on processed data from the data lake or warehouse, placing them in the analytical layer. This separation ensures that analytical queries do not affect the performance of transactional systems.

## Trade-offs

One major trade-off in this architecture is the increased complexity due to the use of multiple systems such as data lakes, data warehouses, streaming pipelines, and vector databases. Managing these components requires more effort in terms of integration, monitoring, and maintenance.

To mitigate this, managed cloud services such as AWS, Azure, or Google Cloud can be used to reduce infrastructure overhead. Tools for orchestration and monitoring can also be implemented to ensure smooth data flow. Although the system becomes more complex, this trade-off is justified because it provides scalability, flexibility, and the ability to support advanced AI features, which are essential for modern healthcare systems.
