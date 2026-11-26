CREATE proc [dbo].[sp_OTD_report_India] as 


--------------------------------------PART 1 OTD_REPORT (INDIA TO USA/EU) ----------------------------------------------

truncate table OTD_Report_India

insert into OTD_Report_India (
[LastUpdated],[company],[trantype],[invnum],[orderdate],[ordernum],[positionnum],[areacode],[areaname],[dpst]
,[dpstname],[custcode],[custname],[itemcode],[item_desc],[OrderedQty],[Region2],[Key],[GSC/HO],[ValueMN],[Demand_Forecasting_Unit_DFU],[Itemcategory_SOP]
,[ProductGroup_SOP],[Variant],[KW],[RRS],[Max_Leadtime],[Target_date],[Cust_date1],[Max_Targetdate],[RRSSorting]
)

select getdate() 'LastUpdated'--,Convert(date,a.Date)'Date_Final'
,a.company,a.trantype,invnum,orderdate,ordernum,positionnum,areacode,areaname,dpst,dpstname,custcode,custname
,itemcode,item_desc,qty 'OrderedQty',--DATEDIFF(day,a.OrderDate,
--convert(date,a.Date)) 'Actual_days',

case when areaname IN ('ITALY','BELGIUM') Then 'Europe' 
When areaname IN ('U.S.A') Then 'USA'  
Else areaname End Region2,

CONCAT(case when areaname IN ('ITALY','BELGIUM') Then 'Europe' 
When areaname IN ('U.S.A') Then 'USA'  
Else areaname End,e.Demand_Forecasting_Unit_DFU)'Key',

case when dpst in ('90015','90026','90029', '90034','90038','90079','90085') or concat(company,'-',dpst) in ('450-90084') then 'HO'
	when dpst in ('90013','90028','90031','90063','90075','90082','90083','90084')  or concat(company,'-',dpst) in ('490-90084') then 'GSC'
	else 'Others'
	end 'GSC/HO',round(sales,2)/1000000 'ValueMN',
	e.Demand_Forecasting_Unit_DFU,e.Item_Category 'Itemcategory_SOP',e.Product_group 'ProductGroup_SOP',e.Variant,e.KW,f.RRS,g.Max_Leadtime,
	DATEADD(Day,g.Max_Leadtime,a.OrderDate)'Target_date',h.Cust_date1,

CASE 
    WHEN DATEADD(DAY, g.Max_Leadtime, a.OrderDate) IS NULL 
         AND h.Cust_date1 IS NULL 
        THEN NULL

    WHEN DATEADD(DAY, g.Max_Leadtime, a.OrderDate) IS NULL 
        THEN h.Cust_date1

    WHEN h.Cust_date1 IS NULL 
        THEN DATEADD(DAY, g.Max_Leadtime, a.OrderDate)

    WHEN DATEADD(DAY, g.Max_Leadtime, a.OrderDate) > h.Cust_date1 
        THEN DATEADD(DAY, g.Max_Leadtime, a.OrderDate)

    ELSE h.Cust_date1
END AS Max_Targetdate,
case when rrs='Runner' then 1
when rrs='repeater' then 2
when rrs='Stranger' then 3 
else 4 
end 'RRSSorting'

From sales_inflow a

--------FROM MASTER UPDATING REQ DATA-----------

left join (Select Distinct Item,Demand_Forecasting_Unit_DFU,Region,Item_Category,Product_group,KW,Variant
from [ELGi_SOP].[dbo].[TPL_MASTER_REF]) e on 
LTRIM(RTRIM(a.ItemCode))=LTRIM(RTRIM(e.Item)) and (
case when a.areaname IN ('ITALY','BELGIUM') Then 'Europe' 
When a.areaname IN ('U.S.A') Then 'USA'  
Else a.areaname End) = e.Region

--------FOR RRS UPDATION -----------

left JOIN (
Select Distinct DFUCode,Organ,RRS_Classification 'RRS' from ELGI_SOP.dbo.SalesQtyForecast_Monthwise_Analysis
) f on e.Demand_Forecasting_Unit_DFU = f.DFUCode and e.Region = f.Organ

--------FOR LEAD TIME UPDATION--------

left JOIN (Select Distinct Region,DFU,Max(TotalLeadTime)'Max_Leadtime' from ELGi_SOP.[dbo].SLAMasterUSAEU_OTDReportIndia
Group By Region,DFU)g on trim(e.Demand_Forecasting_Unit_DFU) = trim(g.DFU) and e.Region = g.Region

--------FOR CUST REQ DATE --------

