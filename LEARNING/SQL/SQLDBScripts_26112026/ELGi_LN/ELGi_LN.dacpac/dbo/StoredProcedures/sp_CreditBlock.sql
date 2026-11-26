



CREATE Proc [dbo].[sp_CreditBlock] (@XML as XML)
as
begin

insert into CreditBlock_XML (XMLValue,CreateDate)
select @XML,getdate() 

return 1

end

GO

