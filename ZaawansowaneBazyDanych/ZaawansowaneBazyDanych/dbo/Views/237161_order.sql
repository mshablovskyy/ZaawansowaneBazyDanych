CREATE   VIEW [237161_order] AS
SELECT TOP 20 VendorID, Name, CreditRating FROM SalesLT.Vendor
WHERE VendorID BETWEEN 1 AND 20
ORDER BY CreditRating DESC;
GO

