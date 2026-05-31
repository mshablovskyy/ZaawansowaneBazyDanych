CREATE   TRIGGER trg_DatabaseAuditDDL
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.DatabaseAuditLog (EventType, EventData, LoginName)
    SELECT
        EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(50)'),
        EVENTDATA(),
        SYSTEM_USER
    END
GO

