CREATE TABLE [Student_1].[MonthlySales] (
    [SaleID]      INT             IDENTITY (1, 1) NOT NULL,
    [ProductName] NVARCHAR (50)   NOT NULL,
    [SaleMonth]   NVARCHAR (20)   NOT NULL,
    [Amount]      DECIMAL (18, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([SaleID] ASC)
);
GO

