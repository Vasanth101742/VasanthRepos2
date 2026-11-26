
CREATE proc [dbo].[sp_PendingPOTrackerTest] as

declare @currentdate date= convert(date,getdate()-1)

declare @ClosedDateStarting date = datefromparts(year(@currentdate), ((MONTH(@CurrentDate) - 1) / 3) * 3 + 1,1)

--select @ClosedDateStarting

Truncate table PendingPOTracker_test

-------------STEP 1 inserting data from main table -------------

insert into PendingPOTracker_test(
Company,pdno,Item,ProdQty,DelvQty,RejnQty,
StartDt,OrderStatus,Deldt,Compdt,ClosedDt,WH)
select Company,pdno,trim(Mitm) 'Item',sum(convert(int,qrdr) )'PlannedQty',sum(qdlv) 'DelQty',sum(qrjc) 'RejQty',
PRDT 'StartDt',osta,RDLD 'DelDate',cmdt 'CompletionDate',cldt 'CloseDate',cwar

from TTISFC001ALL 

WHERE Company='401' and osta not in ('8','9')

group by company,trim(mitm),pdno,PRDT,osta,RDLD,cmdt,cldt,cwar

--420420
--Inserting Closed production orders from current month to incorporate monthmax concept 
insert into PendingPOTracker_test(
Company,pdno,Item,ProdQty,DelvQty,RejnQty,
StartDt,OrderStatus,Deldt,Compdt,ClosedDt,WH)

select distinct company,pdno,trim(mitm)'Item',sum(convert(int,qrdr) )'PlannedQty',sum(convert(int,qdlv) )'DelQty',
sum(convert(int,qrjc) )'RejQty',
max(PRDT) 'StartDt',max(osta) 'osta',max(RDLD) 'DelDate',max(cmdt) 'CompletionDate',max(date) 'ClosedDate',cwar
from  TTICST151ALL 
where company=401  and osta in ('8','9') and  
[date] >= @ClosedDateStarting

group by company,trim(mitm),pdno,cwar--,PRDT,osta,RDLD,cmdt,cldt,cwar

update PendingPOTracker_test set ProdQty=a.plannedqty, DelvQty=a.delqty , RejnQty=a.rejqty
from (
select Company,pdno,trim(Mitm) 'Item',sum(convert(int,qrdr) )'PlannedQty',sum(qdlv) 'DelQty',sum(qrjc) 'RejQty',
PRDT 'StartDt',osta,RDLD 'DelDate',cmdt 'CompletionDate',cldt 'CloseDate',cwar

from TTISFC001ALL 

WHERE Company='401' and osta in ('8','9')

group by company,trim(mitm),pdno,PRDT,osta,RDLD,cmdt,cldt,cwar) a
where PendingPOTracker_test.pdno=a.pdno and PendingPOTracker_test.item=a.item


--Updating Createdate
update PendingPOTracker_test set  CreateDate=a.CreatedDate from  (
select Company,pdno,trim(mitm) 'Item', min(date) 'CreatedDate' from TTICST151ALL
where COMPANY='401'
group by company,pdno,trim(mitm)
)a where PendingPOTracker_test.Company=a.COMPANY and PendingPOTracker_test.pdno=a.pdno 
and PendingPOTracker_test.Item=a.Item

--delete from PendingPOTracker_test where CreateDate is null or convert(date,CreateDate) <='20231231' 

-------------STEP 2 Update Department -------------

update PendingPOTracker_test set Department= 'RCD' where PDNO like '300%'

update PendingPOTracker_test set Department= 'RCD' where PDNO like '320%'

update PendingPOTracker_test set Department= 'RCD' where PDNO like '400%'

update PendingPOTracker_test set Department= 'Dryer' where pdno like '290%'

update  PendingPOTracker_test set Department='SEPSAC' where pdno like '200%'

update  PendingPOTracker_test set Department='SEPSAC' where pdno like '210%'

update PendingPOTracker_test set Department='Accessories' where pdno like '265%'

-------------STEP 3 Update OrderStatus -------------

update PendingPOTracker_test set OrderStatus='Planned' where OrderStatus='1'

update PendingPOTracker_test set OrderStatus='Scheduled' where OrderStatus='2'

update PendingPOTracker_test set OrderStatus='Printed' where OrderStatus='3'

update PendingPOTracker_test set OrderStatus='In Prod' where OrderStatus='4'

update PendingPOTracker_test set OrderStatus='Active' where OrderStatus='6'

update PendingPOTracker_test set OrderStatus='To be Completed' where OrderStatus='7'

