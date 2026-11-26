
CREATE proc [dbo].[sp_PendingPOTracker] as

Truncate table PendingPOTracker

-------------STEP 1 inserting data from main table -------------

insert into PendingPOTracker(
Company,pdno,Item,ProdQty,DelvQty,RejnQty,
StartDt,OrderStatus,Deldt,Compdt,ClosedDt,WH)
select Company,pdno,trim(Mitm) 'Item',sum(convert(int,qrdr) )'PlannedQty',sum(qdlv) 'DelQty',sum(qrjc) 'RejQty',
PRDT 'StartDt',osta,RDLD 'DelDate',cmdt 'CompletionDate',cldt 'CloseDate',cwar

from TTISFC001ALL 

WHERE Company='401' --and osta not in ('8','9')

group by company,trim(mitm),pdno,PRDT,osta,RDLD,cmdt,cldt,cwar

--420420
---Inserting Closed production orders within this month to incorporate monthmax concept 
--insert into PendingPOTracker(
--Company,pdno,Item,ProdQty,DelvQty,RejnQty,
--StartDt,OrderStatus,Deldt,Compdt,ClosedDt,WH)

--select distinct company,pdno,trim(mitm)'Item',sum(convert(int,QNTL) )'PlannedQty',sum(convert(int,qdlv) )'DelQty',
--sum(convert(int,qrjc) )'RejQty',
--PRDT 'StartDt',osta,RDLD 'DelDate',cmdt 'CompletionDate',max(date) 'ClosedDate',cwar
--from  TTICST151ALL 
--where company=401  and osta in ('8','9') and  
--[date] between dateadd(d,1,EOMONTH(getdate()-1,-1)) and EOMONTH(getdate()-1)

--group by company,trim(mitm),pdno,PRDT,osta,RDLD,cmdt,cldt,cwar


--Updating Createdate
update PendingPOTracker set  CreateDate=a.CreatedDate from  (
select Company,pdno,trim(mitm) 'Item', min(date) 'CreatedDate' from TTICST151ALL
where COMPANY='401'
group by company,pdno,trim(mitm)
)a where PendingPOTracker.Company=a.COMPANY and PendingPOTracker.pdno=a.pdno and PendingPOTracker.Item=a.Item

--delete from PendingPOTracker where CreateDate is null or convert(date,CreateDate) <='20231231' 

-------------STEP 2 Update Department -------------

update PendingPOTracker set Department= 'RCD' where PDNO like '300%'

update PendingPOTracker set Department= 'RCD' where PDNO like '320%'

update PendingPOTracker set Department= 'RCD' where PDNO like '400%'

update PendingPOTracker set Department= 'Dryer' where pdno like '290%'

update  PendingPOTracker set Department='SEPSAC' where pdno like '200%'

update  PendingPOTracker set Department='SEPSAC' where pdno like '210%'

update PendingPOTracker set Department='Accessories' where pdno like '265%'

-------------STEP 3 Update OrderStatus -------------

update PendingPOTracker set OrderStatus='Planned' where OrderStatus='1'

update PendingPOTracker set OrderStatus='Scheduled' where OrderStatus='2'

update PendingPOTracker set OrderStatus='Printed' where OrderStatus='3'

update PendingPOTracker set OrderStatus='In Prod' where OrderStatus='4'

update PendingPOTracker set OrderStatus='Active' where OrderStatus='6'

update PendingPOTracker set OrderStatus='To be Completed' where OrderStatus='7'

update PendingPOTracker set OrderStatus='Completed' where OrderStatus='8'

update PendingPOTracker set OrderStatus='Closed' where OrderStatus='9'


delete from pendingpotracker where createdate is null

-------------STEP 4 Update ItemDesc -------------


update PendingPOTracker set ItemDesc=a.t_dsca from 
(select * from [TTCIBD001400]) a where trim(a.t_item)=trim(PendingPOTracker.item)

------------- STEP 5 Update FABNO -------------
UPDATE p
SET FabNo = a.FabNo
FROM PendingPOTracker p
INNER JOIN
(
    SELECT
        company,
        pdno,
        Item,
        STRING_AGG(CAST(MSER AS NVARCHAR(MAX)), ',') AS FabNo
    FROM
    (
        SELECT DISTINCT
            company,
            pdno,
            TRIM(mitm) AS Item,
            TRIM(MSER) AS MSER
        FROM dbo.TTIMFC010ALL
    ) x
    GROUP BY
        company,
        pdno,
        Item
) a
ON p.company = a.company
AND p.pdno = a.pdno
AND TRIM(p.item) = a.Item;

