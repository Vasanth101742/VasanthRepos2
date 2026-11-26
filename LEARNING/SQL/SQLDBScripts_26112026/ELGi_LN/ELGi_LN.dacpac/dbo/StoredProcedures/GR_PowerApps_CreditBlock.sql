
CREATE Proc [dbo].[GR_PowerApps_CreditBlock]
as
begin

Truncate table [dbo].[GR_CreditBlock_LN]

insert into [dbo].[GR_CreditBlock_LN]
select *   from [LN].[PowerApps].[dbo].[CreditBlock_LN]


end

GO

