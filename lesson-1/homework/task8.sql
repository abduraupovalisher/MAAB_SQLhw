CREATE TABLE books (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(255) NOT NULL CHECK (LENGTH(title) > 0),
    price DECIMAL(10,2) CHECK (price > 0),
    genre VARCHAR(100) DEFAULT 'Unknown'
);

-- Test insert
INSERT INTO books (title, price) VALUES ('Book One', 9.99);
INSERT INTO books (title, price, genre) VALUES ('Book Two', 15.50, 'Fiction');