------------- STEP 6 Update Sale Order No, Clearance date,Create date -------------

update PendingPOTracker set SaleOrdNo=a.saleOrderNo,make=a.m,ClearDate=a.clearence_date,
CustReqDate=a.Cust_Date
from (

select * from UTN_VER1
)a where a.Production_Ord_no=PendingPOTracker.pdno and PendingPOTracker.item = trim(a.item)

update PendingPOTracker set reldt=a.date 
from (select distinct pdno,min(date)date,osta From TTICST151ALL where company=401 and osta=4 group by 
PDNO,OSTA)a where PendingPOTracker.pdno=a.pdno

------------- STEP 7 Update region -------------

--Alter table PendingPOTracker add Region_PlanningMaster nvarchar(100)

update PendingPOTracker set Region =a.region,region_SOPMaster=a.region_SOPMaster,
Region_PlanningMaster=a.Region_PlanningMaster
from ( select *,row_number() over (partition by warehouse order by warehouse) 'RN'   
from pendingpotracker_regionmapping) a 
where trim(PendingPOTracker.wh)=trim(a.warehouse) and a.RN=1


--case when wh='F57' THEN 'Africa'
--	 when WH='B57'then 'Brazil'
--	 when wh='E57' then 'Europe'
--     when wh='W57' THEN 'ID'
--	 when WH IN ('357','457')then 'India - Channel - Recip'
--	 when wh in ('257','G57') then 'India - Channel - SEPSAC'
--     when wh='T57' THEN 'India - Direct - Lube'
--	 when WH='L57'then 'India - Direct - OF'
--	 when wh='D57' then 'India - Portables - C&M'
--     when wh='M57' THEN 'India - Portables - WW'
--	 when WH='557'then 'India - Railways'
--	 when wh='U57' then 'India - Railways - Wiper'
--     when wh='L46' THEN 'India & alike'
--	 when WH='I57'then 'Indonesia'
--	 when wh='N57' then 'Malaysia'
--	 when wh in ('C57','H57') then 'OSEA'
--	 when wh='291' then 'R&D'
--	 when wh='O57' then 'Rotair'
--	 when wh='P57' then 'SA'
--	 when wh='157' then 'SAAME'
--	 when wh='A57' then 'USA'
--	 END

--)

------------- STEP 8 Update DFU,ITEMCATEGORY,PRODUCT GROUP -------------

UPDATE PendingPOTracker set DFU=a.demand_forecasting_unit_dfu , ItemCategory=Item_Category, ProductGroup=Product_group FROM (

Select * from elgi_sop.dbo.TPL_MASTER_REF) a 
where PendingPOTracker.region_SOPMaster =a.Region
and PendingPOTracker.Item=trim(a.Item)

UPDATE PendingPOTracker set DFU=a.DFUCode  FROM (

Select * from pendingpotracker_Master) a 
where replace(PendingPOTracker.region_PlanningMaster,' ','') =replace(a.Region2,' ','') and
 trim(PendingPOTracker.item)=trim(a.item) and PendingPOTracker.Department=a.department and PendingPOTracker.DFU is null
 
------------- STEP 9 Update MonthMax and SLA,Day Max From Master -------------

UPDATE PendingPOTracker set MonthMax=try_cast (a.MonthMax as float)
,SLA=try_cast (A.SLA as float),
Daymax= try_cast (A.DayMax as float) from 
(select * from pendingpotracker_Master ) a
where replace(PendingPOTracker.Region_PlanningMaster,' ','') =replace(a.Region2,' ','') and
trim(PendingPOTracker.Item)=trim(a.Item) and PendingPOTracker.Department=a.department

UPDATE PendingPOTracker set sla=0 where sla is null

UPDATE PendingPOTracker set MonthMax=0 where MonthMax is null

UPDATE PendingPOTracker set Daymax=0 where Daymax is null

------------- STEP 9 Update SLA DATE -------------

Update PendingPOTracker set  SLADate= a.SLAWorkingDate from   (SELECT
    P.pdno,item,createdate,sla,
    W2.WorkDate AS SLAWorkingDate
FROM PendingPOTracker P

OUTER APPLY
(
    SELECT TOP 1 W.WorkDayNo
FROM dbo.VW_CompanyWorkingCalendar W
WHERE W.WorkDate > CAST(P.CreateDate AS DATE)
ORDER BY W.WorkDate
) W1

LEFT JOIN dbo.VW_CompanyWorkingCalendar W2
    ON W2.WorkDayNo = W1.WorkDayNo + P.SLA - 1 )a  where PendingPOTracker.PDNO=a.PDNO and trim(PendingPOTracker.item)=a.Item

