CREATE TABLE sales (
    order_number INT NOT NULL,
    order_date DATE NOT NULL,
    salesperson_id INT NOT NULL,
    product_id VARCHAR(5) NOT NULL,
    amount FLOAT NOT NULL
);

-- Insert sample data into the 'sales_transactions' table
INSERT INTO sales (order_number, order_date, salesperson_id, product_id, amount) 
VALUES 
(1, '2023-01-01', 101, 'P001', 650),
(2, '2023-01-02', 102, 'P002', 1350),
(3, '2023-01-03', 103, 'P003', 960),
(4, '2023-01-04', 104, 'P004', 240),
(5, '2023-01-05', 102, 'P005', 300),
(6, '2023-01-06', 103, 'P006', 350),
(7, '2023-01-07', 104, 'P007', 400),
(8, '2023-01-08', 106, 'P008', 1450),
(9, '2023-01-09', 103, 'P009', 1500),
(10, '2023-01-10', 106, 'P010', 575);

select * from sales;

SELECT SUM(amount) FROM sales;

-- Using Group by
SELECT salesperson_id, SUM(amount)
FROM sales
GROUP BY salesperson_id;


SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
    amount,
    SUM(amount) OVER () AS total_amount
FROM 
    sales;

-- partition by
SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
    amount, 
    SUM(amount) OVER (PARTITION BY salesperson_id) AS Total_sales
FROM 
    sales;
    
-- order by
SELECT 
    salesperson_id, 
    order_date, 
    product_id,
    amount, 
    SUM(amount) OVER (ORDER BY order_date) AS total_amount
FROM 
    sales;
    
-- partition by, order by
SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
    amount,
    SUM(amount) OVER (PARTITION BY salesperson_id ORDER BY order_date) AS total_amount
FROM 
    sales;
    
-- rolling sales for preceding rows and current rows
SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
    amount,
    SUM(amount) OVER (ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS total_amount
FROM 
    sales;
    
    
-- Rows between 1 preceding and 1 following
SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
    amount,
    SUM(amount) OVER (ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS total_amount
FROM 
    sales;
    
-- rows between 2 preceding and 1 preceding 
SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
    amount,
    SUM(amount) OVER (ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) AS total_amount
FROM 
    sales;
    
-- rows between unbounded preceding and current row
SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
    amount,
    SUM(amount) OVER (ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_amount
FROM 
    sales;
