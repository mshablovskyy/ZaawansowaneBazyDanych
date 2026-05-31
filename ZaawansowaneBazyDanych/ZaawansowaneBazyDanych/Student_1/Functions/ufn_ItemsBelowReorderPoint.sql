
-- 3) iTVF (inline table-valued function) – kiedy ma sens:
-- Gdy chcemy „parametryzowany widok” oparty o 1 SELECT (np. stan poniżej minimum na dany dzień).
CREATE   FUNCTION Student_1.ufn_ItemsBelowReorderPoint
(
    @AsOfDate DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        i.ItemID,
        i.Name,
        i.ReorderPoint,
        CurrentQty = COALESCE(SUM(CASE sm.MovementType WHEN 'IN' THEN sm.Qty ELSE -sm.Qty END), 0),
        MissingQty = CASE
            WHEN COALESCE(SUM(CASE sm.MovementType WHEN 'IN' THEN sm.Qty ELSE -sm.Qty END), 0) < i.ReorderPoint
                THEN i.ReorderPoint - COALESCE(SUM(CASE sm.MovementType WHEN 'IN' THEN sm.Qty ELSE -sm.Qty END), 0)
            ELSE 0
        END
    FROM Student_1.Item AS i
    LEFT JOIN Student_1.StockMovement AS sm
        ON sm.ItemID = i.ItemID
        AND sm.MovementDate <= @AsOfDate
    GROUP BY
        i.ItemID,
        i.Name,
        i.ReorderPoint
    HAVING COALESCE(SUM(CASE sm.MovementType WHEN 'IN' THEN sm.Qty ELSE -sm.Qty END), 0) < i.ReorderPoint
);
GO

