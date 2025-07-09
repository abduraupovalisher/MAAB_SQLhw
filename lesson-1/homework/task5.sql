CREATE TABLE account (
    account_id INT PRIMARY KEY,
    balance DECIMAL(10, 2) CHECK (balance >= 0),
    account_type VARCHAR(20) CHECK (account_type IN ('Saving', 'Checking'))
);

ALTER TABLE account
DROP CHECK account_balance_check;

ALTER TABLE account
DROP CHECK account_type_check;

ALTER TABLE account
ADD CONSTRAINT account_balance_check CHECK (balance >= 0);

ALTER TABLE account
ADD CONSTRAINT account_type_check CHECK (account_type IN ('Saving', 'Checking'));

