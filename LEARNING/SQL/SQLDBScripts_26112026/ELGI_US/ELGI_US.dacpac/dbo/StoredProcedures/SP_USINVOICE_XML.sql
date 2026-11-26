CREATE proc [dbo].[SP_USINVOICE_XML]   
(@xml xml)
as    
begin  
SET NOCOUNT ON;
--create table Inv_ln_xml (inserttime datetime,ln_xml xml)

delete Inv_ln_xml where  convert(date,inserttime)<=convert(date,getdate()-7)

insert into Inv_ln_xml select getdate(),@xml



 DECLARE @parsedXmlData int
declare @Verbarea xml;
declare @Compnr nvarchar(10)
declare @ninv nvarchar(30) 
declare @docd nvarchar(30) 
declare @itbp nvarchar(15) 
declare @trec nvarchar(10)
declare @ccur nvarchar(3)
declare @amti nvarchar(30)
declare @line nvarchar(5)
declare @rate_1 nvarchar(30)
declare @prod nvarchar(3)
declare @Year nvarchar(5)
declare @dued nvarchar(30)
declare @nama nvarchar(250)
declare @Status nvarchar(30) 
declare @InvType nvarchar(30) 



  --SET @xml.modify('delete /DataArea/Sync')

  --EXEC sp_xml_preparedocument @parsedXmlData OUTPUT, @xml

  select @Verbarea			=  @xml.query('//DataArea/Sync')
  select @Compnr  = @xml.value('(//DataArea/Sync/AccountingEntityID)[1]'         ,'nvarchar(10)')
  select @ninv			= @xml.value('(//DataArea/Invoice/InvoiceHeader/DisplayID)[1]'                ,'nvarchar(30)')
  select @docd			= @xml.value('(//DataArea/Invoice/InvoiceHeader/DocumentDateTime)[1]'                   ,'nvarchar(30)')
  select @itbp  = @xml.value('(//DataArea/Invoice/InvoiceHeader/CustomerParty/PartyIDs/ID)[1]' ,'nvarchar(30)')
  select @ccur  = @xml.value('(//DataArea/Invoice/InvoiceHeader/TotalAmount/@currencyID)[1]' ,'nvarchar(3)')
  select @amti  = @xml.value('(//DataArea/Invoice/InvoiceHeader/TotalAmount)[1]' ,'nvarchar(30)')
  select @rate_1  = @xml.value('(//DataArea/Invoice/InvoiceHeader/CurrencyExchangeRate/TargetUnitBaseNumeric)[1]' ,'nvarchar(30)')
	 select @dued  = @xml.value('(//DataArea/Invoice/InvoiceHeader/PaymentTerm/Term/DueDateTime	)[1]' ,'nvarchar(30)')
  select @nama  = @xml.value('(//DataArea/Invoice/InvoiceHeader/BillToParty/Name)[1]' ,'nvarchar(250)')
  select @Status  = @xml.value('(//DataArea/Invoice/InvoiceHeader/Status/Code	)[1]' ,'nvarchar(30)')
  select @InvType  = @xml.value('(//DataArea/Invoice/@type	)[1]' ,'nvarchar(30)')


  if @Status='Open' and @InvType='Invoice'
   begin

 INSERT INTO [dbo].[USINVOCIE_JSON]
([Compnr],docd,[ninv],[itbp],[ccur],[amti],[rate_1],dued,[nama],[bpid],[Year],[Ageing],[AgeingOrder],DueType)

select @Compnr,@docd,@ninv,@itbp,@ccur,@amti,@rate_1,@dued,@nama,@itbp,year(@docd),
case when  datediff(dd,convert(date,@dued),getdate()-1)<=30 then 'Lessthan30'
when datediff(dd,convert(date,@dued),getdate()-1) between 31 and 60 then '31-60'
when datediff(dd,convert(date,@dued),getdate()-1) between 61 and 90 then '61-90'
when datediff(dd,convert(date,@dued),getdate()-1) between 91 and 120 then '91-120'
when datediff(dd,convert(date,@dued),getdate()-1) between 121 and 150 then '121-150'
when datediff(dd,convert(date,@dued),getdate()-1) between 151 and 180 then '151-180'
when datediff(dd,convert(date,@dued),getdate()-1) between 181 and 366 then '181-366'
when datediff(dd,convert(date,@dued),getdate()-1) between 367 and 732 then 'Greater than 1Yr'
when datediff(dd,convert(date,@dued),getdate()-1) between 733 and 1098 then 'Greater than 2Yrs'
when datediff(dd,convert(date,@dued),getdate()-1) >1098 then 'Greater than 3Yrs' end ,

case when  datediff(dd,convert(date,@dued),getdate()-1)<=30 then '1'
when datediff(dd,convert(date,@dued),getdate()-1) between 31 and 60 then '2'
when datediff(dd,convert(date,@dued),getdate()-1) between 61 and 90 then '3'
when datediff(dd,convert(date,@dued),getdate()-1) between 91 and 120 then '4'
when datediff(dd,convert(date,@dued),getdate()-1) between 121 and 150 then '5'
when datediff(dd,convert(date,@dued),getdate()-1) between 151 and 180 then '6'
when datediff(dd,convert(date,@dued),getdate()-1) between 181 and 366 then '7'
when datediff(dd,convert(date,@dued),getdate()-1) between 367 and 732 then '8'
when datediff(dd,convert(date,@dued),getdate()-1) between 733 and 1098 then '9'
when datediff(dd,convert(date,@dued),getdate()-1) >1098 then '10' end 
,case when @dued is null then null
when datediff(dd,convert(date,@dued),getdate()) >0 then 'OverDue'
else 'WithinDue' end



end 


exec [SP_GR_USInvoice_InDebtors]

end

GO