left JOIN (
Select Distinct SaleOrderno,Item, convert(date,Max(cust_date))'Cust_date1' from [utn_ver1]
Group BY SaleOrderno,Item
)h on a.OrderNum = h.SaleOrderno and LTRIM(RTRIM(a.ItemCode)) = LTRIM(RTRIM(h.Item))

where company = '401'
AND areacode in ('651','644','626')

--------
--ALTER TABLE OTD_Report_India ADD India_TPL nvarchar(100)

update OTD_Report_India set India_TPL =a.India_TPL from  (
select region,trim(Item) 'Item',Item_Description,Item_Category,Demand_Forecasting_Unit_DFU,India_TPL,Model,HP,KW,Pressure_bar,pressure_psi,
Variant,Frame,Product_group,GSC_class,RRS_classification,Supplier,NewDFU,Phase,Voltage,MountType,CoolingType
from (
select  *,row_number() over(partition by region,trim(item) order by region,trim(item)) 'Rn' from ELGI_SOP.DBO.TPL_MASTER_REF
where region is not null
) a
where rn=1
) a where otd_report_india.Region2=a.Region and 
otd_report_india.Demand_Forecasting_Unit_DFU=a.Demand_Forecasting_Unit_DFU


--alter table OTD_Report_India add DeliveredQty float

update OTD_Report_India set invoiceDate=a.invdate,
DeliveredQty=a.DeliveredQty
from (select max(convert(date,date)) 'InvDate', ordernum,trim(ItemCode) 'Itemcode'
,AreaCode,Company,Positionno,invoice,trantype,
sum(deliveredqty) 'DeliveredQty'

from sales_report_LN
where company='401' AND areacode in ('651','644','626')
group by ordernum,ItemCode,AreaCode,
Company,Positionno,invoice,trantype,convert(date,date)

) a where OTD_Report_India.Company=a.company --and OTD_report_India.invnum=a.invoice 
and trim(OTD_report_India.ItemCode)=trim(a.itemcode) and OTD_report_India.PositionNum=a.positionno
and trim(OTD_Report_India.ordernum)=trim(a.OrderNum)


--alter table OTD_Report_India add SLADate date
-----------------Updating MonthMax,Daymax,SLA (Connecting india_tpl to item in the pending po tracker)

UPDATE OTD_Report_India set MonthMax=try_cast (a.MonthMax as float),
--,SLA=try_cast (A.SLA as float),
Daymax= try_cast (A.DayMax as float) from 
(select * from pendingpotracker_Master ) a
where replace(OTD_Report_India.Region2,' ','') =replace(a.Region2,' ','') and
trim(OTD_Report_India.india_tpl)=trim(a.Item)-- and PendingPOTracker.Department=a.department FROM INDIA_TPL I HAVE TO TAKE 

UPDATE OTD_Report_India set sla=[Max_Leadtime]-- where sla is null

---During the conversation this have beedn added temprorarily

UPDATE OTD_Report_India set MonthMax=1 where MonthMax is null

UPDATE OTD_Report_India set Daymax=1 where Daymax is null

Update OTD_Report_India set  SLADate= a.SLAWorkingDate from   (SELECT
   p.ordernum,p.orderdate,p.itemcode,sla,
    W2.WorkDate AS SLAWorkingDate
FROM OTD_Report_India P

OUTER APPLY
(
    SELECT TOP 1 W.WorkDayNo
FROM dbo.VW_CompanyWorkingCalendar W
WHERE W.WorkDate > CAST(P.orderdate AS DATE)
ORDER BY W.WorkDate
) W1

LEFT JOIN dbo.VW_CompanyWorkingCalendar W2
    ON W2.WorkDayNo = W1.WorkDayNo + P.SLA - 1 )a  where OTD_Report_India.ordernum=a.ordernum
	and trim(OTD_Report_India.itemcode)=a.itemcode

--Alter table OTD_Report_India add FinalAllocation date

Update OTD_Report_India set  MaxSLA= ISNULL((CASE WHEN SLADate > cust_date1 THEN SLADate ELSE cust_date1 END), 
ISNULL(SLADate,cust_date1))

update OTD_Report_India set  Max_Targetdate=MaxSLA


