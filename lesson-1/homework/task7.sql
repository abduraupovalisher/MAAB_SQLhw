
-- SQL Server syntax assumed here
CREATE TABLE invoice (
    invoice_id INT IDENTITY(1,1) PRIMARY KEY,
    amount DECIMAL(10, 2)
);

-- Insert 5 rows (auto-increment)
INSERT INTO invoice (amount) VALUES (100), (200), (300), (400), (500);

-- Enable IDENTITY_INSERT to insert specific ID
SET IDENTITY_INSERT invoice ON;

INSERT INTO invoice (invoice_id, amount) VALUES (100, 999.99);

SET IDENTITY_INSERT invoice OFF;
