CREATE TABLE book (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    published_year INT
);

CREATE TABLE member (
    member_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

CREATE TABLE loan (
    loan_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (member_id) REFERENCES member(member_id)
);

INSERT INTO book (book_id, title, author, published_year) VALUES
(1, '1984', 'George Orwell', 1949),
(2, 'To Kill a Mockingbird', 'Harper Lee', 1960);

INSERT INTO member (member_id, name, email, phone_number) VALUES
(1, 'Alice', 'alice@example.com', '1234567890'),
(2, 'Bob', 'bob@example.com', '0987654321');

INSERT INTO loan (loan_id, book_id, member_id, loan_date, return_date) VALUES
(1, 1, 1, '2025-05-01', '2025-05-15'),
(2, 2, 2, '2025-06-01', NULL);

