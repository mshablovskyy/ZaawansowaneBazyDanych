-- =============================================
-- Maksym
-- Shablovskyy
-- 237161
-- =============================================
-- X - m
-- Y - 237161
-- N - 1
-- =============================================
-- Zadanie 1
-- =============================================
-- Funkcja skalara zwraca identyfikator najlepszego rekordu z widoku Y_order
-- Reużyje widoku [237161_order] utworzonego w [lab-7.sql]
-- Parametry: 3 różne typy z wartościami domyślnymi
CREATE   FUNCTION dbo.ufn_GetBestFromYOrder
(
		@MinCreditRating INT = 0,            -- minimalna ocena kredytowa (domyślnie 0)
		@NamePrefix NVARCHAR(50) = N'',      -- filtr po prefiksie nazwy (domyślnie puste - brak filtra)
		@Strict BIT = 0                      -- tryb ścisły (0 = ignoruj prefiks, 1 = stosuj dokładnie)
)
RETURNS INT
AS
BEGIN
		DECLARE @BestID INT;

		-- Wybieramy najlepszy rekord z widoku [237161_order] (Y_order)
		SELECT TOP 1 @BestID = VendorID
		FROM [237161_order]
		WHERE (@NamePrefix = N'' OR (@Strict = 0 AND Name LIKE @NamePrefix + N'%') OR (@Strict = 1 AND Name = @NamePrefix))
			AND CreditRating >= @MinCreditRating
		ORDER BY CreditRating DESC; -- wymagane ORDER BY w zadaniu

		RETURN ISNULL(@BestID, 0);
END;
GO

