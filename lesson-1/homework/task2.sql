CREATE TABLE product (
    product_id INT UNIQUE,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

ALTER TABLE product
DROP INDEX product_id;

ALTER TABLE product
ADD UNIQUE (product_id);

ALTER TABLE product
ADD CONSTRAINT unique_product_combination UNIQUE (product_id, product_name);

