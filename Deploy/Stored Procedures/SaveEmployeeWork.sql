CREATE PROCEDURE [dbo].[SaveEmployeeWork]
    @EmployeeId INT,
    @WorkDate DATETIME,
    @WorkDescription VARCHAR(255),
    @HoursWorked DECIMAL(5,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO EmployeeWork (EmployeeId, WorkDate, WorkDescription, HoursWorked)
    VALUES (@EmployeeId, @WorkDate, @WorkDescription, @HoursWorked);
END;