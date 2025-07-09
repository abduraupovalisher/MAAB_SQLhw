CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100) DEFAULT 'Unknown'
);

ALTER TABLE customer
ALTER city DROP DEFAULT;

ALTER TABLE customer
ALTER city SET DEFAULT 'Unknown';

