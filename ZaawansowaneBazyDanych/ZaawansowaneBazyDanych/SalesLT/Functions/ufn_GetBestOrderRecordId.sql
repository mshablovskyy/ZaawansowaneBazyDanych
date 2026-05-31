-- =============================================
-- Maksym
-- Shablovskyy
-- 237161
-- =============================================
-- X - m
-- Y - 237161
-- N - 1
-- =============================================

-- =============================================
-- Zadanie 1
-- =============================================

CREATE   FUNCTION SalesLT.ufn_GetBestOrderRecordId
(
	@MinVendorID INT = 1,               
	@NameLike NVARCHAR(100) = N'%',     
	@OrderDescending BIT = 1            
)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT

    if @OrderDescending = 1
    BEGIN
        SELECT TOP (1) @Result = VendorID
        FROM [237161_order]
        WHERE VendorID >= @MinVendorID
            AND Name LIKE @NameLike
        ORDER BY CreditRating DESC
    END
    ELSE
    BEGIN
        SELECT TOP (1) @Result = VendorID
        FROM [237161_order]
        WHERE VendorID >= @MinVendorID
            AND Name LIKE @NameLike
        ORDER BY CreditRating ASC
    END

	RETURN @Result;
END;
GO

