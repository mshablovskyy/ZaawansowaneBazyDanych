CREATE TABLE [dbo].[DatabaseAuditLog] (
    [AuditID]   INT           IDENTITY (1, 1) NOT NULL,
    [EventType] NVARCHAR (50) NULL,
    [EventData] XML           NULL,
    [LoginName] [sysname]     NOT NULL,
    [EventTime] DATETIME2 (7) DEFAULT (sysdatetime()) NULL,
    PRIMARY KEY CLUSTERED ([AuditID] ASC)
);
GO

