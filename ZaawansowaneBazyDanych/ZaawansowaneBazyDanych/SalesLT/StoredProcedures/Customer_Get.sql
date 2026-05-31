Create   procedure SalesLT.Customer_Get
    @FirstName nvarchar(50) = null,
    @LastName nvarchar(50) = null,
    @CustomerID int = null,
    @EmailAddress nvarchar(50) = null
AS
BEGIN
    SET NOCOUNT ON;          -- OBOWIĄZKOWE w produkcji

    SELECT *
    FROM [237161].[Customer]
    WHERE (@FirstName IS NULL OR FirstName = @FirstName)
      AND (@LastName IS NULL OR LastName = @LastName)
      AND (@CustomerID IS NULL OR CustomerID = @CustomerID)
      AND (@EmailAddress IS NULL OR EmailAddress = @EmailAddress);
END
GO

