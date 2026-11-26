
--exec sp_Bin_Effective_Check
CREATE Proc [dbo].[sp_Bin_Effective_Check] as
begin

--alter table Bin_Effective_Check alter column itemdesc nvarchar(250)
Truncate table Bin_Effective_Check

--alter table Bin_Effective_Check add  T$COMP int
 
 ----------- Step 1- Bin qty & Slot qty ------------------
Insert into Bin_Effective_Check(Company,T$COMP,ItemType,Region,ProductGroup,Item,
MODEL,BINType,BinQty,SlotQty,Block,SalesOffice)
(select distinct Company,T$COMP,T$ITYP,T$REGN,T$PGRP,ltrim(rtrim(T$ITEM)) T$ITEM,T$MODL,T$BTYP,T$BQTY,T$SLOQ,T$BLCK,
T$SOFC from TZZSLS316ALL where T$COMP in ('401','490'))
--where company=490

update Bin_Effective_Check set TotalQty=BinQty*SlotQty

update Bin_Effective_Check set ItemDesc=a.t_dsca
from (select distinct t_item,t_dsca from TTCIBD001400)a
where ltrim(rtrim(Bin_Effective_Check.Item))=ltrim(rtrim(a.t_item))
and Bin_Effective_Check.company=401


update Bin_Effective_Check set ItemDesc=a.dsca
from (select distinct item,dsca from TTCIBD001490 )a
where ltrim(rtrim(Bin_Effective_Check.Item))=ltrim(rtrim(a.item))
and Bin_Effective_Check.company=490

update Bin_Effective_Check set ItemType='Units' where ItemType='1'
update Bin_Effective_Check set ItemType='Spares' where ItemType='2'

update Bin_Effective_Check set Region='GULF' where Region='1'
update Bin_Effective_Check set Region='CHINA' where Region='2'
update Bin_Effective_Check set Region='BRAZIL' where Region='3'
update Bin_Effective_Check set Region='AUSTRALIA' where Region='4'
update Bin_Effective_Check set Region='USA' where Region='5'
update Bin_Effective_Check set Region='INDONESIA' where Region='6'
update Bin_Effective_Check set Region='ROTAIR' where Region='8'
update Bin_Effective_Check set Region='IAS' where Region='9'

update Bin_Effective_Check set ProductGroup='SEPSAC' where ProductGroup='1'
update Bin_Effective_Check set ProductGroup='LEPSAC' where ProductGroup='2'
update Bin_Effective_Check set ProductGroup='DPSAC' where ProductGroup='3'
update Bin_Effective_Check set ProductGroup='OFSAC' where ProductGroup='4'
update Bin_Effective_Check set ProductGroup='RCD' where ProductGroup='5'
update Bin_Effective_Check set ProductGroup='RAILWAY' where ProductGroup='6'
update Bin_Effective_Check set ProductGroup='RAILWAY_TOPBLOCK' where ProductGroup='7'
update Bin_Effective_Check set ProductGroup='ENGC' where ProductGroup='8'
update Bin_Effective_Check set ProductGroup='BOREWELL' where ProductGroup='9'
update Bin_Effective_Check set ProductGroup='ROTOR_SHOP' where ProductGroup='10'
update Bin_Effective_Check set ProductGroup='SPARES' where ProductGroup='11'

update Bin_Effective_Check set BINType='TWO_BIN' where BINType='1'
update Bin_Effective_Check set BINType='Maximum_Sales_Qty' where BINType='2'
update Bin_Effective_Check set BINType='MULTI_BIN' where BINType='3'
update Bin_Effective_Check set BINType='NO_BIN' where BINType='4'

update Bin_Effective_Check set Block='Yes' where Block='1'
update Bin_Effective_Check set Block='No' where Block='2'

--------Step -2 Stock qty and value------------------------------

update Bin_Effective_Check set StockQty=a.QSKT,StockValue=a.Amnt4
from (select company,Item,sum(QSKT) QSKT,sum(Amnt4) Amnt4 from Inventory
where company in ('500') and CWAR in ('G64','G84')
group by company,Item
)a
where 
--Bin_Effective_Check.company=a.company and
 ltrim(rtrim(Bin_Effective_Check.item))=ltrim(rtrim(a.item)) and Bin_Effective_Check.Region='Gulf'

 update Bin_Effective_Check set StockQty=0,StockValue=0 where StockQty is null


