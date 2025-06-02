-- Create table without NOT NULL
CREATE TABLE student (
    id INT,
    name VARCHAR(100),
    age INT
);

-- Add NOT NULL constraint to id
ALTER TABLE student
MODIFY id INT NOT NULL;

