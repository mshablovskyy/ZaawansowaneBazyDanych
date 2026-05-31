CREATE TABLE [SalesLT].[ProductPriceIncreaseLog] (
    [LogID]     INT             IDENTITY (1, 1) NOT NULL,
    [ProductID] INT             NULL,
    [OldPrice]  DECIMAL (18, 2) NULL,
    [NewPrice]  DECIMAL (18, 2) NULL,
    [LoggedAt]  DATETIME2 (7)   DEFAULT (sysdatetime()) NULL,
    PRIMARY KEY CLUSTERED ([LogID] ASC)
);
GO

