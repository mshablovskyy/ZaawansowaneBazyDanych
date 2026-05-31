
-- 4) mTVF (multi-statement table-valued function) – kiedy ma sens:
-- Gdy logika to kilka kroków (np. wylicz niedobór, potem zaokrąglij do paczek).
CREATE   FUNCTION Student_1.ufn_ReorderProposal
(
    @AsOfDate DATE
)
RETURNS @Result TABLE
(
    ItemID INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    CurrentQty INT NOT NULL,
    ReorderPoint INT NOT NULL,
    PackSize INT NOT NULL,
    ProposedOrderQty INT NOT NULL
)
AS
BEGIN
    -- Krok 1: policz niedobory na dzień @AsOfDate.
    INSERT INTO @Result (ItemID, Name, CurrentQty, ReorderPoint, PackSize, ProposedOrderQty)
    SELECT
        i.ItemID,
        i.Name,
        CurrentQty = COALESCE(SUM(CASE sm.MovementType WHEN 'IN' THEN sm.Qty ELSE -sm.Qty END), 0),
        i.ReorderPoint,
        i.PackSize,
        ProposedOrderQty = CASE
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
        i.ReorderPoint,
        i.PackSize;

    -- Krok 2: tylko pozycje z zamówieniem > 0.
    DELETE FROM @Result WHERE ProposedOrderQty <= 0;

    -- Krok 3: zaokrąglenie zamówienia w górę do wielokrotności PackSize.
    UPDATE r
    SET r.ProposedOrderQty = ((r.ProposedOrderQty + r.PackSize - 1) / r.PackSize) * r.PackSize
    FROM @Result AS r;

    RETURN;
END;
GO

