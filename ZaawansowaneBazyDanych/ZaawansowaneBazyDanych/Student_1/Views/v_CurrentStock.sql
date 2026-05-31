
-- 1) Widok – kiedy ma sens:
-- Gdy wiele raportów potrzebuje „bieżącego stanu” bez powtarzania SUM/CASE.
CREATE   VIEW Student_1.v_CurrentStock
AS
    SELECT
        i.ItemID,
        i.Name,
        i.ReorderPoint,
        i.PackSize,
        CurrentQty = COALESCE(SUM(CASE sm.MovementType WHEN 'IN' THEN sm.Qty ELSE -sm.Qty END), 0)
    FROM Student_1.Item AS i
    LEFT JOIN Student_1.StockMovement AS sm
        ON sm.ItemID = i.ItemID
    GROUP BY
        i.ItemID,
        i.Name,
        i.ReorderPoint,
        i.PackSize;
GO

