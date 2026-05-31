CREATE   PROCEDURE SalesLT.AddNewProduct
    @Name NVARCHAR(50),
    @ProductNumber NVARCHAR(25) = NULL,
    @ProductCategoryID INT = NULL,
    @ListPrice MONEY,
    @QuantityInStock INT
AS
BEGIN
    SET NOCOUNT ON;

    IF @ListPrice <= 0 OR @QuantityInStock < 0
        THROW 51004, 'Niepoprawne dane wejściowe.', 1;

    BEGIN TRY
        BEGIN TRAN;

        INSERT INTO SalesLT.Product
        (
            Name,
            ProductNumber,
            StandardCost,
            ListPrice,
            SellStartDate,
            ProductCategoryID
        )
        VALUES
        (
            @Name,
            @ProductNumber,
            0,
            @ListPrice,
            GETDATE(),
            @ProductCategoryID
        );

        COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        THROW;
    END CATCH
END
GO

