

CREATE proc [SP_GR_INVENTORYTREND]
as
begin



delete InventoryData_Trend where [CurDate]< convert(date,getdate()-90)
delete InventoryData_Trend where [CurDate]= convert(date,getdate())

insert into InventoryData_Trend

select company,Ageing,convert(decimal(19,2),(SUM(StVal)/1000000))'STVAL',convert(date,getdate())'CurDate',sum(convert(decimal(19,0),OnHand)) from [InventoryData] 
GROUP BY company,Ageing
ORDER BY  company,Ageing

end

GO