Update PendingPOTracker set  MaxSLA= ISNULL((CASE WHEN SLADate > CustReqDate THEN SLADate ELSE CustReqDate END), ISNULL(SLADate,CustReqDate))

------------- STEP 10 Update Final date considering  -------------
--********Not used in our logic ***********
--update PendingPOTracker set MonthCumUnits= a.cumqty from (
--select PDNo,item,createdate,format(Createdate,'MMM-yyyy') 'CreateDate_Format',prodqty,
--sum(prodqty) over (partition by item,format(Createdate,'MMM-yyyy') order by item, createdate asc
--rows between unbounded preceding and current row) 'CumQty' from PendingPOTracker

--) a where PendingPOTracker.PDNO=a.PDNO and PendingPOTracker.item=a.Item

--update PendingPOTracker set OverCapacityMonth= case when MonthCumUnits>MonthMax then 'Yes' else 'No' end 

--update PendingPOTracker set DayCumUnits= a.cumqty from (
--select PDNo,item,createdate,prodqty,
--sum(prodqty) over (partition by item,convert(date,createdate) order by item, createdate asc
--rows between unbounded preceding and current row) 'CumQty' from PendingPOTracker

--) a where PendingPOTracker.PDNO=a.PDNO and PendingPOTracker.item=a.Item

--update PendingPOTracker set OverCapacityDay= case when DayCumUnits>DayMax then 'Yes' else 'No' end 


---Hided before applying after logic
--update PendingPOTracker set Rn= a.rn from 
--(SELECT PDNo,Item,ProdQty,MaxSLA,
--ROW_NUMBER() OVER ( PARTITION BY Item ORDER BY MaxSLA, PDNo ) AS RN FROM PendingPOTracker
--) a where  PendingPOTracker.PDNO=a.PDNO and PendingPOTracker.item=a.Item

------------Updating rn------

