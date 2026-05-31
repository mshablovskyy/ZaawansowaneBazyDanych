CREATE   FUNCTION dbo.fn_Customer_NotExists
(
    @FirstName NVARCHAR(50) = NULL,
    @LastName NVARCHAR(50) = NULL,
    @EmailAddress NVARCHAR(50) = NULL
)
RETURNS BIT
AS
BEGIN
    DECLARE @Result BIT = 1;

    IF EXISTS (
        SELECT 1
        FROM [237161].[Customer] c
        WHERE (
              (@FirstName IS NULL OR c.FirstName = @FirstName)
          AND (@LastName IS NULL OR c.LastName = @LastName)
          AND (@EmailAddress IS NULL OR c.EmailAddress = @EmailAddress)
        )
    )
    BEGIN
        SET @Result = 0;
    END

    RETURN @Result;
END
GO

