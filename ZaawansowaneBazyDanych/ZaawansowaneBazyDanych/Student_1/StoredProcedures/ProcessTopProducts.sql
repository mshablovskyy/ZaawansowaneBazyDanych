CREATE   PROCEDURE Student_1.ProcessTopProducts
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        ProductID,
        Name,
        ListPrice,
        NewPrice = ListPrice - (ListPrice * 0.06)
    FROM #TopProducts;
END
GO