update PendingPOTracker_test set OrderStatus='Completed' where OrderStatus='8'

update PendingPOTracker_test set OrderStatus='Closed' where OrderStatus='9'


--delete from PendingPOTracker_test where createdate is null

-------------STEP 4 Update ItemDesc -------------


update PendingPOTracker_test set ItemDesc=a.t_dsca from 
(select * from [TTCIBD001400]) a where trim(a.t_item)=trim(PendingPOTracker_test.item)

------------- STEP 5 Update FABNO -------------
UPDATE p
SET FabNo = a.FabNo
FROM PendingPOTracker_test p
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

------------- STEP 6 Update Sale Order No, Clearance date,Create date,UTN -------------

--ALTER TABLE PendingPOTracker_test ADD CustName nvarchar(255)

update PendingPOTracker_test set SaleOrdNo=a.saleOrderNo,make=a.m,
CustReqDate=a.Cust_Date,UTN=A.UTN,saleorderDate=a.Order_Date,positionnum=a.PONO,custcode=a.custcode, custname=a.CustName,orderqty=a.Ordqty
from (

select * from UTN_VER1
)a where a.Production_Ord_no=PendingPOTracker_test.pdno and PendingPOTracker_test.item = trim(a.item)


update PendingPOTracker_test set reldt=a.date 
from (select distinct pdno,min(date)date,osta From TTICST151ALL where company=401 and osta=4 group by 
PDNO,OSTA)a where PendingPOTracker_test.pdno=a.pdno


update PendingPOTracker_test set ClearDate=a.cldt from (
select * From  TZZSFC254ALL where company=401 and CLER=1) a where SaleOrdNo=a.ORNO



------------- STEP 7 Update region -------------

--Alter table PendingPOTracker_test add Region_PlanningMaster nvarchar(100)

update PendingPOTracker_test set Region =a.region,region_SOPMaster=a.region_SOPMaster,
Region_PlanningMaster=a.Region_PlanningMaster
from ( select *,row_number() over (partition by warehouse order by warehouse) 'RN'   
from PendingPOTracker_regionmapping) a 
where trim(PendingPOTracker_test.wh)=trim(a.warehouse) and a.RN=1


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

UPDATE PendingPOTracker_test set DFU=a.demand_forecasting_unit_dfu , ItemCategory=Item_Category, ProductGroup=Product_group FROM (

Select * from elgi_sop.dbo.TPL_MASTER_REF) a 
where PendingPOTracker_test.region_SOPMaster =a.Region
and PendingPOTracker_test.Item=trim(a.Item)

UPDATE PendingPOTracker_test set DFU=a.DFUCode  FROM (

Select * from PendingPOTracker_Master) a 
where replace(PendingPOTracker_test.region_PlanningMaster,' ','') =replace(a.Region2,' ','') and
 trim(PendingPOTracker_test.item)=trim(a.item) and PendingPOTracker_test.Department=a.department 
 and PendingPOTracker_test.DFU is null
 
------------- STEP 9 Update MonthMax and SLA,Day Max From Master -------------

UPDATE PendingPOTracker_test set MonthMax=try_cast (a.MonthMax as float)
,SLA=try_cast (A.SLA as float),
Daymax= try_cast (A.DayMax as float) from 
(select * from PendingPOTracker_Master ) a
where replace(PendingPOTracker_test.Region_PlanningMaster,' ','') =replace(a.Region2,' ','') and
trim(PendingPOTracker_test.Item)=trim(a.Item) and PendingPOTracker_test.Department=a.department

UPDATE PendingPOTracker_test set sla=0 where sla is null

UPDATE PendingPOTracker_test set MonthMax=0 where MonthMax is null

UPDATE PendingPOTracker_test set Daymax=0 where Daymax is null

------------- STEP 9 Update SLA DATE -------------

Update PendingPOTracker_test set  SLADate= a.SLAWorkingDate from   (SELECT
    P.pdno,item,createdate,sla,
    W2.WorkDate AS SLAWorkingDate
FROM PendingPOTracker_test P

OUTER APPLY
(
    SELECT TOP 1 W.WorkDayNo
FROM dbo.VW_CompanyWorkingCalendar W
WHERE W.WorkDate > CAST(P.CreateDate AS DATE)
ORDER BY W.WorkDate
) W1

LEFT JOIN dbo.VW_CompanyWorkingCalendar W2
    ON W2.WorkDayNo = W1.WorkDayNo + P.SLA - 1 )a  where PendingPOTracker_test.PDNO=a.PDNO and trim(PendingPOTracker_test.item)=a.Item

