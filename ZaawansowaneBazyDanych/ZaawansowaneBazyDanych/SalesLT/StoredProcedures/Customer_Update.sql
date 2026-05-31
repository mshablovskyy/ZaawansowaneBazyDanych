CREATE   PROCEDURE SalesLT.Customer_Update
    @CustomerID INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @EmailAddress NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM [237161].[Customer] WHERE CustomerID = @CustomerID)
        THROW 51003, 'Taki rekord nie istnieje.', 1;

    UPDATE [237161].[Customer]
    SET FirstName = @FirstName,
        LastName = @LastName,
        EmailAddress = @EmailAddress
    WHERE CustomerID = @CustomerID;
END
GO

