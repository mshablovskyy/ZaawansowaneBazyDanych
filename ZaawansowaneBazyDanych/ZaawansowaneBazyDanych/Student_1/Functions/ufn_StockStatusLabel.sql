
-- 2) Funkcja skalarna – kiedy ma sens:
-- Gdy mamy prostą regułę biznesową zwracającą 1 wartość (etykietę) do użycia w SELECT.
CREATE   FUNCTION Student_1.ufn_StockStatusLabel
(
    @CurrentQty INT,
    @ReorderPoint INT
)
RETURNS NVARCHAR(10)
AS
BEGIN
    IF @CurrentQty <= 0
        RETURN N'OUT';
    IF @CurrentQty < @ReorderPoint
        RETURN N'LOW';
    RETURN N'OK';
END;
GO

