CREATE PROCEDURE RetrieveOrders
    @CustomerId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT OrderId, OrderDate, Status, TotalAmount
    FROM Orders
    WHERE CustomerId = @CustomerId AND Status = 'Active';
END;