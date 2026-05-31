CREATE   VIEW SalesLT.v_ProductPriceComparison AS
SELECT
    sp.ProductID,
    sp.Name AS ProductName,
    sp.ListPrice AS OldPrice,
    jp.NewPrice,
    ABS(sp.ListPrice - jp.NewPrice) AS PriceDifference
FROM SalesLT.Product as sp INNER JOIN OPENJSON(N'[
	{"ProductID": 708, "NewPrice": 1499.99},
	{"ProductID": 709, "NewPrice": 999.99},
	{"ProductID": 710, "NewPrice": 799.99},
	{"ProductID": 711, "NewPrice": 899.99},
	{"ProductID": 712, "NewPrice": 1099.99}
]')
WITH (
    ProductID INT,
    NewPrice DECIMAL(18, 2)
) AS jp ON sp.ProductID = jp.ProductID;
GO

