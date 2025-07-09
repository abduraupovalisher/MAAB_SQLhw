CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE
);

ALTER TABLE orders
DROP PRIMARY KEY;

ALTER TABLE orders
ADD PRIMARY KEY (order_id);

