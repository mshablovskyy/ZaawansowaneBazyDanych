CREATE   PROCEDURE SalesLT.Customer_Insert
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @PasswordHash NVARCHAR(128),
    @PasswordSalt NVARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;          -- OBOWIĄZKOWE w produkcji

    INSERT into [237161].Customer
    (
        FirstName,
        LastName,
        PasswordHash,
        PasswordSalt
    ) VALUES
    (
        @FirstName,
        @LastName,
        @PasswordHash,
        @PasswordSalt
    )
END
GO

