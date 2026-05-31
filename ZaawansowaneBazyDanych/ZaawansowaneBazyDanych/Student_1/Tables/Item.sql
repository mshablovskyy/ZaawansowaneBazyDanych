CREATE TABLE [Student_1].[Item] (
    [ItemID]       INT            IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (100) NOT NULL,
    [ReorderPoint] INT            NOT NULL,
    [PackSize]     INT            NOT NULL
);
GO

ALTER TABLE [Student_1].[Item]
    ADD CONSTRAINT [DF_Student_1_Item_PackSize] DEFAULT ((1)) FOR [PackSize];
GO

ALTER TABLE [Student_1].[Item]
    ADD CONSTRAINT [CK_Student_1_Item_PackSize] CHECK ([PackSize]>(0));
GO

ALTER TABLE [Student_1].[Item]
    ADD CONSTRAINT [CK_Student_1_Item_ReorderPoint] CHECK ([ReorderPoint]>=(0));
GO

ALTER TABLE [Student_1].[Item]
    ADD CONSTRAINT [PK_Student_1_Item] PRIMARY KEY CLUSTERED ([ItemID] ASC);
GO

