CREATE TABLE [SalesLT].[ProductVendor] (
    [ProductID]       INT   NOT NULL,
    [VendorID]        INT   NOT NULL,
    [StandardPrice]   MONEY NOT NULL,
    [AverageLeadTime] INT   NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_ProductVendor_ProductID_VendorID]
    ON [SalesLT].[ProductVendor]([ProductID] ASC, [VendorID] ASC);

