CREATE PROCEDURE [dbo].[RECIEVEINVOICE] 

	@xmlData xml, 
	@p2 int = 0
AS
BEGIN

	SET NOCOUNT ON;
-- Parse XML
  DECLARE @parsedXmlData int
  declare @documentid nvarchar(255)
  declare @Verbarea xml;
  declare @cmpcode nvarchar(255);
  declare @Trntype nvarchar(255);
  declare @invno  nvarchar (255);
  declare @cuscode  nvarchar (255);
  declare @paycode  nvarchar (255);
  declare @cusname  nvarchar (255);
  declare @payname  nvarchar (255);
  declare @invamt  nvarchar (255);
  declare @invcur  nvarchar (255);
   declare @invref  nvarchar (255);
  
  select @Verbarea			=  @XMLDATA.query('//DataArea/Invoice/InvoiceHeader')
  select @invref  = @XMLDATA.value('(//DataArea/Invoice/InvoiceHeader/DisplayID)[1]'         ,'nvarchar(1024)')
  --select @cmpcode  = @XMLDATA.value('//DataArea/Invoice/InvoiceHeader')
  --select @Trntype  = @XMLDATA.value('//DataArea/Invoice/InvoiceHeader')
  --select @invno    = @XMLDATA.value('//DataArea/Invoice/InvoiceHeader')
  --select @cuscode  = @XMLDATA.value('//DataArea/Invoice/InvoiceHeader')
  --select @paycode  = @XMLDATA.value('//DataArea/Invoice/InvoiceHeader')
  --select @cusname  = @XMLDATA.value('//DataArea/Invoice/InvoiceHeader')
  --select @payname  = @XMLDATA.value('//DataArea/Invoice/InvoiceHeader')
  --select @invamt   = @XMLDATA.value('//DataArea/Invoice/InvoiceHeader')
  --select @invcur   = @XMLDATA.value('//DataArea/Invoice/InvoiceHeader')

  SET @xmlData.modify('delete /DataArea/Sync')

  EXEC sp_xml_preparedocument @parsedXmlData OUTPUT, @xmlData
	SELECT @invref = InvoiceNumber
	FROM OPENXML (@parsedXmlData, '/DataArea/Invoice/InvoiceHeader', 2)
	WITH (InvoiceNumber   varchar(30) 'DocumentID/ID'
        )
	
--insert into [tblinvoice]([ID],[companycode],[transaction_type],[invoice_no],[sold_to_partner_code],[sold_to_partner_name],
--    [ship_to_partner_code],[ship_to_partner_name],[invoice_amount],[currency], [country],[crtdate])
--		values (0,0,0,0,0,0,0,0,getdate())
--END
select @invref
end

GO