update Bin_Effective_Check set Stock_3Mto6M_qty=a.qskt, Stock_3Mto6M_value=a.Amnt4 from 
(select company,item,sum(qskt) QSKT,sum(Amnt4) 'Amnt4' from Inventory
where company in ('500') and CWAR in ('G64','G84') and datediff(dd,TRDT,getdate()-1) between 91 and 180  
group by company,Item)a
where ltrim(rtrim(Bin_Effective_Check.Item))=ltrim(rtrim(a.Item)) and Bin_Effective_Check.Region='Gulf'

update Bin_Effective_Check set Stock_6Mto12M_qty=a.qskt, Stock_6Mto12M_value=a.Amnt4 from 
(select company,item,sum(qskt) QSKT,sum(Amnt4) 'Amnt4' from Inventory
where company in ('500') and CWAR in ('G64','G84') and datediff(dd,TRDT,getdate()-1) between 181 and 365  
group by company,Item)a
where ltrim(rtrim(Bin_Effective_Check.Item))=ltrim(rtrim(a.Item)) and Bin_Effective_Check.Region='Gulf'


update Bin_Effective_Check set Stock_12Mto24M_qty=a.qskt, Stock_12Mto24M_value=a.Amnt4 from 
(select company,item,sum(qskt) QSKT,sum(Amnt4) 'Amnt4' from Inventory
where company in ('500') and CWAR in ('G64','G84') and datediff(dd,TRDT,getdate()-1) between 366 and 730  
group by company,Item)a
where ltrim(rtrim(Bin_Effective_Check.Item))=ltrim(rtrim(a.Item)) and Bin_Effective_Check.Region='Gulf'


update Bin_Effective_Check set Stock_gr24M_qty=a.qskt, Stock_gr24M_value=a.Amnt4 from 
(select company,item,sum(qskt) QSKT,sum(Amnt4) 'Amnt4' from Inventory
where company in ('500') and CWAR in ('G64','G84') and datediff(dd,TRDT,getdate()-1) > 731
group by company,Item)a
where ltrim(rtrim(Bin_Effective_Check.Item))=ltrim(rtrim(a.Item)) and Bin_Effective_Check.Region='Gulf'


--------------------Step 3 -Pending order qty----------------------------------

--As per mail, dpst required is 70238,70239&70240
update Bin_Effective_Check set PendOrdrQty=a.PendQty
from(select distinct ItemCode,sum(PendQty) PendQty from pending_orders
where Warehouse='G84' and dpst in ('70238','70239','70240') and company='500'
group by ItemCode
)a
where ltrim(rtrim(Bin_Effective_Check.item))=ltrim(rtrim(a.ItemCode)) and Bin_Effective_Check.Region='Gulf'


update Bin_Effective_Check set Pndqty_401_490=a.PendQty from
(select distinct Company,ItemCode,sum(pendqty) PendQty from pending_orders 
where company in ('401','490') 
and custcode in ('CU1E00625','DLY002152')
group by itemcode,Company)a
where ltrim(rtrim(Bin_Effective_Check.Item))=ltrim(rtrim(a.ItemCode)) and Bin_Effective_Check.Company=a.Company  and Bin_Effective_Check.Region='Gulf'


---------------- Step 4 pending purchase order qty---------------------------------------
update Bin_Effective_Check set pendingPOtoHO=a.pend_qty
from (select distinct company,item,sum(qoor) 'Ord qty',sum(qiap) 'Approved Qty',sum(qoor-qiap) 'pend_qty'
--,qibo 'Back ord qty' 
from [dbo].TTDPUR401ALL 
where company='500' and cwar='G64' and ltrim(rtrim(sfbp))='SU1E00438' and qoor<>QIAP and CLYN=2 and ltrim(rtrim(orno)) like '300%'
group by company,item
 )a where ltrim(rtrim(Bin_Effective_Check.Item))=ltrim(rtrim(a.item))  and Bin_Effective_Check.Region='Gulf'



---------------------------- Step 5 Sales Quantity------------------------------------------------------------------

Update Bin_Effective_Check set salesqty=a.salesQty from 
(select distinct itemcode,sum(deliveredQty) 'SalesQty',sum(AssesValue) 'SalesAmount' 
from sales_report_LN 
where
--company in ('401','490') and 
dpst in ('70238','70239','70240')
--group by company,ItemCode
group by ItemCode)a 
where ltrim(rtrim(Bin_Effective_Check.Item))=ltrim(rtrim(a.ItemCode)) and Bin_Effective_Check.Region='Gulf'
--and Bin_Effective_Check.Company=a.company