;WITH CTE AS
(
SELECT PDNO,Item,ProdQty,MaxSLA,SUM(ProdQty) 
OVER(PARTITION BY Item ORDER BY MaxSLA, PDNO ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumQty
FROM PendingPOTracker
)
UPDATE P SET RN = C.CumQty FROM PendingPOTracker P INNER JOIN CTE C ON P.PDNO = C.PDNO AND P.Item = C.Item;

---Hided before applying after logic
--update PendingPOTracker set MonthNo = Case When MonthMax > 0 Then (Rn - 1) / MonthMax Else 0 End

update PendingPOTracker set MonthNo =case when MonthMax > 0 then floor((RN - 1) / MonthMax) else 0 end

update  PendingPOTracker set PositionInMonth = CASE WHEN MonthMax > 0THEN (Rn - 1) % convert(int,MonthMax)ELSE 0 END

--MonthAllocation is in which it can be allocated this is not date based on monthmax

update  PendingPOTracker set MonthAllocation =   DATEADD(MONTH,MonthNo,DATEFROMPARTS(YEAR(MaxSLA),MONTH(MaxSLA),1))

update   PendingPOTracker set MonthAllocation = case when MaxSLA> MonthAllocation then MaxSLA else monthallocation end

Update PendingPOTracker
set FinalAllocation =
dbo.UFN_working_wkdays
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

update P set FinalAllocation = W.WorkDate FROM PendingPOTracker P
CROSS APPLY
(
select top 1 WorkDate from VW_CompanyWorkingCalendar where WorkDate >= P.FinalAllocation order by WorkDate
) W

------------- STEP 11 Update Ageing,duetype, ageingbucket  -------------

--alter table PendingPOTracker add DuetypeOrder int
Update PendingPOTracker set ageing= datediff(d,convert(date,finalallocation), convert(date,getdate()))

update PendingPOTracker set Duetype = 'Withindue' where ageing<0

update PendingPOTracker set Duetype = 'Likely overdue (Incl. 0 days)' where ageing between -7 and 0

update PendingPOTracker set Duetype = 'Overdue' where ageing >=1

update PendingPOTracker set DuetypeOrder = 1 where ageing<0

update PendingPOTracker set DuetypeOrder = 2 where ageing between -7 and 0

update PendingPOTracker set DuetypeOrder = 3 where ageing >=1

-------------Overdue logic
--Update PendingPOTracker set Ageingbucket = 'Within due' where ageing < -7

Update PendingPOTracker set Ageingbucket = '0 days' where ageing =0

Update PendingPOTracker set Ageingbucket = '1-7 days' where ageing between 1 and 7

Update PendingPOTracker set Ageingbucket = '8-14 days' where ageing between 8 and 14

Update PendingPOTracker set Ageingbucket = '15-21 days' where ageing between 15 and 21

Update PendingPOTracker set Ageingbucket = '22-28 days' where ageing between 22 and 28

Update PendingPOTracker set Ageingbucket = '29-35 days' where ageing between 29 and 35

Update PendingPOTracker set Ageingbucket = '36-42 days' where ageing between 36 and 42

Update PendingPOTracker set Ageingbucket = '43-49 days' where ageing between 43 and 49

Update PendingPOTracker set Ageingbucket = '50-90 days' where ageing between 50 and 90

Update PendingPOTracker set Ageingbucket = '91-120 days' where ageing between 91 and 120

Update PendingPOTracker set Ageingbucket = '121-180 days' where ageing between 121 and 180

Update PendingPOTracker set Ageingbucket = '>180 days' where ageing between 181 and 365

Update PendingPOTracker set Ageingbucket = '>1 Year' where ageing >= 366

-------------Within due logic

Update PendingPOTracker set Ageingbucket = '1-7 days' where ageing between -7 and -1

Update PendingPOTracker set Ageingbucket = '8-14 days' where ageing between -14 and -8

Update PendingPOTracker set Ageingbucket = '15-21 days' where ageing between -21 and -15

Update PendingPOTracker set Ageingbucket = '22-28 days' where ageing between -28 and -22

Update PendingPOTracker set Ageingbucket = '29-35 days' where ageing between -35 and -29 

Update PendingPOTracker set Ageingbucket = '36-42 days' where ageing between -42 and -36

Update PendingPOTracker set Ageingbucket = '43-49 days' where ageing between -49 and -43

Update PendingPOTracker set Ageingbucket = '50-90 days' where ageing between -90 and -50

Update PendingPOTracker set Ageingbucket = '91-120 days' where ageing between -120 and -91

Update PendingPOTracker set Ageingbucket = '121-180 days' where ageing between -180 and -121

Update PendingPOTracker set Ageingbucket = '>180 days' where ageing between -365 and -181

Update PendingPOTracker set Ageingbucket = '>1 Year' where ageing  < -366


Update PendingPOTracker set AgeingbucketOrder = 1 where Ageingbucket='0 days'

Update PendingPOTracker set AgeingbucketOrder = 2 where Ageingbucket = '1-7 days'

Update PendingPOTracker set AgeingbucketOrder = 3 where Ageingbucket = '8-14 days'

Update PendingPOTracker set AgeingbucketOrder = 4 where Ageingbucket = '15-21 days'

Update PendingPOTracker set AgeingbucketOrder = 5 where Ageingbucket = '22-28 days'

Update PendingPOTracker set AgeingbucketOrder = 6 where Ageingbucket = '29-35 days'

Update PendingPOTracker set AgeingbucketOrder = 7 where Ageingbucket = '36-42 days'

Update PendingPOTracker set AgeingbucketOrder = 8 where Ageingbucket = '43-49 days'

Update PendingPOTracker set AgeingbucketOrder = 9 where Ageingbucket = '50-90 days'

Update PendingPOTracker set AgeingbucketOrder = 10 where Ageingbucket = '91-120 days' 

Update PendingPOTracker set AgeingbucketOrder = 11 where Ageingbucket = '121-180 days' 

Update PendingPOTracker set AgeingbucketOrder = 12 where Ageingbucket = '>180 days' 

Update PendingPOTracker set AgeingbucketOrder = 13 where Ageingbucket = '>1 Year'


--ALTER TABLE PendingPOTracker add OrderType nvarchar(100)

update PendingPOTracker set OrderType= 'Strategic Order' where convert(date,deldt) not in
(select WorkDate from  dbo.VW_CompanyWorkingCalendar )

update PendingPOTracker set OrderType= 'Customer Order' where convert(date,deldt) in
(select WorkDate from  dbo.VW_CompanyWorkingCalendar )


--VALIDATION NON WORKING DAY is ignored
--select  * FROM PendingPOTracker P
--LEFT JOIN VW_CompanyWorkingCalendar W
--ON P.FinalAllocation = W.WorkDate
--WHERE W.WorkDate IS NULL

--------month max vaildation 

GO

