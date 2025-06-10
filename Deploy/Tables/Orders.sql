CREATE TABLE Orders (
    OrderId INT PRIMARY KEY,
    CustomerId INT,
    OrderDate DATETIME,
    Status VARCHAR(20),
    TotalAmount DECIMAL(10,2)
);