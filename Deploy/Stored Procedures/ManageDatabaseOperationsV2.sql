CREATE PROCEDURE ManageDatabaseOperationsV2
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
    @Department NVARCHAR(50) = NULL,
    @Salary DECIMAL(10,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SQL NVARCHAR(MAX);

    IF @Operation = 'SELECT'
    BEGIN
        IF @TableName = 'Products'
        BEGIN
            SET @SQL = 'SELECT * FROM Products';
        END
        ELSE IF @TableName = 'Employees'
        BEGIN
            SET @SQL = 'SELECT * FROM Employees';
        END
    END
    ELSE IF @Operation = 'INSERT'
    BEGIN
        IF @TableName = 'Products'
        BEGIN
            SET @SQL = 'INSERT INTO Products (ProductID, Name, Category, Price, StockQuantity) VALUES (' + CAST(@ProductID AS NVARCHAR) + ', ''' + @Name + ''', ''' + @Category + ''', ' + CAST(@Price AS NVARCHAR) + ', ' + CAST(@StockQuantity AS NVARCHAR) + ')';
        END
        ELSE IF @TableName = 'Employees'
        BEGIN
            SET @SQL = 'INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary) VALUES (' + CAST(@EmployeeID AS NVARCHAR) + ', ''' + @FirstName + ''', ''' + @LastName + ''', ''' + @Department + ''', ' + CAST(@Salary AS NVARCHAR) + ')';
        END
    END
    ELSE IF @Operation = 'UPDATE'
    BEGIN
        IF @TableName = 'Products'
        BEGIN
            SET @SQL = 'UPDATE Products SET Name = ''' + @Name + ''', Category = ''' + @Category + ''', Price = ' + CAST(@Price AS NVARCHAR) + ', StockQuantity = ' + CAST(@StockQuantity AS NVARCHAR) + ' WHERE ProductID = ' + CAST(@ProductID AS NVARCHAR);
        END
        ELSE IF @TableName = 'Employees'
        BEGIN
            SET @SQL = 'UPDATE Employees SET FirstName = ''' + @FirstName + ''', LastName = ''' + @LastName + ''', Department = ''' + @Department + ''', Salary = ' + CAST(@Salary AS NVARCHAR) + ' WHERE EmployeeID = ' + CAST(@EmployeeID AS NVARCHAR);
        END
    END
    ELSE IF @Operation = 'DELETE'
    BEGIN
        IF @TableName = 'Products'
        BEGIN
            SET @SQL = 'DELETE FROM Products WHERE ProductID = ' + CAST(@ProductID AS NVARCHAR);
        END
        ELSE IF @TableName = 'Employees'
        BEGIN
            SET @SQL = 'DELETE FROM Employees WHERE EmployeeID = ' + CAST(@EmployeeID AS NVARCHAR);
        END
    END
    ELSE IF @Operation = 'MERGE'
    BEGIN
        IF @TableName = 'Products'
        BEGIN
            SET @SQL = 'MERGE Products AS target USING (SELECT ' + CAST(@ProductID AS NVARCHAR) + ', ''' + @Name + ''', ''' + @Category + ''', ' + CAST(@Price AS NVARCHAR) + ', ' + CAST(@StockQuantity AS NVARCHAR) + ') AS source (ProductID, Name, Category, Price, StockQuantity) ON (target.ProductID = source.ProductID) WHEN MATCHED THEN UPDATE SET Name = source.Name, Category = source.Category, Price = source.Price, StockQuantity = source.StockQuantity WHEN NOT MATCHED THEN INSERT (ProductID, Name, Category, Price, StockQuantity) VALUES (source.ProductID, source.Name, source.Category, source.Price, source.StockQuantity)';
        END
        ELSE IF @TableName = 'Employees'
        BEGIN
            SET @SQL = 'MERGE Employees AS target USING (SELECT ' + CAST(@EmployeeID AS NVARCHAR) + ', ''' + @FirstName + ''', ''' + @LastName + ''', ''' + @Department + ''', ' + CAST(@Salary AS NVARCHAR) + ') AS source (EmployeeID, FirstName, LastName, Department, Salary) ON (target.EmployeeID = source.EmployeeID) WHEN MATCHED THEN UPDATE SET FirstName = source.FirstName, LastName = source.LastName, Department = source.Department, Salary = source.Salary WHEN NOT MATCHED THEN INSERT (EmployeeID, FirstName, LastName, Department, Salary) VALUES (source.EmployeeID, source.FirstName, source.LastName, source.Department, source.Salary)';
        END
    END
    EXEC sp_executesql @SQL;
END;