update Bin_Effective_Check set SalesQty_3M=a.SalesQty_3M from 
(select distinct itemcode,sum(AssesValue) 'SalesValue_3M',sum(DeliveredQty) 'SalesQty_3M'
from sales_report_ln 
where
--company in ('401','490') and 
convert(date,[Date]) between DATEADD(MONTH,-3,CONVERT(DATE, dateadd(MONTH,datediff(MONTH,0,GETDATE()),0))) AND dateadd(day,-1,CONVERT(DATE, dateadd(MONTH,datediff(MONTH,0,GETDATE()),0))) and dpst in ('70238','70239','70240')

--group by itemcode,company
group by itemcode)a 
where ltrim(rtrim(Bin_Effective_Check.Item))=ltrim(rtrim(a.ItemCode))  and Bin_Effective_Check.Region='Gulf'
--and Bin_Effective_Check.Company=a.company

update Bin_Effective_Check set Avg_SalesQty_3M =round(SalesQty_3M/3,2)

update Bin_Effective_Check set Avg_SalesQty_6M=round(a.SalesQty_6M/6,2) from 
(select distinct itemcode,sum(AssesValue) 'SalesValue_6M',sum(DeliveredQty) 'SalesQty_6M'
from sales_report_ln 
where 
--company in ('401','490') and 
convert(date,[Date]) between DATEADD(MONTH,-6,CONVERT(DATE, dateadd(MONTH,datediff(MONTH,0,GETDATE()),0))) AND dateadd(day,-1,CONVERT(DATE, dateadd(MONTH,datediff(MONTH,0,GETDATE()),0))) and dpst in ('70238','70239','70240')

--group by itemcode,company
group by itemcode)a 
where ltrim(rtrim(Bin_Effective_Check.Item))=ltrim(rtrim(a.ItemCode))  and Bin_Effective_Check.Region='Gulf'
--and Bin_Effective_Check.Company=a.company

update Bin_Effective_Check set Avg_SalesQty_12M=round(a.SalesQty_12M/6,2) from 
(select distinct itemcode,sum(AssesValue) 'SalesValue_12M',sum(DeliveredQty) 'SalesQty_12M'
from sales_report_ln 
where 
--company in ('401','490') and 
convert(date,[Date]) between DATEADD(MONTH,-12,CONVERT(DATE, dateadd(MONTH,datediff(MONTH,0,GETDATE()),0))) AND dateadd(day,-1,CONVERT(DATE, dateadd(MONTH,datediff(MONTH,0,GETDATE()),0))) and dpst in ('70238','70239','70240')
--group by itemcode,company
group by itemcode)a 
where ltrim(rtrim(Bin_Effective_Check.Item))=ltrim(rtrim(a.ItemCode))  and Bin_Effective_Check.Region='Gulf'
--and Bin_Effective_Check.Company=a.company

update Bin_Effective_Check set Avg_Monthly_SalesQty=round(a.SalesQty/1,2) from 
(select distinct itemcode,sum(AssesValue) 'SalesValue',sum(DeliveredQty) 'SalesQty'
from sales_report_ln 
where 
--company in ('401','490') and 
convert(date,[Date]) >=  DATEADD(MONTH, -1, CAST(GETDATE() AS DATE)) and dpst in ('70238','70239','70240')
--group by itemcode,company
group by itemcode)a 
where ltrim(rtrim(Bin_Effective_Check.Item))=ltrim(rtrim(a.ItemCode))  and Bin_Effective_Check.Region='Gulf'
--and Bin_Effective_Check.Company=a.company


------------------------Step 6 Updating turnover qty--------------------------------------

update Bin_Effective_Check set TurnoverQty=case when StockQty=0 then 0 else isnull(round(salesQty_3M/StockQty,2),0) end

----------------------- Step 7 No of invoice per month ------------------------------

update Bin_Effective_Check set Noofinv=a.[No of Invoice per month] from 
(select ltrim(rtrim(item)) 'ItemCode',count(Invoice) 'No of Invoice per month'  from  ELGi_Sales_Details 
where company='500' and warehouse in ('G64','G84') and  OrderDate between convert(date,DATEADD(m,-1,getdate())) and convert(date,GETDATE())
group by company,Item)a
where ltrim(rtrim(Bin_Effective_Check.Item))=ltrim(rtrim(a.ItemCode))  and Bin_Effective_Check.Region='Gulf'

------------------------- Step 8 Min & max order qty-------------------------------------
update Bin_Effective_Check set Min_ord_qty=a.Min_ord_qty,max_ord_qty=a.Max_ord_qty from 
(
select ltrim(rtrim(ItemCode)) 'ItemCode',min(qty) 'Min_ord_qty',max(qty) 'Max_ord_qty' from Sales_Inflow
where company='500' and warehouse in ('G64','G84') and  OrderDate between convert(date,DATEADD(m,-1,getdate())) and convert(date,GETDATE())
group by company,ItemCode
)a
where ltrim(rtrim(Bin_Effective_Check.Item))=ltrim(rtrim(a.ItemCode)) and Bin_Effective_Check.Region='Gulf'

