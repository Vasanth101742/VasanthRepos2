

CREATE proc [dbo].[sp_ProductionPlan] as
begin

declare @Yesterday date= getdate()-1

declare @MonthStart date= datefromparts(year(@Yesterday),month(@Yesterday),1)

declare @cutoffdate date= DATEADD (DAY,
    CASE 
        WHEN DATENAME(WEEKDAY, @Yesterday) = 'Monday' THEN -10
        WHEN DATENAME(WEEKDAY, @Yesterday) = 'Sunday' THEN -9
        ELSE -9
    END,
@Yesterday) 

declare @MonthEnd DATE = EOMONTH(@Yesterday)



--alter table productionPlan add AssemblyLine nvarchar(250)
truncate table ProductionPlan


-----------------STEP 1 : Pending Order as on the 1 st of every Month-------------------

insert into ProductionPlan (TPLCode,TPLDesc,OpeningOrder,assemblyline)
select ltrim(rtrim(itemcode)) 'Item',Item_desc,sum(pendqty) 'OpenQty',
case when dpst in ('90016','90020') then 'Sepsac' end 'AssemblyLine'

from Pending_Orders_History where dpst in ('90016','90020') 
and company='401' and format(UpdatedDatae,'yyyyMM')=format(getdate(),'yyyyMM')
group by ItemCode,item_desc,(case when dpst in ('90016','90020') then 'Sepsac' end)


-----------------STEP 2 : Updating Opening WIP and Opening FG,MTDClosing against Pending Order -------------------

UPDATE productionPlan set OpeningWIP=a.WIP, OpeningFG=a.OpeningFG,MTDClosing=a.MTDClosing,WIPasofDate=a.MTD_WIP  from (
Select ltrim(rtrim(item)) 'Item', itemdescr,isnull(sum(opening_wip),0) 'WIP',isnull(sum(opening_FG),0) 'openingFG', 
isnull(sum(MTD_CLOSING),0) 'MTDClosing',
case when warehouse='257'  then 'Sepsac' 
	when warehouse='357' then 'RCD'
	end 'Assemblyline',
	isnull(sum(MTD_WIP),0) 'MTD_WIP'

from Production_Summary4
where warehouse in ('257','357') and company='401'

group by ltrim(rtrim(item)), itemdescr,
(case when warehouse='257'  then 'Sepsac' 
	when warehouse='357' then 'RCD'
	end )

)a WHERE LTRIM(RTRIM(ProductionPlan.TPLCode))= a.Item and ProductionPlan.Assemblyline=a.Assemblyline

------missing items in opening order but opening is there 

Insert into ProductionPlan (TPLCode,TPLDesc,OpeningWIP,OpeningFG,MTDClosing,Assemblyline)

Select ltrim(rtrim(item)) 'Item', itemdescr,isnull(sum(opening_wip),0) 'WIP',isnull(sum(opening_FG),0) 'openingFG', 
isnull(sum(MTD_Closing),0) 'MTD_Closing',
case when warehouse='257' then 'Sepsac' 
when warehouse='357' then 'RCD' end 'Assemblyline'

from Production_Summary4 a

where warehouse in ('257','357') and company='401' 

and NOT EXISTS
(
    SELECT 1
    FROM ProductionPlan b
	where ltrim(rtrim(a.item))=b.TPLCode and (case when warehouse='257'  then 'Sepsac' 
when warehouse='357' then 'RCD' end)=b.Assemblyline

) 
group by ltrim(rtrim(item)), itemdescr ,warehouse,(
case when warehouse='257' and Description='Sepsac'  then 'Sepsac' 
when warehouse='357' then 'RCD' end
) 


-----------------STEP 3 : Updating Aged FG against Pending Order  -------------------


