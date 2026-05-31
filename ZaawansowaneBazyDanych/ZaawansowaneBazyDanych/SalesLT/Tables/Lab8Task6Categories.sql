CREATE TABLE [SalesLT].[Lab8Task6Categories] (
    [CategoryID]       INT           NOT NULL,
    [ParentCategoryID] INT           NULL,
    [CategoryName]     NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);
GO

