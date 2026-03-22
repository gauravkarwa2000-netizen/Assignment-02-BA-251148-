-- Customers Table
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50) NOT NULL
);
INSERT INTO customers VALUES
('C001','Amit Sharma','amit@gmail.com','Mumbai'),
('C002','Neha Singh','neha@gmail.com','Pune'),
('C003','Raj Mehta','raj@gmail.com','Delhi'),
('C004','Simran Kaur','simran@gmail.com','Bangalore'),
('C005','Karan Patel','karan@gmail.com','Ahmedabad'),
('C006','Rohit Verma','rohit@gmail.com','Mumbai'),
('C007','Priya Nair','priya@gmail.com','Chennai'),
('C008','Anjali Gupta','anjali@gmail.com','Kolkata'),
('C009','Vikas Yadav','vikas@gmail.com','Mumbai'),
('C010','Sneha Roy','sneha@gmail.com','Pune');

-- Products Table
CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);
INSERT INTO products VALUES
('P001','Laptop','Electronics',55000),
('P002','Mouse','Electronics',500),
('P003','Keyboard','Electronics',1500),
('P004','Monitor','Electronics',12000),
('P005','T-Shirt','Clothing',1200),
('P006','Jeans','Clothing',2500),
('P007','Rice Bag','Groceries',900),
('P008','Cooking Oil','Groceries',1500),
('P009','Smartphone','Electronics',30000),
('P010','Headphones','Electronics',2000);

-- Sales Representatives Table
CREATE TABLE sales_reps (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) NOT NULL,
    office_address VARCHAR(150) NOT NULL
);
INSERT INTO sales_reps VALUES
('S001','Rahul Verma','rahul@company.com','Mumbai Office'),
('S002','Priya Desai','priya@company.com','Pune Office'),
('S003','Arjun Nair','arjun@company.com','Delhi Office'),
('S004','Sneha Joshi','sneha@company.com','Bangalore Office'),
('S005','Vikram Shah','vikram@company.com','Ahmedabad Office');

-- Orders Table
CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    sales_rep_id VARCHAR(10),
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id)
);
INSERT INTO orders VALUES
('O001','C001','S001','2024-01-01'),
('O002','C002','S002','2024-01-02'),
('O003','C003','S003','2024-01-03'),
('O004','C004','S004','2024-01-04'),
('O005','C005','S005','2024-01-05'),
('O006','C006','S001','2024-01-06'),
('O007','C007','S002','2024-01-07'),
('O008','C008','S003','2024-01-08'),
('O009','C009','S004','2024-01-09'),
('O010','C010','S005','2024-01-10');

-- Order Items Table
CREATE TABLE order_items (
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO order_items VALUES
('O001','P001',1),
('O001','P002',2),
('O001','P003',1),

('O002','P005',2),
('O002','P006',1),
('O002','P010',1),

('O003','P007',3),
('O003','P008',2),
('O003','P002',1),

('O004','P004',1),
('O004','P001',1),
('O004','P010',2),

('O005','P009',1),
('O005','P003',2),
('O005','P005',1),

('O006','P002',3),
('O006','P004',1),
('O006','P007',2),

('O007','P006',2),
('O007','P005',1),
('O007','P010',1),

('O008','P001',1),
('O008','P009',1),
('O008','P003',2),

('O009','P008',2),
('O009','P007',1),
('O009','P002',2),

('O010','P010',1),
('O010','P004',1),
('O010','P006',2);