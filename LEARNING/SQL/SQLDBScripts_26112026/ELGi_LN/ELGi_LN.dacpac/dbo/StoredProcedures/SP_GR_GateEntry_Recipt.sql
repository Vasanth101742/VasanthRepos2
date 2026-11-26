

CREATE Proc [dbo].[SP_GR_GateEntry_Recipt]
as
begin

truncate table GateEntry_Recipt

insert into GateEntry_Recipt

select * from [LN].[Powerapps].[dbo].[GateEntry_Recipt]

end

GO