---------------------------Step 9  CV 2,ADI,RRS,TP,DC--------------------------------------------

--alter table Gulf_Sales_Qty_Temp add Sales_value float
--select * from Gulf_Sales_Qty_Temp

Truncate table Gulf_Sales_Qty_Temp

insert into Gulf_Sales_Qty_Temp 
select distinct itemcode,month(Date) 'Cal_Month',year(Date) 'Cal_Year',sum(DeliveredQty) 'DeliveredQty',[Date] 'Inv_date',sum(AssesValue) 'Sales_value'
from sales_report_ln 
where 
--company in ('401','490') and 
convert(date,[Date]) BETWEEN  DATEADD(MONTH,-24,CONVERT(DATE, dateadd(MONTH,datediff(MONTH,0,GETDATE()),0))) AND dateadd(day,-1,CONVERT(DATE, dateadd(MONTH,datediff(MONTH,0,GETDATE()),0)))
and dpst in ('70238','70239','70240')
--group by itemcode,company
group by itemcode,[Date],month(Date),year(date)
ORDER BY Inv_date 


Truncate table bin_effective_check_Sales

insert into bin_effective_check_Sales (itemcode,firstsaledate,lastsaledate,SalesQty,SalesValue,TotalPeriods,SalesMonthsConsidered,MeanDemand,SalesMonthsConsideredMeanQty)
select itemcode,CONVERT(DATE,min(INV_DATE)) 'FirstSaleDate',CONVERT(DATE,max(INV_DATE)) 'LastSaleDate',sum(SALES_QTY) 'SalesQty',sum(SALES_VALUE) 'SalesValue',
count(distinct concat(CAL_MONTH,CAL_YEAR)) 'TotalPeriods', 24 'SalesMonthsConsidered', 
sum(SALES_QTY) /count(distinct concat(CAL_MONTH,CAL_YEAR))  'MeanDemand',
sum(SALES_QTY)/24 'SalesMonthsConsideredMeanQty'
from Gulf_Sales_Qty_Temp 

GROUP BY ITEMCODE


update bin_effective_check_Sales set [(x-xbar)sq]= (SalesQty-MeanDemand ) *(SalesQty-MeanDemand )


update bin_effective_check_Sales set StdDemand= a.StdDemand
from (Select Itemcode,TotalPeriods,sqrt(sum([(x-xbar)sq])/TotalPeriods) 'StdDemand'
from bin_effective_check_Sales
group by itemcode,TotalPeriods)a
where bin_effective_check_Sales.itemcode=a.itemcode and bin_effective_check_Sales.totalperiods=a.TotalPeriods


Update bin_effective_check_Sales set CV=(StdDemand/MeanDemand)*(StdDemand/MeanDemand)
where meandemand <>0 and meandemand is not null

Update bin_effective_check_Sales set DemandCount=DATEDIFF(mm,firstsaledate,lastsaledate)+1

Update bin_effective_check_Sales set ADI=DemandCount/TotalPeriods

update bin_effective_check_Sales set RRS = 'Runner' where ADI<=1.32 AND (CV)<=0.49

update bin_effective_check_Sales set RRS = 'Repeater' where (ADI>1.32 AND (CV)<=0.49) or (ADI<=1.32 AND (CV)>0.49)

update bin_effective_check_Sales set RRS = 'Stranger' where ADI>1.32 AND (CV)>0.49

--alter table bin_effective_check_Sales add Avg_24M float

update bin_effective_check_Sales set Avg_24M= SalesQty/24

update bin_effective_check_Sales set SeasonalityScore =  MeanDemand/Avg_24M where Avg_24M >0


--alter table bin_effective_check add SeasonalityScore float

update bin_effective_check set CV2=a.CV, ADI=a.ADI ,TotalPeriodsCount=a.TP,DemandPeriodsCount=a.DC,RRS=A.RRS,SEASONALITYsCORE=A.SS from (
select distinct itemcode,sum(cv) 'CV',SUM(ADI) 'ADI',sum(totalperiods)'TP', sum(demandcount) 'DC',RRS,sum(SeasonalityScore) 'SS' from bin_effective_check_Sales group by itemcode,RRS )a 
where Bin_Effective_Check.Item=a.itemcode  and Bin_Effective_Check.Region='Gulf'


end

GO

