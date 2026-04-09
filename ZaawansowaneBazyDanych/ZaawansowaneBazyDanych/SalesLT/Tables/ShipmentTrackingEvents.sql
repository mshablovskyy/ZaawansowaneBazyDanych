CREATE TABLE [SalesLT].[ShipmentTrackingEvents] (
    [EventID]      BIGINT        NULL,
    [SalesOrderID] INT           NOT NULL,
    [EventDate]    DATETIME      NOT NULL,
    [Location]     VARCHAR (100) NULL,
    [Status]       VARCHAR (50)  NULL,
    [Notes]        VARCHAR (200) NULL
);


GO
CREATE CLUSTERED INDEX [CX_ShipmentTrackingEvents_SalesOrderID_EventDate]
    ON [SalesLT].[ShipmentTrackingEvents]([SalesOrderID] ASC, [EventDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ShipmentTrackingEvents_Status_EventDate]
    ON [SalesLT].[ShipmentTrackingEvents]([Status] ASC, [EventDate] ASC)
    INCLUDE([SalesOrderID], [Location]);

