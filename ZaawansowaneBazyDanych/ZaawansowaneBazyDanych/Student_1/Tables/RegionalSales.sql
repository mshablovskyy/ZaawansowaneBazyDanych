CREATE TABLE [Student_1].[RegionalSales] (
    [SalesID]  INT             IDENTITY (1, 1) NOT NULL,
    [Region]   NVARCHAR (50)   NOT NULL,
    [Category] NVARCHAR (50)   NOT NULL,
    [Revenue]  DECIMAL (18, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([SalesID] ASC)
);
GO

