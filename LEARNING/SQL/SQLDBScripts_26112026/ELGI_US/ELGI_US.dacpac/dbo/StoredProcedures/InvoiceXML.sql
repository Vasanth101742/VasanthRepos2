
create PROCEDURE [dbo].[InvoiceXML] 
    -- Add the parameters for the stored procedure here
    @xmlData xml, 
    @p2 int = 0
AS
BEGIN
   SET NOCOUNT ON;
-- Parse XML
  DECLARE @parsedXmlData int
  declare @documentid nvarchar(255)
  declare @Verbarea xml;
  declare @accountingentity nvarchar(50);
  declare @location nvarchar(50);
  declare @tenantid    nvarchar (50);
  declare @actionexpression nvarchar(50);

 

  --Extract the AccountingEntity/Location
  select @Verbarea            =  @xmlData.query('//DataArea/Sync')
  select @accountingentity  = @xmlData.value('(//DataArea/Sync/AccountingEntityID)[1]'         ,'nvarchar(1024)')
  select @location            = @xmlData.value('(//DataArea/Sync/LocationID)[1]'                 ,'nvarchar(1024)')
  --select @tenantid            = @XMLDATA.value('(//DataArea/Sync/TenantID)[1]'                   ,'nvarchar(1024)')
  --select @actionexpression  = @XMLDATA.value('(//DataArea/Sync/ActionCriteria/ActionExpression/@actionCode)[1]' ,'nvarchar(1024)')

    SET @xmlData.modify('  
      delete /DataArea/Sync  
    ')
  EXEC sp_xml_preparedocument @parsedXmlData OUTPUT, @xmlData
    SELECT @tenantid = orderNumber
    FROM OPENXML (@parsedXmlData, '/DataArea/Invoice/InvoiceHeader', 2)
    WITH (orderNumber   varchar(20) 'DocumentID/ID'
        )

		Insert into xml_test

		select @accountingentity,@location,@tenantid
    --INSERT INTO [dbo].[SALESORDER_TRANSIT] (NOUNNAME, NOUNDATA, DOCUMENT_ID,STATUSFLAG,ACCOUNTING_ENTITY,[LOCATION],[ACTION_CRITERIA],[EN_DATE])
    --    values ('SalesOrder',cast(@XMLDATA as varbinary(max)),@documentid, 0,@accountingentity,@location,@actionexpression,getdate())
END

GO

