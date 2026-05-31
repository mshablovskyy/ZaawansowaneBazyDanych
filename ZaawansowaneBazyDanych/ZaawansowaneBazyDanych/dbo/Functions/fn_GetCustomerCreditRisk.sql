CREATE   FUNCTION dbo.fn_GetCustomerCreditRisk
(
    @CustomerID INT
)
RETURNS VARCHAR(10)
AS
BEGIN
    -- Wyniki pośrednie trzymamy w zmiennej tabelowej (wymaganie zadania).
    DECLARE @Orders TABLE
    (
        SalesOrderID INT NOT NULL,
        TotalDue DECIMAL(18,2) NOT NULL,
        DueDate DATETIME NULL,
        ShipDate DATETIME NULL,
        DaysLate INT NOT NULL,
        IsLate BIT NOT NULL
    );

    IF @CustomerID IS NULL
        RETURN NULL;

    INSERT INTO @Orders (SalesOrderID, TotalDue, DueDate, ShipDate, DaysLate, IsLate)
    SELECT
        soh.SalesOrderID,
        CAST(soh.TotalDue AS DECIMAL(18,2)) AS TotalDue,
        soh.DueDate,
        soh.ShipDate,
        DaysLate = CASE
            WHEN soh.ShipDate IS NULL OR soh.DueDate IS NULL THEN 0
            ELSE DATEDIFF(DAY, soh.DueDate, soh.ShipDate)
        END,
        IsLate = CASE
            WHEN soh.ShipDate IS NOT NULL
                 AND soh.DueDate IS NOT NULL
                 AND DATEDIFF(DAY, soh.DueDate, soh.ShipDate) > 3
                THEN 1
            ELSE 0
        END
    FROM SalesLT.SalesOrderHeader AS soh
    WHERE soh.CustomerID = @CustomerID;

    DECLARE @TotalAmount DECIMAL(18,2) = 0;
    DECLARE @LateCount INT = 0;

    SELECT
        @TotalAmount = COALESCE(SUM(o.TotalDue), 0),
        @LateCount = COALESCE(SUM(CASE WHEN o.IsLate = 1 THEN 1 ELSE 0 END), 0)
    FROM @Orders AS o;

    IF @TotalAmount > 100000 AND @LateCount >= 2
        RETURN 'HIGH';
    IF @TotalAmount > 50000
        RETURN 'MEDIUM';
    RETURN 'LOW';
END;
GO

