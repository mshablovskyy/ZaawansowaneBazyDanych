CREATE TABLE [SalesLT].[CustomerComplaint] (
    [ComplaintID]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [CustomerID]      INT            NOT NULL,
    [SalesOrderID]    INT            NOT NULL,
    [ProductID]       INT            NOT NULL,
    [VendorID]        INT            NOT NULL,
    [ComplaintDate]   DATETIME       DEFAULT (getdate()) NOT NULL,
    [ComplaintStatus] VARCHAR (20)   DEFAULT ('New') NOT NULL,
    [ClosedDate]      DATETIME       NULL,
    [Description]     VARCHAR (1000) NULL,
    CONSTRAINT [PK_CustomerComplaint] PRIMARY KEY CLUSTERED ([ComplaintID] ASC),
    CONSTRAINT [FK_CustomerComplaint_Customer] FOREIGN KEY ([CustomerID]) REFERENCES [237161].[Customer] ([CustomerID]),
    CONSTRAINT [FK_CustomerComplaint_Product] FOREIGN KEY ([ProductID]) REFERENCES [SalesLT].[Product] ([ProductID]),
    CONSTRAINT [FK_CustomerComplaint_SalesOrder] FOREIGN KEY ([SalesOrderID]) REFERENCES [SalesLT].[SalesOrderHeader] ([SalesOrderID]),
    CONSTRAINT [FK_CustomerComplaint_Vendor] FOREIGN KEY ([VendorID]) REFERENCES [SalesLT].[Vendor] ([VendorID])
);


GO
CREATE NONCLUSTERED INDEX [IX_CustomerComplaint_Customer_Date]
    ON [SalesLT].[CustomerComplaint]([CustomerID] ASC, [ComplaintDate] DESC)
    INCLUDE([ComplaintStatus], [ProductID], [SalesOrderID], [Description]);


GO
CREATE NONCLUSTERED INDEX [IX_CustomerComplaint_Open_Status_Date]
    ON [SalesLT].[CustomerComplaint]([ComplaintStatus] ASC, [ComplaintDate] DESC)
    INCLUDE([CustomerID], [ProductID], [SalesOrderID], [Description]) WHERE ([ClosedDate] IS NULL);