Update PendingPOTracker_test set  MaxSLA= ISNULL((CASE WHEN SLADate > CustReqDate THEN SLADate ELSE CustReqDate END), ISNULL(SLADate,CustReqDate))

------------- STEP 10 Update Final date considering  -------------
--********Not used in our logic ***********
--update PendingPOTracker_test set MonthCumUnits= a.cumqty from (
--select PDNo,item,createdate,format(Createdate,'MMM-yyyy') 'CreateDate_Format',prodqty,
--sum(prodqty) over (partition by item,format(Createdate,'MMM-yyyy') order by item, createdate asc
--rows between unbounded preceding and current row) 'CumQty' from PendingPOTracker_test

--) a where PendingPOTracker_test.PDNO=a.PDNO and PendingPOTracker_test.item=a.Item

--update PendingPOTracker_test set OverCapacityMonth= case when MonthCumUnits>MonthMax then 'Yes' else 'No' end 

--update PendingPOTracker_test set DayCumUnits= a.cumqty from (
--select PDNo,item,createdate,prodqty,
--sum(prodqty) over (partition by item,convert(date,createdate) order by item, createdate asc
--rows between unbounded preceding and current row) 'CumQty' from PendingPOTracker_test

--) a where PendingPOTracker_test.PDNO=a.PDNO and PendingPOTracker_test.item=a.Item

--update PendingPOTracker_test set OverCapacityDay= case when DayCumUnits>DayMax then 'Yes' else 'No' end 


---Hided before applying after logic
--update PendingPOTracker_test set Rn= a.rn from 
--(SELECT PDNo,Item,ProdQty,MaxSLA,
--ROW_NUMBER() OVER ( PARTITION BY Item ORDER BY MaxSLA, PDNo ) AS RN FROM PendingPOTracker_test
--) a where  PendingPOTracker_test.PDNO=a.PDNO and PendingPOTracker_test.item=a.Item

