-- Create table with PRIMARY KEY
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE
);

-- Drop PRIMARY KEY
ALTER TABLE orders
DROP PRIMARY KEY;

-- Add PRIMARY KEY again
ALTER TABLE orders
ADD PRIMARY KEY (order_id);

