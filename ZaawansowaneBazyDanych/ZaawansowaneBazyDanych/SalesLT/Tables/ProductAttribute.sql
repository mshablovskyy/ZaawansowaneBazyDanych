CREATE TABLE [SalesLT].[ProductAttribute] (
    [AttributeID] INT                                             IDENTITY (1, 1) NOT NULL,
    [ProductID]   INT                                             NOT NULL,
    [Attributes]  XML(CONTENT [SalesLT].[ProductAttributeSchema]) NULL,
    PRIMARY KEY CLUSTERED ([AttributeID] ASC)
);
GO

ALTER TABLE [SalesLT].[ProductAttribute]
    ADD CONSTRAINT [FK_ProductAttribute_Product] FOREIGN KEY ([ProductID]) REFERENCES [SalesLT].[Product] ([ProductID]);
GO

