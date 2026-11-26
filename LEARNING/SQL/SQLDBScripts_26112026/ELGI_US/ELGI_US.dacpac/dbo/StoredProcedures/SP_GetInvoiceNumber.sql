create proc SP_GetInvoiceNumber (@refnumber nvarchar(max))
as
begin
SELECT [ninv] FROM [ELGI_US].[dbo].[acr_payment] where refnumber = @refnumber;
end

GO

