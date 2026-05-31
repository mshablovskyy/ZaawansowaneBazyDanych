CREATE   VIEW Student_1.v_LatestCustomers AS
SELECT TOP 10 SalesLT.SalesOrderHeader.CustomerID, FirstName, LastName, OrderDate
FROM [237161].Customer INNER JOIN SalesLT.SalesOrderHeader ON [237161].Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID
ORDER BY OrderDate DESC;
GO

