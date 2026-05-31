CREATE TABLE [SalesLT].[DeletedCustomersLog] (
    [LogID]        INT           IDENTITY (1, 1) NOT NULL,
    [CustomerID]   INT           NULL,
    [FirstName]    NVARCHAR (50) NULL,
    [LastName]     NVARCHAR (50) NULL,
    [EmailAddress] NVARCHAR (50) NULL,
    [DeletedAt]    DATETIME2 (7) DEFAULT (sysdatetime()) NULL,
    PRIMARY KEY CLUSTERED ([LogID] ASC)
);
GO

