CREATE PROCEDURE [dbo].[spInsertDepartment]
    @MinPrice DECIMAL(10,2),
    @MaxPrice DECIMAL(10,2),
    @EmployeeId INT,
    @WorkDate DATETIME,
    @WorkDescription VARCHAR(255),
    @HoursWorked DECIMAL(5,2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT ProductId, Name, Category, Price, StockQuantity
    FROM Products
    WHERE Price BETWEEN @MinPrice AND @MaxPrice AND StockQuantity > 0;

    -- Call SaveEmployeeWork procedure
    EXEC dbo.SaveEmployeeWork @EmployeeId, @WorkDate, @WorkDescription, @HoursWorked;
END;
