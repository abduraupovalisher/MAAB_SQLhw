-- Create category table
CREATE TABLE category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

-- Create item table with FOREIGN KEY
CREATE TABLE item (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

-- Drop FOREIGN KEY constraint
ALTER TABLE item
DROP FOREIGN KEY item_ibfk_1; -- MySQL auto-names FK as item_ibfk_1, may vary

-- Add FOREIGN KEY constraint again
ALTER TABLE item
ADD CONSTRAINT fk_category FOREIGN KEY (category_id)
REFERENCES category(category_id);

