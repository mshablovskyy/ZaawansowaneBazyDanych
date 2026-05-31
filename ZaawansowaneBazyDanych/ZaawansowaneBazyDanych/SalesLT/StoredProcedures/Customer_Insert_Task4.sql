CREATE   PROCEDURE SalesLT.Customer_Insert_Task4
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @PasswordHash NVARCHAR(128),
    @PasswordSalt NVARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;

    -- Użycie funkcji walidującej z Zadania 4. Funkcja zwraca 1 gdy nie istnieje, 0 gdy istnieje.
    IF dbo.fn_Customer_NotExists(@FirstName, @LastName, NULL) = 0
    BEGIN
        THROW 51002, 'Użytkownik o podanych danych już istnieje (walidacja Zadanie 4).', 1;
    END

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

