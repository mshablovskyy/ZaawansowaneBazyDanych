CREATE   FUNCTION Student_1.ufn_IsPriceHigherThanCurrent
(
    @Json NVARCHAR(MAX)
)
RETURNS BIT
AS
BEGIN
    DECLARE @ProductID INT;
    DECLARE @JsonPrice DECIMAL(18,2);
    DECLARE @CurrentPrice DECIMAL(18,2);
    SET @ProductID = JSON_VALUE(@Json, '$.ProductID');

    SET @JsonPrice = JSON_VALUE(@Json, '$.ListPrice');

    IF @ProductID IS NULL OR @JsonPrice IS NULL
        RETURN NULL;

    SELECT @CurrentPrice = p.ListPrice
    FROM SalesLT.Product AS p
    WHERE p.ProductID = @ProductID;

    IF @CurrentPrice IS NULL
        RETURN NULL;

    RETURN IIF(@JsonPrice > @CurrentPrice, 1, 0);
END;
GO

