CREATE PROCEDURE ManageDatabaseOperations
    @Operation NVARCHAR(10),
    @TableName NVARCHAR(50),
    @ProductID INT = NULL,
    @Name NVARCHAR(100) = NULL,
    @Category NVARCHAR(50) = NULL,
    @Price DECIMAL(10,2) = NULL,
    @StockQuantity INT = NULL,
    @EmployeeID INT = NULL,
    @FirstName NVARCHAR(50) = NULL,
    @LastName NVARCHAR(50) = NULL,
    @Department NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @Operation = 'SELECT'
    BEGIN
        IF @TableName = 'Products'
        BEGIN
            SELECT * FROM Products;
        END
        ELSE IF @TableName = 'Employees'
        BEGIN
            SELECT * FROM Employees;
        END
    END
    ELSE IF @Operation = 'INSERT'
    BEGIN
        IF @TableName = 'Products'
        BEGIN
            INSERT INTO Products (ProductID, Name, Category, Price, StockQuantity)
            VALUES (@ProductID, @Name, @Category, @Price, @StockQuantity);
        END
        ELSE IF @TableName = 'Employees'
        BEGIN
            INSERT INTO Employees (EmployeeID, FirstName, LastName, Department)
            VALUES (@EmployeeID, @FirstName, @LastName, @Department);
        END
    END
    ELSE IF @Operation = 'UPDATE'
    BEGIN
        IF @TableName = 'Products'
        BEGIN
            UPDATE Products
            SET Price = @Price
            WHERE ProductID = @ProductID;
        END
        ELSE IF @TableName = 'Employees'
        BEGIN
            UPDATE Employees
            SET Department = @Department
            WHERE EmployeeID = @EmployeeID;
        END
    END
    ELSE IF @Operation = 'DELETE'
    BEGIN
        IF @TableName = 'Products'
        BEGIN
            DELETE FROM Products
            WHERE ProductID = @ProductID;
        END
        ELSE IF @TableName = 'Employees'
        BEGIN
            DELETE FROM Employees
            WHERE EmployeeID = @EmployeeID;
        END
    END
    ELSE IF @Operation = 'MERGE'
    BEGIN
        IF @TableName = 'Products'
        BEGIN
            MERGE Products AS target
            USING (SELECT @ProductID, @Name, @Category, @Price, @StockQuantity) AS source (ProductID, Name, Category, Price, StockQuantity)
            ON (target.ProductID = source.ProductID)
            WHEN MATCHED THEN
                UPDATE SET Name = source.Name, Category = source.Category, Price = source.Price, StockQuantity = source.StockQuantity
            WHEN NOT MATCHED THEN
                INSERT (ProductID, Name, Category, Price, StockQuantity)
                VALUES (source.ProductID, source.Name, source.Category, source.Price, source.StockQuantity);
        END
        ELSE IF @TableName = 'Employees'
        BEGIN
            MERGE Employees AS target
            USING (SELECT @EmployeeID, @FirstName, @LastName, @Department) AS source (EmployeeID, FirstName, LastName, Department)
            ON (target.EmployeeID = source.EmployeeID)
            WHEN MATCHED THEN
                UPDATE SET FirstName = source.FirstName, LastName = source.LastName, Department = source.Department
            WHEN NOT MATCHED THEN
                INSERT (EmployeeID, FirstName, LastName, Department)
                VALUES (source.EmployeeID, source.FirstName, source.LastName, source.Department);
        END
    END
END;
