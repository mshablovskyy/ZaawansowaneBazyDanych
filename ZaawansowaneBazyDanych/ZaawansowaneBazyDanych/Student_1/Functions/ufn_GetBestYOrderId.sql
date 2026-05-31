CREATE   FUNCTION Student_1.ufn_GetBestYOrderId
(
		@minCreditRating INT = 0,            -- minimalna wartosc CreditRating (domyslnie 0)
		@namePrefix NVARCHAR(50) = N'',      -- prefiks nazwy (domyslnie pusty)
		@requireHighCredit BIT = 0           -- flaga wymuszajaca wysoki CreditRating (domyslnie 0)
)
RETURNS INT
AS
BEGIN
		-- Zwraca VendorID najlepszego rekordu z widoku [237161_order]
		-- Uzywamy TOP 1 z ORDER BY (wymagane przez zadanie)
		DECLARE @result INT = NULL;

		SELECT TOP (1) @result = VendorID
		FROM [237161_order]
		WHERE (@minCreditRating <= 0 OR CreditRating >= @minCreditRating)
			AND (LEN(@namePrefix) = 0 OR Name LIKE @namePrefix + '%')
			AND (@requireHighCredit = 0 OR CreditRating >= 80)
		ORDER BY CreditRating DESC, Name ASC; -- ORDER BY w ciele funkcji

		RETURN @result;
END;
GO

