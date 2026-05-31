CREATE   FUNCTION Student_1.ufn_CalcAdjustedPrices
(
    @N DECIMAL(5,2) = 1.2
)
RETURNS TABLE
AS
RETURN
SELECT
    ProductID,
    Name,
    ListPrice,
    ListPrice * @N AS NewPrice
FROM dbo.TopProducts;
GO

