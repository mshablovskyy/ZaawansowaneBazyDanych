CREATE   FUNCTION Student_1.ufn_CheckProductsPrice
(
    @ID INT,
    @Price DECIMAL(18,2)
)
RETURNS @Result TABLE
(
    ProductID INT,
    Name NVARCHAR(100),
    CurrentListPrice DECIMAL(18,2),
    JsonListPrice DECIMAL(18,2),
    IsHigherThanCurrent BIT
)
AS
BEGIN
    DECLARE @MyJSON NVARCHAR(MAX);

    -- Budujemy JSON obiektu produktu z parametrów.
    -- (FOR JSON PATH jest bezpieczniejsze niż ręczne sklejanie stringów.)
    SET @MyJSON = (
        SELECT
            @ID AS ProductID,
            @Price AS ListPrice
        FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
    );

    INSERT INTO @Result (ProductID, Name, CurrentListPrice, JsonListPrice, IsHigherThanCurrent)
    SELECT
        p.ProductID,
        p.Name,
        p.ListPrice AS CurrentListPrice,
        @Price AS JsonListPrice,
        Student_1.ufn_IsPriceHigherThanCurrent(@MyJSON) AS IsHigherThanCurrent
    FROM SalesLT.Product AS p
    WHERE p.ProductID = @ID;

    RETURN;
END;
GO