UPDATE productionPlan set AgedFG=a.Blocked  from (


select distinct ltrim(rtrim(item)) 'Item',sum(cast (qblk as float)) 'Blocked',
case when cwar='257' then 'Sepsac' 
when CWAR='357' then 'RCD' end 'Assemblyline'

from TWHLTC500ALL
where COMPANY='401' and CWAR in ('257' ,'357') and bout<>1
group by item,BOUT,cwar, (case when cwar='257' then 'Sepsac' 
when CWAR='357' then 'RCD' end)


--SELECT ltrim(rtrim(a.item)) 'Item',a.cwar,
--case when a.cwar='257' then 'Sepsac' 
--when a.CWAR='357' then 'RCD' end 'Assemblyline',

--case when ltrim(rtrim(a.item))=ltrim(rtrim(b.Item))
--	and  sum(convert(float,a.qhnd))-sum(convert(float,a.QBLK)) <> isnull(b.QHND,0) then  isnull(b.QHND,0)
--	else sum(convert(float,a.qhnd))-sum(convert(float,a.QBLK)) end 'FG_Stock_new'
--	from TWHWMD215ALL a
--left join (select distinct ltrim(rtrim(item)) 'Item',cwar,
--case when sum(convert(float,qhnd))>0 and bout=1 then sum(convert(float,qhnd))-sum(convert(float,QBLK)) end 'QHND' from TWHLTC500ALL
--where COMPANY='401' and CWAR in ('257' ,'357') and bout=1
--group by item,BOUT,cwar
--)b
--on ltrim(rtrim(a.item))=ltrim(rtrim(b.item)) and a.cwar=b.cwar

--where a.CWAR in ('257','357') and a.COMPANY='401' 
----and ltrim(rtrim(a.item)) = 'B003308170003'

--group by ltrim(rtrim(a.item)),b.QHND,b.Item,a.cwar


) a where ltrim(rtrim(a.item)) = ProductionPlan.Tplcode and ProductionPlan.Assemblyline=a.assemblyline


-----------------STEP 4 : Updating Inflow Qty before last 7 Working days  -------------------

------------------a) Before Last 7th WOrking day

UPDATE productionPlan set inflowUptoCutOffdate=a.InflowQty  from (

select itemcode,item_desc,case when dpst in ('90016','90020') then 'Sepsac' end 'Assemblyline',sum(qty) 'InflowQty'

from sales_inflow

where company='401'  and dpst in ('90016','90020') and orderdate between @MonthStart and @cutoffdate


group by itemcode,item_desc,(case when dpst in ('90016','90020') then 'Sepsac' end)


)a where ltrim(rtrim(a.itemcode)) = ProductionPlan.Tplcode and ProductionPlan.Assemblyline=a.assemblyline
 

------------b) After cutoffdate and within this month

--ALter table productionPlan add BalInflowAfterCUtOffDateValue float

UPDATE productionPlan set BalInflowAfterCUtOffDate =a.InflowQty  from (

select itemcode,item_desc,case when dpst in ('90016','90020') then 'Sepsac' end 'Assemblyline',sum(qty) 'InflowQty'

from sales_inflow

where company='401'  and dpst in ('90016','90020') and (orderdate >  @cutoffdate and orderdate < @MonthEnd)


group by itemcode,item_desc,(case when dpst in ('90016','90020') then 'Sepsac' end)


)a where ltrim(rtrim(a.itemcode)) = ProductionPlan.Tplcode and ProductionPlan.Assemblyline=a.assemblyline

 -----------------STEP 5 : Update productDivision,Productline from OTAMaster  -------------------

 update productionPlan set productDivision=a.division, productline=a.productline  from (
 select * from ota_tpl_master where date =(select max(date) from ota_tpl_master)
 ) a where ltrim(rtrim(a.itemcode)) = ProductionPlan.Tplcode 

 ----alter table productionplan add ItemCategory nvarchar(150)

  
 -----------------STEP 6 : Update Item Category  -------------------

update productionPlan set ItemCategory='ACCESSORIES' WHERE productDivision='ACCESSORIES'

 -----------------STEP 7 : Update UnitPrice  -------------------

