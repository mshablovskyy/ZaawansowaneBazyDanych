CREATE TABLE [SalesLT].[Product] (
    [ProductID]              INT              IDENTITY (1, 1) NOT NULL,
    [Name]                   [dbo].[Name]     NOT NULL,
    [ProductNumber]          NVARCHAR (25)    NOT NULL,
    [Color]                  NVARCHAR (15)    NULL,
    [StandardCost]           MONEY            NOT NULL,
    [ListPrice]              MONEY            NOT NULL,
    [Size]                   NVARCHAR (5)     NULL,
    [Weight]                 DECIMAL (8, 2)   NULL,
    [ProductCategoryID]      INT              NULL,
    [ProductModelID]         INT              NULL,
    [SellStartDate]          DATETIME         NOT NULL,
    [SellEndDate]            DATETIME         NULL,
    [DiscontinuedDate]       DATETIME         NULL,
    [ThumbNailPhoto]         VARBINARY (MAX)  NULL,
    [ThumbnailPhotoFileName] NVARCHAR (50)    NULL,
    [rowguid]                UNIQUEIDENTIFIER CONSTRAINT [DF_Product_rowguid] DEFAULT (newid()) NOT NULL,
    [ModifiedDate]           DATETIME         CONSTRAINT [DF_Product_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Product_ProductID] PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [CK_Product_ListPrice] CHECK ([ListPrice]>=(0.00)),
    CONSTRAINT [CK_Product_SellEndDate] CHECK ([SellEndDate]>=[SellStartDate] OR [SellEndDate] IS NULL),
    CONSTRAINT [CK_Product_StandardCost] CHECK ([StandardCost]>=(0.00)),
    CONSTRAINT [CK_Product_Weight] CHECK ([Weight]>(0.00)),
    CONSTRAINT [FK_Product_ProductCategory_ProductCategoryID] FOREIGN KEY ([ProductCategoryID]) REFERENCES [SalesLT].[ProductCategory] ([ProductCategoryID]),
    CONSTRAINT [FK_Product_ProductModel_ProductModelID] FOREIGN KEY ([ProductModelID]) REFERENCES [SalesLT].[ProductModel] ([ProductModelID]),
    CONSTRAINT [AK_Product_Name] UNIQUE NONCLUSTERED ([Name] ASC),
    CONSTRAINT [AK_Product_ProductNumber] UNIQUE NONCLUSTERED ([ProductNumber] ASC),
    CONSTRAINT [AK_Product_rowguid] UNIQUE NONCLUSTERED ([rowguid] ASC)
);


GO

CREATE   TRIGGER SalesLT.trg_Product_BlockBigPriceIncrease
ON SalesLT.Product
INSTEAD OF UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN deleted d ON i.ProductID = d.ProductID
        WHERE i.ListPrice > d.ListPrice * 1.2
    )
    BEGIN
        INSERT INTO SalesLT.ProductPriceIncreaseLog (ProductID, OldPrice, NewPrice)
        SELECT
            i.ProductID,
            d.ListPrice,
            i.ListPrice
        FROM inserted i
        JOIN deleted d ON i.ProductID = d.ProductID
        WHERE i.ListPrice > d.ListPrice * 1.2;
        RETURN;
    END;

    UPDATE p
    SET
        p.Name = i.Name,
        p.ProductNumber = i.ProductNumber,
        p.Color = i.Color,
        p.StandardCost = i.StandardCost,
        p.ListPrice = i.ListPrice,
        p.Size = i.Size,
        p.Weight = i.Weight,
        p.ProductCategoryID = i.ProductCategoryID,
        p.ProductModelID = i.ProductModelID,
        p.SellStartDate = i.SellStartDate,
        p.SellEndDate = i.SellEndDate,
        p.DiscontinuedDate = i.DiscontinuedDate,
        p.ThumbNailPhoto = i.ThumbNailPhoto,
        p.ThumbnailPhotoFileName = i.ThumbnailPhotoFileName,
        p.rowguid = i.rowguid,
        p.ModifiedDate = i.ModifiedDate
    FROM SalesLT.Product p
    JOIN inserted i ON p.ProductID = i.ProductID;
END;
GO



CREATE   TRIGGER SalesLT.trg_Product_PriceChange
ON SalesLT.Product
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO SalesLT.ProductPriceHistory (ProductID, OldPrice, NewPrice)
    SELECT
        i.ProductID,
        d.ListPrice AS OldPrice,
        i.ListPrice AS NewPrice
    FROM inserted i
    JOIN deleted d ON i.ProductID = d.ProductID
    WHERE ISNULL(d.ListPrice, -1) <> ISNULL(i.ListPrice, -1);
END;
GO