;WITH CTE AS
(
SELECT ordernum,itemcode,orderedQty,MaxSLA,SUM(orderedQty) 
OVER(PARTITION BY itemcode ORDER BY MaxSLA, ordernum ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumQty
FROM OTD_Report_India
where orderdate >='20251001' and Itemcategory_SOP in ('Units','Accessories')
)
UPDATE P SET RN = C.CumQty FROM OTD_Report_India P INNER JOIN CTE C ON P.ordernum = C.ordernum AND P.itemcode = C.itemcode


update OTD_Report_India set MonthNo =case when MonthMax > 0 then floor((RN - 1) / MonthMax) else 0 end

update  OTD_Report_India set PositionInMonth = CASE WHEN MonthMax > 0THEN (Rn - 1) % convert(int,MonthMax)ELSE 0 END

update  OTD_Report_India set MonthAllocation =   DATEADD(MONTH,MonthNo,DATEFROMPARTS(YEAR(MaxSLA),MONTH(MaxSLA),1))

update   OTD_Report_India set MonthAllocation = case when MaxSLA> MonthAllocation then MaxSLA else monthallocation end

Update OTD_Report_India set FinalAllocation = dbo.UFN_working_wkdays
(
    MonthAllocation,
    FLOOR(
        CAST(PositionInMonth AS FLOAT)
        / NULLIF(DayMax,0)
    )
)

update OTD_Report_India set FinalAllocation=Max_Targetdate where Itemcategory_SOP like '%Aftermarket%'

--Update PendingPOTracker set FinalAllocation=  dbo.UFN_working_wkdays( MonthAllocation,
--CEILING(CAST(PositionInMonth + ProdQty AS DECIMAL(18,2))/ NULLIF(DayMax, 0)) - 1)

--To ensure working day is only captured

update P set FinalAllocation = W.WorkDate FROM OTD_Report_India P
CROSS APPLY
(
select top 1 WorkDate from VW_CompanyWorkingCalendar where WorkDate >= P.FinalAllocation order by WorkDate
) W
--select company,trantype,invnum,orderdate,ordernum,positionnum,areacode,areaname,dpst,dpstname,custcode,custname
--,itemcode,item_desc,qty 'OrderedQty'
--from sales_inflow 
--where company = '401'
--AND areacode in ('651','644','626')

-------------------------------------- END OF PART 1 ------------------------------------------------------------------

-------------------------------------- PART 2 OTIF_REPORT (Only for SEPSAC -90016,90020 wihtin india) ------------------

truncate table OTIF_India

insert into OTIF_India ([LastUpdated]
,[Company],[DPST],[DpstName],[AreaCode],[AreaName],[Organ],[Vertical1],[Zone],[OrderDate],[OrderNum]
,[ItemCode],[Item_desc],[ordertype],[CustCode],[CustName],[qty],[sales],[Currency],[Sales_USD],[Rate_USD],[DeliveryTerms]
,[DelvDesc],[CarrierCode],[CarrierDesc],[Type],[Item_Category],[PositionNum],[Demand_Forecasting_Unit_DFU],[rrs]
,[Invoice_date],[Cust_Req_Date]
,[CustReqDate_Final],[OrderType2],[IC_Master],[InvoiceDate_Final],[RRSSorting],[Product_Group],[India_TPL])
  

Select getdate() 'LastUpdated',a.Company,a.DPST,a.DpstName,a.AreaCode,a.AreaName,a.Organ,a.Vertical1,a.Zone,a.OrderDate
,a.OrderNum,a.ItemCode,a.Item_desc,a.ordertype,a.CustCode,a.CustName,a.qty,a.sales,a.Currency,a.Sales_USD,a.Rate_USD
,a.DeliveryTerms,a.DelvDesc,a.CarrierCode,a.CarrierDesc,a.Type,a.Item_Category,a.PositionNum
,b.Demand_Forecasting_Unit_DFU,c.rrs,Convert(date,d.Date)'Invoice_date',Convert(date,e.DDAT)'Cust_Req_Date', CASE
    WHEN COUNT(*) OVER (PARTITION BY a.OrderNum) > 1
         AND SUM(CASE WHEN b.Item_Category = 'Units' THEN 1 ELSE 0 END)
             OVER (PARTITION BY a.OrderNum) > 0
         AND SUM(CASE WHEN b.Item_Category = 'Accessories' THEN 1 ELSE 0 END)
             OVER (PARTITION BY a.OrderNum) > 0
    THEN MAX(Convert(date,e.DDAT)) OVER (PARTITION BY a.OrderNum)

    ELSE Convert(date,e.DDAT)
END AS CustReqDate_Final,
CASE
    WHEN COUNT(*) OVER (PARTITION BY a.OrderNum) > 1
         AND SUM(CASE WHEN b.Item_Category = 'Units' THEN 1 ELSE 0 END)
             OVER (PARTITION BY a.OrderNum) > 0
         AND SUM(CASE WHEN b.Item_Category = 'Accessories' THEN 1 ELSE 0 END)
             OVER (PARTITION BY a.OrderNum) > 0
    THEN 'PackageOrder' 
	when b.Item_Category='Units' then 'Units'
	when b.Item_Category in ('Accessories','Aftermarket') then 'Accessories' end 'OrderType2',b.Item_Category 'IC_Master',
 CASE
    WHEN COUNT(*) OVER (PARTITION BY a.OrderNum) > 1
         AND SUM(CASE WHEN b.Item_Category = 'Units' THEN 1 ELSE 0 END)
             OVER (PARTITION BY a.OrderNum) > 0
         AND SUM(CASE WHEN b.Item_Category = 'Accessories' THEN 1 ELSE 0 END)
             OVER (PARTITION BY a.OrderNum) > 0
    THEN MAX(Convert(date,d.Date)) OVER (PARTITION BY a.OrderNum)

    ELSE Convert(date,d.Date)
END AS InvoiceDate_Final,
case when rrs='Runner' then 1
when rrs='Repeater' then 2
when RRS='Stranger' then 3
else 4 end 'RRSSorting',b.Product_group 'Product_Group',b.India_TPL


from sales_inflow a

------------------------- SOP MASTER ------------------

LEFT JOIN (
select region ,trim(Item) 'item',Item_Description,Item_Category,Demand_Forecasting_Unit_DFU,India_TPL,Model,HP,KW,Pressure_bar,pressure_psi,
Variant,Frame,Product_group,GSC_class,RRS_classification,Supplier,NewDFU,Phase,Voltage,MountType,CoolingType
from (
select  *,row_number() over(partition by region,trim(item) order by region,trim(item)) 'Rn' from elgi_sop.dbo.TPL_MASTER_REF
where region is not null
) a
where rn=1
 ) b 
on trim(a.ItemCode) = trim(b.Item) and trim(a.Organ) = trim(b.Region)

------------------------ RRS UPDATION --------------
left JOIN (
Select Distinct DFUCode 'dfu',Organ,RRS_Classification 'rrs'--,DPSTCode 'dpst' 
from ELGI_SOP.dbo.SalesQtyForecast_Monthwise_Analysis

) c on b.Demand_Forecasting_Unit_DFU = c.dfu and b.Region = c.Organ --and a.Dpst = c.dpst

------------------------ INVOICE DETAILS ------------------

LEFT JOIN sales_report_LN d on a.OrderNum = d.OrderNum and trim(a.ItemCode) = trim(d.ItemCode) and a.PositionNum = d.positionno
and a.invnum=d.Invoice

-------------- 

LEFT JOIN TZZSFC254ALL e on a.OrderNum = e.ORNO and a.ItemCode = LTRIM(RTRIM(e.ITEM)) and a.PositionNum = e.pono

Where a.Dpst IN ('90016','90020') and a.qty >= 1 --and a.Company='401'

---136445

update OTIF_India
set Invoice_date=a.invdate
--=a.DeliveredQty
from (select max(convert(date,date)) 'InvDate', ordernum,trim(ItemCode) 'Itemcode'
,AreaCode,Company,Positionno,invoice,trantype,
sum(deliveredqty) 'DeliveredQty'

from sales_report_LN
where  Dpst IN ('90016','90020') and DeliveredQty >= 1
group by ordernum,ItemCode,AreaCode,
Company,Positionno,invoice,trantype,convert(date,date)

) a where OTIF_India.Company=a.company --and OTD_report_India.invnum=a.invoice 
and trim(OTIF_India.ItemCode)=trim(a.itemcode) and OTIF_India.PositionNum=a.positionno
and trim(OTIF_India.ordernum)=trim(a.OrderNum)

;WITH CTE AS
(
    SELECT *,
        COUNT(*) OVER (PARTITION BY OrderNum) AS OrderCount,

        SUM(CASE WHEN IC_Master = 'Units' THEN 1 ELSE 0 END)
            OVER (PARTITION BY OrderNum) AS UnitsCount,

        SUM(CASE WHEN IC_Master = 'Accessories' THEN 1 ELSE 0 END)
            OVER (PARTITION BY OrderNum) AS AccessoriesCount,

        MAX(CONVERT(date, Invoice_date))
            OVER (PARTITION BY OrderNum) AS MaxInvoiceDate
    FROM OTIF_India
)

UPDATE CTE
SET InvoiceDate_Final =
    CASE
        WHEN OrderCount > 1
             AND UnitsCount > 0
             AND AccessoriesCount > 0
        THEN MaxInvoiceDate
        ELSE CONVERT(date, Invoice_date)
    END;

--alter table OTIF_India add SLADate date

----------------- Updating MonthMax,Daymax,SLA (Connecting india_tpl to item in the pending po tracker)

UPDATE OTIF_India set MonthMax=try_cast (a.MonthMax as float),
--,SLA=try_cast (A.SLA as float),
Daymax= try_cast (A.DayMax as float) from 
(select * from pendingpotracker_Master ) a
where replace(OTIF_India.Organ,' ','') =( case when replace(a.Region2,' ','') like '%India%' then 'India' else null end ) and
trim(OTIF_India.India_TPL)=trim(a.Item)-- and PendingPOTracker.Department=a.department FROM INDIA_TPL I HAVE TO TAKE 

--UPDATE OTIF_India set sla=0 where sla is null

UPDATE OTIF_India set MonthMax=0 where MonthMax is null

UPDATE OTIF_India set Daymax=0 where Daymax is null

UPDATE OTIF_India  SET SLA=a.malt from (SELECT * FROM ELGI_SOP.[dbo].[IndiaMALTMaster_OTIFReport])a 
where OTIF_India.Organ=a.region and trim(OTIF_India.India_TPL)=trim(a.TPLCode)

Update OTIF_India set  SLADate= a.SLAWorkingDate from   (SELECT
   p.ordernum,p.orderdate,p.itemcode,sla,
    W2.WorkDate AS SLAWorkingDate
FROM OTIF_India P

OUTER APPLY
(
    SELECT TOP 1 W.WorkDayNo
FROM dbo.VW_CompanyWorkingCalendar W
WHERE W.WorkDate > CAST(P.orderdate AS DATE)
ORDER BY W.WorkDate
) W1

LEFT JOIN dbo.VW_CompanyWorkingCalendar W2
    ON W2.WorkDayNo = W1.WorkDayNo + P.SLA - 1 )a  where OTIF_India.ordernum=a.ordernum
	and trim(OTIF_India.itemcode)=a.itemcode

--Alter table OTIF_India add MaxSLA date

Update OTIF_India set  MaxSLA= ISNULL((CASE WHEN SLADate > CustReqDate_Final THEN SLADate ELSE CustReqDate_Final END), 
ISNULL(SLADate,CustReqDate_Final))


;WITH CTE AS
(
SELECT ordernum,itemcode,qty,MaxSLA,SUM(qty) 
OVER(PARTITION BY itemcode ORDER BY MaxSLA, ordernum ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumQty
FROM OTIF_India
where orderdate >='20260701' --and Item_Category in ('Units','Accessories')
)
UPDATE P SET RN = C.CumQty FROM OTIF_India P INNER JOIN CTE C ON P.ordernum = C.ordernum AND P.itemcode = C.itemcode

--Alter table OTIF_India add RN int


update OTIF_India set MonthNo =case when MonthMax > 0 then floor((RN - 1) / MonthMax) else 0 end

update  OTIF_India set PositionInMonth = CASE WHEN MonthMax > 0THEN (Rn - 1) % convert(int,MonthMax)ELSE 0 END

update  OTIF_India set MonthAllocation =   DATEADD(MONTH,MonthNo,DATEFROMPARTS(YEAR(MaxSLA),MONTH(MaxSLA),1))

update   OTIF_India set MonthAllocation = case when MaxSLA> MonthAllocation then MaxSLA else monthallocation end

Update OTIF_India set FinalAllocation = dbo.UFN_working_wkdays
(
    MonthAllocation,
    FLOOR(
        CAST(PositionInMonth AS FLOAT)
        / NULLIF(DayMax,0)
    )
)

--Update PendingPOTracker set FinalAllocation=  dbo.UFN_working_wkdays( MonthAllocation,
--CEILING(CAST(PositionInMonth + ProdQty AS DECIMAL(18,2))/ NULLIF(DayMax, 0)) - 1)

--To ensure working day is only captured

--update OTIF_India set FinalAllocation=MaxSLA where Item_Category like '%Aftermarket%'


update P set FinalAllocation = W.WorkDate FROM OTIF_India P
CROSS APPLY
(
select top 1 WorkDate from VW_CompanyWorkingCalendar where WorkDate >= P.FinalAllocation order by WorkDate
) W
--select company,trantype,invnum,orderdate,ordernum,positionnum,areacode,areaname,dpst,dpstname,custcode,custname
--,itemcode,item_desc,qty 'OrderedQty'
--from sales_inflow 
--where company = '401'
--AND areacode in ('651','644','626')


--select * from sales_report_LN where ordernum='290031570' and itemcode='s016533'

GO

