CREATE   FUNCTION Student_1.ufn_ProductsJsonByCategory(
    @CategoryName NVARCHAR(50)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Result NVARCHAR(MAX)
    SET @Result = (
        SELECT 
            p.ProductID,
            p.Name,
            p.ListPrice,
            pc.Name AS CategoryName
        FROM SalesLT.Product AS p
        INNER JOIN SalesLT.ProductCategory AS pc
            ON pc.ProductCategoryID = p.ProductCategoryID
        WHERE pc.Name = @CategoryName
        FOR JSON PATH
    )
    RETURN @Result;
END;
GO

