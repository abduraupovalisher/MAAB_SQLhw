-- Create table with UNIQUE constraint
CREATE TABLE product (
    product_id INT UNIQUE,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Drop UNIQUE constraint (MySQL-style: constraint must be named or implied)
ALTER TABLE product
DROP INDEX product_id;

-- Add UNIQUE constraint again
ALTER TABLE product
ADD UNIQUE (product_id);

-- Add UNIQUE constraint on combination of product_id and product_name
ALTER TABLE product
ADD CONSTRAINT unique_product_combination UNIQUE (product_id, product_name);

