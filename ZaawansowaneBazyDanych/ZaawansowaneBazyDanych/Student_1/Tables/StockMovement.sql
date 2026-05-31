CREATE TABLE [Student_1].[StockMovement] (
    [MovementID]   INT      IDENTITY (1, 1) NOT NULL,
    [ItemID]       INT      NOT NULL,
    [MovementDate] DATE     NOT NULL,
    [MovementType] CHAR (3) NOT NULL,
    [Qty]          INT      NOT NULL
);
GO

ALTER TABLE [Student_1].[StockMovement]
    ADD CONSTRAINT [CK_Student_1_StockMovement_Type] CHECK ([MovementType]='OUT' OR [MovementType]='IN');
GO

ALTER TABLE [Student_1].[StockMovement]
    ADD CONSTRAINT [CK_Student_1_StockMovement_Qty] CHECK ([Qty]>(0));
GO

ALTER TABLE [Student_1].[StockMovement]
    ADD CONSTRAINT [FK_Student_1_StockMovement_Item] FOREIGN KEY ([ItemID]) REFERENCES [Student_1].[Item] ([ItemID]);
GO

ALTER TABLE [Student_1].[StockMovement]
    ADD CONSTRAINT [PK_Student_1_StockMovement] PRIMARY KEY CLUSTERED ([MovementID] ASC);
GO