--------------------------------- LOGIC TO INCLUDE DAYMAX,MONTHMAX --------------------
;WITH QtyCTE AS
(
SELECT PDNO,Item,ProdQty,MaxSLA,
SUM(ProdQty) OVER(PARTITION BY Item ORDER BY MaxSLA,PDNO ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumQty
FROM PendingPOTracker_test)

UPDATE P SET RN = Q.CumQty FROM PendingPOTracker_test P INNER JOIN QtyCTE Q ON P.PDNO = Q.PDNO AND P.Item = Q.Item

UPDATE PendingPOTracker_test SET MonthNo = CASE WHEN MonthMax > 0 THEN FLOOR((RN - 1.0) / MonthMax) ELSE 0 END

UPDATE PendingPOTracker_test SET MonthAllocation = DATEADD (MONTH,MonthNo,DATEFROMPARTS(YEAR(MaxSLA),MONTH(MaxSLA),1))

UPDATE PendingPOTracker_test SET MonthAllocation =CASE WHEN MaxSLA > MonthAllocation THEN MaxSLA ELSE MonthAllocation END

UPDATE PendingPOTracker_test SET PositionInMonth = CASE WHEN MonthMax > 0 THEN CAST(RN - ProdQty AS INT) % CAST(MonthMax AS INT) ELSE 0 END

UPDATE PendingPOTracker_test SET FinalAllocation = dbo.[UFN_CompWorking_days](MonthAllocation,FLOOR(PositionInMonth/NULLIF(DayMax,0)))

UPDATE P SET FinalAllocation = W.WorkDate FROM PendingPOTracker_test P CROSS APPLY(
SELECT TOP 1 WorkDate FROM VW_CompanyWorkingCalendar WHERE WorkDate >= P.FinalAllocation ORDER BY WorkDate) W;

UPDATE PendingPOTracker_test SET FinalAllocation = MaxSLA where FinalAllocation is null

-------- Method 2 ----------------

------------------------------------------------------
---- Recursuive
------------------------------------------------------

--UPDATE PendingPOTracker_test
--SET FinalAllocation = NULL;

--DECLARE
--      @PDNO NVARCHAR(50)
--    , @Item NVARCHAR(255)
--    , @MaxSLA DATE
--    , @MonthMax INT
--    , @DayMax INT;

--DECLARE cur CURSOR LOCAL FAST_FORWARD FOR

--SELECT
--      PDNO
--    , Item
--    , CAST(MaxSLA AS DATE)
--    , ISNULL(MonthMax,0)
--    , ISNULL(DayMax,0)
--FROM PendingPOTracker_test
--ORDER BY Item, MaxSLA, PDNO;

--OPEN cur;

--FETCH NEXT FROM cur
--INTO
--      @PDNO
--    , @Item
--    , @MaxSLA
--    , @MonthMax
--    , @DayMax;

--WHILE @@FETCH_STATUS = 0
--BEGIN

--    DECLARE @CandidateDate DATE;

--    SET @CandidateDate = @MaxSLA;

--    ------------------------------------------------
--    -- Move to next working day
--    ------------------------------------------------
--    SELECT TOP 1
--           @CandidateDate = WorkDate
--    FROM VW_CompanyWorkingCalendar
--    WHERE WorkDate >= @CandidateDate
--    ORDER BY WorkDate;

--    ------------------------------------------------
--    -- Find first available slot
--    ------------------------------------------------
--    WHILE 1 = 1
--    BEGIN

--        DECLARE @MonthUsed INT;
--        DECLARE @DayUsed INT;

--        SELECT
--            @MonthUsed = COUNT(*)
--        FROM PendingPOTracker_test
--        WHERE Item = @Item
--          AND FinalAllocation IS NOT NULL
--          AND YEAR(FinalAllocation)=YEAR(@CandidateDate)
--          AND MONTH(FinalAllocation)=MONTH(@CandidateDate);

--        SELECT
--            @DayUsed = COUNT(*)
--        FROM PendingPOTracker_test
--        WHERE Item = @Item
--          AND FinalAllocation=@CandidateDate;

--        IF
--        (
--             (@MonthMax > 0 AND @MonthUsed >= @MonthMax)
--          OR (@DayMax > 0 AND @DayUsed >= @DayMax)
--        )
--        BEGIN

--            SELECT TOP 1
--                   @CandidateDate = WorkDate
--            FROM VW_CompanyWorkingCalendar
--            WHERE WorkDate > @CandidateDate
--            ORDER BY WorkDate;

--        END
--        ELSE
--        BEGIN
--            BREAK;
--        END

--    END

--    UPDATE PendingPOTracker_test
--    SET FinalAllocation = @CandidateDate
--    WHERE PDNO = @PDNO
--      AND Item = @Item;

--    FETCH NEXT FROM cur
--    INTO
--          @PDNO
--        , @Item
--        , @MaxSLA
--        , @MonthMax
--        , @DayMax;

--END

--CLOSE cur;
--DEALLOCATE cur;


------------- STEP 11 Update Ageing,duetype, ageingbucket  -------------

--alter table PendingPOTracker_test add DuetypeOrder int
Update PendingPOTracker_test set ageing= datediff(d,convert(date,finalallocation), convert(date,getdate()))

update PendingPOTracker_test set Duetype = 'Withindue' where ageing<0

update PendingPOTracker_test set Duetype = 'Likely overdue (Incl. 0 days)' where ageing between -7 and 0

update PendingPOTracker_test set Duetype = 'Overdue' where ageing >=1

update PendingPOTracker_test set DuetypeOrder = 1 where ageing<0

update PendingPOTracker_test set DuetypeOrder = 2 where ageing between -7 and 0

update PendingPOTracker_test set DuetypeOrder = 3 where ageing >=1

-------------Overdue logic
--Update PendingPOTracker_test set Ageingbucket = 'Within due' where ageing < -7

Update PendingPOTracker_test set Ageingbucket = '0 days' where ageing =0

Update PendingPOTracker_test set Ageingbucket = '1-7 days' where ageing between 1 and 7

Update PendingPOTracker_test set Ageingbucket = '8-14 days' where ageing between 8 and 14

Update PendingPOTracker_test set Ageingbucket = '15-21 days' where ageing between 15 and 21

Update PendingPOTracker_test set Ageingbucket = '22-28 days' where ageing between 22 and 28

Update PendingPOTracker_test set Ageingbucket = '29-35 days' where ageing between 29 and 35

Update PendingPOTracker_test set Ageingbucket = '36-42 days' where ageing between 36 and 42

Update PendingPOTracker_test set Ageingbucket = '43-49 days' where ageing between 43 and 49

Update PendingPOTracker_test set Ageingbucket = '50-90 days' where ageing between 50 and 90

Update PendingPOTracker_test set Ageingbucket = '91-120 days' where ageing between 91 and 120

Update PendingPOTracker_test set Ageingbucket = '121-180 days' where ageing between 121 and 180

Update PendingPOTracker_test set Ageingbucket = '>180 days' where ageing between 181 and 365

Update PendingPOTracker_test set Ageingbucket = '>1 Year' where ageing >= 366

-------------Within due logic

Update PendingPOTracker_test set Ageingbucket = '1-7 days' where ageing between -7 and -1

Update PendingPOTracker_test set Ageingbucket = '8-14 days' where ageing between -14 and -8

Update PendingPOTracker_test set Ageingbucket = '15-21 days' where ageing between -21 and -15

Update PendingPOTracker_test set Ageingbucket = '22-28 days' where ageing between -28 and -22

Update PendingPOTracker_test set Ageingbucket = '29-35 days' where ageing between -35 and -29 

Update PendingPOTracker_test set Ageingbucket = '36-42 days' where ageing between -42 and -36

Update PendingPOTracker_test set Ageingbucket = '43-49 days' where ageing between -49 and -43

Update PendingPOTracker_test set Ageingbucket = '50-90 days' where ageing between -90 and -50

Update PendingPOTracker_test set Ageingbucket = '91-120 days' where ageing between -120 and -91

Update PendingPOTracker_test set Ageingbucket = '121-180 days' where ageing between -180 and -121

Update PendingPOTracker_test set Ageingbucket = '>180 days' where ageing between -365 and -181

Update PendingPOTracker_test set Ageingbucket = '>1 Year' where ageing  <= -366


Update PendingPOTracker_test set AgeingbucketOrder = 1 where Ageingbucket='0 days'

Update PendingPOTracker_test set AgeingbucketOrder = 2 where Ageingbucket = '1-7 days'

Update PendingPOTracker_test set AgeingbucketOrder = 3 where Ageingbucket = '8-14 days'

Update PendingPOTracker_test set AgeingbucketOrder = 4 where Ageingbucket = '15-21 days'

Update PendingPOTracker_test set AgeingbucketOrder = 5 where Ageingbucket = '22-28 days'

Update PendingPOTracker_test set AgeingbucketOrder = 6 where Ageingbucket = '29-35 days'

Update PendingPOTracker_test set AgeingbucketOrder = 7 where Ageingbucket = '36-42 days'

Update PendingPOTracker_test set AgeingbucketOrder = 8 where Ageingbucket = '43-49 days'

Update PendingPOTracker_test set AgeingbucketOrder = 9 where Ageingbucket = '50-90 days'

Update PendingPOTracker_test set AgeingbucketOrder = 10 where Ageingbucket = '91-120 days' 

Update PendingPOTracker_test set AgeingbucketOrder = 11 where Ageingbucket = '121-180 days' 

Update PendingPOTracker_test set AgeingbucketOrder = 12 where Ageingbucket = '>180 days' 

Update PendingPOTracker_test set AgeingbucketOrder = 13 where Ageingbucket = '>1 Year'


--ALTER TABLE PendingPOTracker_test add OrderType nvarchar(100)

update PendingPOTracker_test set OrderType= 'Strategic Order' where convert(date,deldt) not in
(select WorkDate from  dbo.VW_CompanyWorkingCalendar )

update PendingPOTracker_test set OrderType= 'Customer Order' where convert(date,deldt) in
(select WorkDate from  dbo.VW_CompanyWorkingCalendar )



--daymax validation
--SELECT
--    Item,
--    FinalAllocation,
--    COUNT(*) Allocated,
--    MAX(DayMax) DayMax
--FROM PendingPOTracker_test
--GROUP BY
--    Item,
--    FinalAllocation
--HAVING COUNT(*) > MAX(DayMax);

--------month max vaildation 
--SELECT
--    Item,
--    YEAR(FinalAllocation) YR,
--    MONTH(FinalAllocation) MTH,
--    COUNT(*) Allocated,
--    MAX(MonthMax) MonthMax
--FROM PendingPOTracker_test
--GROUP BY
--    Item,
--    YEAR(FinalAllocation),
--    MONTH(FinalAllocation)
--HAVING COUNT(*) > MAX(MonthMax);


--------------------------------------- OTA REPORT RELATED FIELDS ------------------------------

---Logic shared that if clearance date is blank then take create date as clearance date 

update PendingPOTracker_test set ClearDate=CreateDate where ClearDate is null

----alter table PendingPOTracker_test add InvDate nvarchar(255)

update  PendingPOTracker_test set InvPDNO=a.ProductionNum,invno=a.Invoice,invdate=a.Inv_date,invfabno=a.Fab from (

SELECT a.Company,a.DPST, a.OrderNum, a.Custcode, a.CustName, a.ItemCode, a.Item_desc,a.PositionNum,
       b.SHPM AS ShipmentNo, c.T$CSER AS Fab, b.QSHP AS DelQty,
       d.INVN AS Invoice, CAST(d.INVD AS DATE) AS Inv_date,
       e.PDNO AS ProductionNum, a.AreaName, f.PUTN AS UTN, a.OrderDate,
       CAST(f.CLDT AS DATE) AS Clearance_date, CAST(f.DDAT AS DATE) AS Cust_date,
       a.qty AS OrderQty, a.Price, g.QRDR AS ProductionQty,Target_OTA,Completed_Date,delivery_date,Release_Date,OTA_GAPDAYS
FROM sales_Inflow a
JOIN ELGI_Companies_Master em ON a.Company = em.Company AND em.CompanyGroup = 'ELGI'
JOIN SaleType_Master sm ON sm.Company = a.Company 
                       AND sm.SaleOrderType = a.OrderType
                       AND sm.Sales_Category NOT IN (1)
LEFT JOIN TWHINH431ALL b ON Ltrim(RTRIM(b.Item)) = Ltrim(RTRIM(a.ItemCode)) AND a.OrderNum = b.WORN AND b.Company='401' AND b.QSHP>0
LEFT JOIN TWHINH433ALL c ON b.SHPM = c.T$SHPM AND b.PONO = c.T$PONO AND c.Company='401'
LEFT JOIN TWHINH430ALL d ON b.SHPM = d.SHPM AND d.Company='401'
LEFT JOIN TTIMFC010ALL e ON e.MSER = c.T$CSER AND e.Company='401'
LEFT JOIN TZZSFC254ALL f ON Ltrim(RTRIM(a.ItemCode)) = Ltrim(RTRIM(f.ITEM)) AND a.PositionNum = f.PONO AND a.OrderNum = f.ORNO AND f.Company='401'
LEFT JOIN TTISFC001ALL g ON e.PDNO = g.PDNO AND Ltrim(RTRIM(a.ItemCode)) = Ltrim(RTRIM(g.MITM)) AND g.Company='401'
LEFT JOIN utn_ver1 h ON e.PDNO = h.Production_ord_no and Ltrim(RTRIM(a.ItemCode)) = Ltrim(RTRIM(h.Item))
 WHERE a.Company = '401'
     AND a.OrderDate >= '2024-04-01'
     AND a.OrderDate < DATEADD(DAY,1,CAST(GETDATE() AS DATE))

 
 )a where trim(PendingPOTracker_test.SaleOrdNo)=trim(a.OrderNum) and trim(PendingPOTracker_test.Item)=trim(a.itemcode)
 

 ------------- OTA Calculation --------------------


  --ALTER TABLE PendingPOTracker_test ADD OTA_TargetDate date
  --ALTER TABLE PendingPOTracker_test ADD OTA_ActDate date 
  -- alter table  PendingPOTracker_test add OTA_GapDays int 
  -- alter table  PendingPOTracker_test add OTA_Score int 

update PendingPOTracker_test set OTA_TargetDate=FinalAllocation

update PendingPOTracker_test set OTA_ActDate= CompDt

update PendingPOTracker_test set OTA_Score=case when OTA_ActDate<=OTA_TargetDate then 100 else 0 end  

UPDATE PendingPOTracker_test
SET OTA_GapDays =
(
    CASE
        WHEN ISNULL(NULLIF(CAST(PendingPOTracker_test.OTA_ActDate AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
             >= CAST(PendingPOTracker_test.OTA_TargetDate AS DATE)
        THEN 1
        ELSE -1
    END
)
*
(
    SELECT COUNT(*)
    FROM TTCCCP020400 C
    WHERE C.ccal = 'Company'
      AND C.dfca = 1
      AND CAST(C.[date] AS DATE) >
          CASE
              WHEN CAST(PendingPOTracker_test.OTA_TargetDate AS DATE) <
                   ISNULL(NULLIF(CAST(PendingPOTracker_test.OTA_ActDate AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
              THEN CAST(PendingPOTracker_test.OTA_TargetDate AS DATE)
              ELSE ISNULL(NULLIF(CAST(PendingPOTracker_test.OTA_ActDate AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
          END
      AND CAST(C.[date] AS DATE) <=
          CASE
              WHEN CAST(PendingPOTracker_test.OTA_TargetDate AS DATE) >
                   ISNULL(NULLIF(CAST(PendingPOTracker_test.OTA_ActDate AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
              THEN CAST(PendingPOTracker_test.OTA_TargetDate AS DATE)
              ELSE ISNULL(NULLIF(CAST(PendingPOTracker_test.OTA_ActDate AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
          END
);

--alter table PendingPOTracker_test add Remarks nvarchar(150)

--update PendingPOTracker_test  set Remarks='Po Deleted' 
--where PendingPOTracker_test.PDNO in
--(select distinct PDNO  From PendingPOTracker_test 
--where --UTN<>'' and PDNO is not null and PDNO <>'' and
-- PDNO not in (select distinct PDNO  From TTISFC001All where company=401 ))

------------ OTG CACLUTAION --------------------

  --ALTER TABLE PendingPOTracker_test ADD OTG_TargetDate date
  --ALTER TABLE PendingPOTracker_test ADD OTG_ActDate date

  --ALTER TABLE PendingPOTracker_test ADD OTG_GapDays int
   -- alter table  PendingPOTracker_test add OTG_Score int 

update PendingPOTracker_test set OTG_TargetDate=ClearDate

update PendingPOTracker_test set OTG_ActDate= CreateDate

update PendingPOTracker_test set OTG_Score=case when OTG_ActDate<=OTG_TargetDate then 100 else 0 end  

UPDATE PendingPOTracker_test set OTG_GAPDAYS = 
(
    CASE
        WHEN ISNULL(NULLIF(CAST(PendingPOTracker_test.OTG_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
             >= CAST(PendingPOTracker_test.OTG_TARGETDATE AS DATE)
        THEN 1
        ELSE -1
    END
)
*
(
    SELECT COUNT(*)
    FROM TTCCCP020400 C
    WHERE C.ccal = 'Company'
      AND C.dfca = 1
      AND CAST(C.[date] AS DATE) >
          CASE
              WHEN CAST(PendingPOTracker_test.OTG_TARGETDATE AS DATE) <
                   ISNULL(NULLIF(CAST(PendingPOTracker_test.OTG_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
              THEN CAST(PendingPOTracker_test.OTG_TARGETDATE AS DATE)
              ELSE ISNULL(NULLIF(CAST(PendingPOTracker_test.OTG_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
          END
      AND CAST(C.[date] AS DATE) <=
          CASE
              WHEN CAST(PendingPOTracker_test.OTG_TARGETDATE AS DATE) >
                   ISNULL(NULLIF(CAST(PendingPOTracker_test.OTG_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
              THEN CAST(PendingPOTracker_test.OTG_TARGETDATE AS DATE)
              ELSE ISNULL(NULLIF(CAST(PendingPOTracker_test.OTG_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
          END
);


------------ OTP CACLUTAION --------------------

  --ALTER TABLE PendingPOTracker_test ADD OTP_TargetDate date
  --ALTER TABLE PendingPOTracker_test ADD OTP_ActDate date

  --ALTER TABLE PendingPOTracker_test ADD OTP_GapDays int
     -- alter table  PendingPOTracker_test add OTP_Score int 

update PendingPOTracker_test set OTP_TargetDate= dbo.[UFN_CompWorking_days](OTA_TargetDate,-4)

update PendingPOTracker_test set OTP_ActDate= DelDT --RDLD

update PendingPOTracker_test set OTP_Score=case when OTP_ActDate<=OTP_TargetDate then 100 else 0 end  

UPDATE PendingPOTracker_test set OTP_GAPDAYS = 
(
    CASE
        WHEN ISNULL(NULLIF(CAST(PendingPOTracker_test.OTP_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
             >= CAST(PendingPOTracker_test.OTP_TARGETDATE AS DATE)
        THEN 1
        ELSE -1
    END
)
*
(
    SELECT COUNT(*)
    FROM TTCCCP020400 C
    WHERE C.ccal = 'Company'
      AND C.dfca = 1
      AND CAST(C.[date] AS DATE) >
          CASE
              WHEN CAST(PendingPOTracker_test.OTP_TARGETDATE AS DATE) <
                   ISNULL(NULLIF(CAST(PendingPOTracker_test.OTP_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
              THEN CAST(PendingPOTracker_test.OTP_TARGETDATE AS DATE)
              ELSE ISNULL(NULLIF(CAST(PendingPOTracker_test.OTP_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
          END
      AND CAST(C.[date] AS DATE) <=
          CASE
              WHEN CAST(PendingPOTracker_test.OTP_TARGETDATE AS DATE) >
                   ISNULL(NULLIF(CAST(PendingPOTracker_test.OTP_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
              THEN CAST(PendingPOTracker_test.OTP_TARGETDATE AS DATE)
              ELSE ISNULL(NULLIF(CAST(PendingPOTracker_test.OTP_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
          END
);



------------ OTR CACLUTAION --------------------

  --ALTER TABLE PendingPOTracker_test ADD OTR_TargetDate date
  --ALTER TABLE PendingPOTracker_test ADD OTR_ActDate date

  --ALTER TABLE PendingPOTracker_test ADD OTR_GapDays int
   -- alter table  PendingPOTracker_test add OTR_Score int 
update PendingPOTracker_test set OTR_TargetDate= DelDt --RDLD

update PendingPOTracker_test set OTR_ActDate= RelDt --RELEASE DATE

update PendingPOTracker_test set OTR_Score=case when OTR_ActDate<=OTR_TargetDate then 100 else 0 end  

UPDATE PendingPOTracker_test set OTR_GAPDAYS = 
(
    CASE
        WHEN ISNULL(NULLIF(CAST(PendingPOTracker_test.OTR_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
             >= CAST(PendingPOTracker_test.OTR_TARGETDATE AS DATE)
        THEN 1
        ELSE -1
    END
)
*
(
    SELECT COUNT(*)
    FROM TTCCCP020400 C
    WHERE C.ccal = 'Company'
      AND C.dfca = 1
      AND CAST(C.[date] AS DATE) >
          CASE
              WHEN CAST(PendingPOTracker_test.OTR_TARGETDATE AS DATE) <
                   ISNULL(NULLIF(CAST(PendingPOTracker_test.OTR_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
              THEN CAST(PendingPOTracker_test.OTR_TARGETDATE AS DATE)
              ELSE ISNULL(NULLIF(CAST(PendingPOTracker_test.OTR_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
          END
      AND CAST(C.[date] AS DATE) <=
          CASE
              WHEN CAST(PendingPOTracker_test.OTR_TARGETDATE AS DATE) >
                   ISNULL(NULLIF(CAST(PendingPOTracker_test.OTR_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
              THEN CAST(PendingPOTracker_test.OTR_TARGETDATE AS DATE)
              ELSE ISNULL(NULLIF(CAST(PendingPOTracker_test.OTR_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
          END
);

------------ OTC CACLUTAION --------------------

  --ALTER TABLE PendingPOTracker_test ADD OTC_TargetDate date
  --ALTER TABLE PendingPOTracker_test ADD OTC_ActDate date

  --ALTER TABLE PendingPOTracker_test ADD OTC_GapDays int
     -- alter table  PendingPOTracker_test add OTC_Score int 
update PendingPOTracker_test set OTC_TargetDate= dbo.UFN_CompWorking_days(reldt,2) --RDLD

update PendingPOTracker_test set OTC_ActDate= Compdt --RELEASE DATE

update PendingPOTracker_test set OTC_Score=case when OTC_ActDate<=OTC_TargetDate then 100 else 0 end  

UPDATE PendingPOTracker_test set OTC_GAPDAYS = 
(
    CASE
        WHEN ISNULL(NULLIF(CAST(PendingPOTracker_test.OTC_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
             >= CAST(PendingPOTracker_test.OTC_TARGETDATE AS DATE)
        THEN 1
        ELSE -1
    END
)
*
(
    SELECT COUNT(*)
    FROM TTCCCP020400 C
    WHERE C.ccal = 'Company'
      AND C.dfca = 1
      AND CAST(C.[date] AS DATE) >
          CASE
              WHEN CAST(PendingPOTracker_test.OTC_TARGETDATE AS DATE) <
                   ISNULL(NULLIF(CAST(PendingPOTracker_test.OTC_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
              THEN CAST(PendingPOTracker_test.OTC_TARGETDATE AS DATE)
              ELSE ISNULL(NULLIF(CAST(PendingPOTracker_test.OTC_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
          END
      AND CAST(C.[date] AS DATE) <=
          CASE
              WHEN CAST(PendingPOTracker_test.OTC_TARGETDATE AS DATE) >
                   ISNULL(NULLIF(CAST(PendingPOTracker_test.OTC_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
              THEN CAST(PendingPOTracker_test.OTC_TARGETDATE AS DATE)
              ELSE ISNULL(NULLIF(CAST(PendingPOTracker_test.OTC_ACTDATE AS DATE),'1970-01-01'),CAST(GETDATE() AS DATE))
          END
);


insert into PendingPOTraker_test_history

select *,getdate() from PendingPOTracker_test

GO