update productionPlan set UnitPrice=a.price from (

select ItemCode,avg(sales) 'Price',case when dpst in ('90016','90020') then 'Sepsac' end 'Assemblyline' from  sales_inflow

where company='401'  and dpst in ('90016','90020') and orderdate >= convert(date,getdate()-365)
and qty>0

group by ItemCode,case when dpst in ('90016','90020') then 'Sepsac' end

)a where ltrim(rtrim(a.itemcode)) = ProductionPlan.Tplcode and ProductionPlan.Assemblyline=a.assemblyline

 -----------------STEP 8 : Making all numeric columns to 0 if it is null  -------------------

 Update ProductionPlan set UnitPrice = 0 where Unitprice is null

 Update ProductionPlan set OpeningWIP = 0 where OpeningWIP is null

 Update ProductionPlan set OpeningFG = 0 where OpeningFG is null

 Update ProductionPlan set AgedFG = 0 where AgedFG is null

 Update ProductionPlan set OpeningOrder = 0 where OpeningOrder is null

 Update ProductionPlan set inflowUptoCutOffDate = 0 where inflowUptoCutOffDate is null

 Update ProductionPlan set MTDClosing = 0 where MTDClosing is null

-----------------STEP 9 : Formulas  -------------------

update productionPlan set OpeningFGFinal=openingFG-AgedFG

update productionPlan set OpeningFGFinal=0 where OpeningFGFinal < 0

update ProductionPlan set OpeningFGFinalValue= isnull(OpeningFGFinal * Unitprice,0)

update productionPlan set OpeningOrder=0 where OpeningOrder < 0

update ProductionPlan set OpeningValue= OpeningOrder*UnitPrice

Update ProductionPlan set inflowCutOffDateValue=isnull(inflowUptoCutOffDate * Unitprice,0)

Update ProductionPlan set pendingOrdQtyUptoCutOff= inflowUptoCutOffDate + OpeningOrder

Update ProductionPlan set PendingOrdValueUptoCutOff =isnull(pendingOrdQtyUptoCutOff * Unitprice,0) 

Update ProductionPlan set BalInflowAfterCUtOffDateValue=isnull(BalInflowAfterCUtOffDate * Unitprice,0)

Update ProductionPlan set InflowQty=PendingOrdQtyuptoCutOff + BalInflowAfterCUtOffDate

Update ProductionPlan set InflowValue=isnull(InflowQty * Unitprice,0) 

Update ProductionPlan set BalToReleaseOpeningOrdQty =OpeningOrder-MTDClosing-WIPAsOfdate

Update ProductionPlan set BalToReleaseOpeningOrdQty =0 where BalToReleaseOpeningOrdQty <0

Update ProductionPlan set BalToReleaseOpeningOrdValue =isnull(BalToReleaseOpeningOrdQty * Unitprice,0)  

Update ProductionPlan set BalToCloseOpeningOrdQty =OpeningFGFinal-OpeningOrder-MTDClosing

Update ProductionPlan set BalToCloseOpeningOrdQty =0 where BalToCloseOpeningOrdQty<0

Update ProductionPlan set BalToCloseOpeningOrdValue =isnull(BalToCloseOpeningOrdQty * Unitprice,0)  

Update ProductionPlan set BalToReleaseCutOffQty =pendingOrdQtyUptoCutOff-mtdclosing-wipasofdate-openingfgfinal

Update ProductionPlan set BalToReleaseCutOffQty = 0 where BalToReleaseCutOffQty<0

Update ProductionPlan set BalToReleaseCutOffValue =isnull(BalToReleaseCutOffQty * Unitprice,0)  

Update ProductionPlan set BalToCloseCutOffQty = pendingOrdQtyUptoCutOff-MTDClosing-OpeningFGFinal

Update ProductionPlan set BalToCloseCutOffQty =0 where BalToCloseCutOffQty<0

Update ProductionPlan set BalToCloseCutOffValue =isnull(BalToCloseCutOffQty * Unitprice,0)  

Update ProductionPlan set BalToReleaseTotalOrdQty=InflowQty-OpeningFGFinal-MTDClosing-WIPasofDate

Update ProductionPlan set BalToReleaseTotalOrdQty= 0 where  BalToReleaseTotalOrdQty<0

Update ProductionPlan set BalToReleaseTotalOrdValue =isnull(BalToReleaseTotalOrdQty * Unitprice,0)  

Update ProductionPlan set BalToCloseTotalOrdQty=InflowQty-OpeningFGFinal-MTDClosing

Update ProductionPlan set BalToCloseTotalOrdQty= 0 where  BalToCloseTotalOrdQty<0

Update ProductionPlan set BalToCloseTotalOrdValue =isnull(BalToCloseTotalOrdQty * Unitprice,0)  

end

GO

