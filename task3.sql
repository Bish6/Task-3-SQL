CREATE DATABASE IF NOT EXISTS internship_task;
USE internship_task;

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(20),
    city VARCHAR(50)
);

INSERT INTO customer (customer_id, name, city) VALUES
(1, 'Asha', 'Delhi'),
(2, 'Ravi', 'Mumbai'),
(3, 'Neha', 'Delhi'),
(4, 'Imran', 'Pune'),
(5, 'Priya', 'Mumbai');

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    status VARCHAR(20)
);

INSERT INTO orders (order_id, customer_id, amount, status) VALUES
(101, 1, 1200.00, 'completed'),
(102, 2, 800.00, 'completed'),
(103, 3, 1500.00, 'completed'),
(104, 4, 600.00, 'pending'),
(105, 5, 2000.00, 'completed');

-- Show all customers
SELECT * FROM customer;

-- Filter customers by city
SELECT * FROM customer
WHERE city = 'Delhi';

-- Sort orders by amount, highest first
SELECT * FROM orders
ORDER BY amount DESC;

-- Calculate each customer's total and average order
SELECT customer_id,
       SUM(amount) AS total_spent,
       AVG(amount) AS average_order
FROM orders
GROUP BY customer_id;

-- Match customers with their orders
SELECT customer.name, orders.order_id, orders.amount, orders.status
FROM customer
INNER JOIN orders
    ON customer.customer_id = orders.customer_id;

-- Keep all customers in the results
SELECT customer.name, orders.order_id, orders.amount
FROM customer
LEFT JOIN orders
    ON customer.customer_id = orders.customer_id;

-- Keep all orders in the results
SELECT customer.name, orders.order_id, orders.amount
FROM customer
RIGHT JOIN orders
    ON customer.customer_id = orders.customer_id;

-- Find customers with an order above the average order amount
SELECT customer.name, orders.amount
FROM customer
JOIN orders
    ON customer.customer_id = orders.customer_id
WHERE orders.amount > (SELECT AVG(amount) FROM orders);

-- Create and use a saved sales summary
CREATE OR REPLACE VIEW customer_sales AS
SELECT customer.name,
       SUM(orders.amount) AS total_spent
FROM customer
INNER JOIN orders
    ON customer.customer_id = orders.customer_id
GROUP BY customer.customer_id, customer.name;

SELECT * FROM customer_sales;

-- Create and check an index for order status
CREATE INDEX idx_orders_status ON orders(status);

SHOW INDEX FROM orders;