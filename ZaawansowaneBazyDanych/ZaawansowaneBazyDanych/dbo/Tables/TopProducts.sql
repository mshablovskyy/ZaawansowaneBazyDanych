CREATE TABLE [dbo].[TopProducts] (
    [ProductID] INT          IDENTITY (1, 1) NOT NULL,
    [Name]      [dbo].[Name] NOT NULL,
    [ListPrice] MONEY        NOT NULL
);
GO

