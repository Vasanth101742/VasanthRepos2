CREATE	 proc [dbo].[sp_wms_order_status]
as
begin

--alter table wms_order_status alter column orderdate datetime
--alter table wms_order_status alter column sdat datetime
--alter table wms_order_status alter column inv_date datetime
--alter table wms_order_status alter column remarks varchar(100)
--alter table wms_order_status alter column Responsibility varchar(50)
--alter table wms_order_status alter column Shipment_Status varchar(50)
--alter table wms_order_status alter column ITAD VARCHAR(100)
--alter table wms_order_status alter column SHIPADDRESS VARCHAR(1000)

--alter table wms_order_status1 add cwar nvarchar(10)

truncate table [wms_order_status1]

truncate table wms_order_status


insert into wms_order_status ([SHPM]
           ,[ORNO]
           ,[PONO]
           ,[SEQN]
           ,[Qty]
           ,[lddt]
           ,[OFBP]
           ,[ITEM]
           ,[price]
		   ,[cwar]
           ,[PACKSTATUS]
           ,[STATUS]
           ,[susr5]
           ,[stat_desc]
           ,[packstat_desc]
           ,[shst]
           ,[stat603]
           ,[remarks]
           ,[ordertype]
           ,[saletype]
           ,[sdat]
           ,[Invno]
           ,[INv_date]
           ,[custname]
           ,[orderdate]
           ,[Responsibility]
           ,[Shipment_Status]
           ,[value]
           ,[TBONO]
           ,[shipment_totalqty]
           ,[WMS_ORDERNO]
           ,[WAVEKEY]
           ,[FTD]
           ,[DOM_FTD]
           ,[DOM_MTD]
           ,[RLY_FTD]
           ,[RLY_MTD]
           ,[EXP_FTD]
           ,[EXP_MTD]
           ,[SANAND_FTD]
           ,[SANAND_MTD]
           ,[Others_FTD]
           ,[Others_MTD]
           ,[MTD]
           ,[NoofLInes]
           ,[SUB_FTD]
           ,[SUB_MTD]
           ,[DIREXP_FTD]
           ,[DIREXP_MTD]
           ,[ITAD]
           ,[SHIPADDRESS]
           ,[Pack_Complete_date]
           )

select * from (
select A.*,B.PACKSTATUS,B.STATUS,B.susr5,'                                 'as stat_desc ,'                       ' as packstat_desc,'   ' as shst,'       ' as stat603,'                                                          ' as remarks
,'       ' as ordertype,'       ' as saletype , null as sdat, '                 ' as Invno,null as INv_date,
'                      ' as custname,null as orderdate,'                                   ' as Responsibility,'                  ' as Shipment_Status,0 as value,'                                 ' as TBONO,b.TOTALQTY ,'                   ' AS WMS_ORDERNO



,'                ' AS WAVEKEY,0 as FTD,0 AS DOM_FTD,0 AS DOM_MTD,0 AS RLY_FTD,0 AS RLY_MTD,0 AS EXP_FTD,0 AS EXP_MTD,
0 as SANAND_FTD,0 AS SANAND_MTD,0 as Others_FTD,0 AS Others_MTD,0 as MTD,0 as Nooflines,
0 AS SUB_FTD,0 AS SUB_MTD,0 AS DIREXP_FTD,0 AS DIREXP_MTD,
''ITAD,''SHIPADDRESS,''Pack_Complete_date

 from (
select A.SHPM,convert(decimal(19,0),A.ORNO)ORNO,convert(decimal(19,0),A.PONO)PONO,convert(decimal(19,0),A.SEQN)SEQN,Qty,lddt,B.OFBP,B.ITEM,B.price,a.CWAR From

(select SHPM,ORNO,PONO,SEQN,QPLI AS Qty,'' as lddt,CWAR from TWHINH480490 where oorg=1 and convert(date,lddt)>='20240101')A
LEFT JOIN (Select convert(decimal(19,0),ORNO)ORNO,convert(decimal(19,0),PONO)PONO,convert(decimal(19,0),SQNB)SQNB,OFBP,ITEM,0 AS PRICE,cwar From TTDSLS401490)B
ON convert(decimal(19,0),A.ORNO)=B.ORNO
AND convert(decimal(19,0),A.PONO)=B.PONO
and convert(decimal(19,0),A.SEQN)=b.SQNB 
and a.cwar = b.cwar
)a

left join (SELECT distinct TOTALQTY,isnull(a.STATUS,0)STATUS,isnull(EXT_UDF_LKUP1,0)PACKSTATUS
,substring(ltrim(rtrim(externorderkey)),5,20) as Shipment,0 as susr5  
FROM wmwhse1_ORDERS a
) b on a.SHPM=b.Shipment

)a where Qty not like '%:%'

update wms_order_status set stat_desc=a.description from (select code,description from [wmwhse1_ORDERSTATUSSETUP] where SCHEMA_REFERENCE='wmwhse1' )a
where a.code=wms_order_status.STATUS


----Gokul
--UPDATE wms_order_status
--SET packstat_desc = 
--    CASE 
--        WHEN wms_order_status.cwar = '103' 
--            THEN ISNULL(b.DESCRIPTION, a.DESCRIPTION)
--        ELSE a.DESCRIPTION
--    END
--FROM wms_order_status
--LEFT JOIN wmwhse1_CODELKUP a    ON a.SCHEMA_REFERENCE = 'wmwhse1'
--    AND a.LISTNAME = 'T19UDF1'   AND a.CODE = wms_order_status.packstatus
--LEFT JOIN
--(SELECT DISTINCT   b.DESCRIPTION,
--        pd.ORDERKEY    FROM wmwhse1_PICKDETAIL pd
--    LEFT JOIN wmwhse1_CODELKUP b       ON b.SCHEMA_REFERENCE = 'wmwhse2'
--        AND b.LISTNAME = 'ordrstatus'        AND b.CODE = pd.STATUS
--    WHERE pd.SCHEMA_REFERENCE = 'wmwhse2') b
--    ON wms_order_status.WMS_ORDERNO = b.ORDERKEY  AND wms_order_status.CWAR = '103';

--update wms_order_status set packstat_desc=a.description from (select code,description from 
--wmwhse1_CODELKUP where SCHEMA_REFERENCE='wmwhse1' and listname='T19UDF1')a
--where a.code=wms_order_status.packstatus

----Gokul
--update wms_order_status set packstat_desc=a.DESCRIPTION  from (select distinct b.DESCRIPTION,ORDERKEY  From wmwhse1_PICKDETAIL a
--left join wmwhse1_CODELKUP b on b.SCHEMA_REFERENCE='wmwhse2'  and b.LISTNAME='ordrstatus' and b.code=a.status
--where a.SCHEMA_REFERENCE='wmwhse2' )a
--where wms_order_status.WMS_ORDERNO=a.ORDERKEY and cwar='103'
----Gokul


-------------------------------STEP 2 - UPDATING SHST,ORDER TYPE,SALE TYPE,ORDER DETAILS---------------------------------------

update wms_order_status set shst=convert(decimal(19),a.SHST) from (select distinct  SHST,shpm from [dbo].[TWHINH430490])a
where wms_order_status.SHPM=a.SHPM


update wms_order_status set ordertype=a.sotp,susr5 =cofc from (select distinct ORNO,sotp,COFC From TTDSLS400490 )a
where wms_order_status.orno=a.orno

update wms_order_status set saletype =1
where ordertype in (SELECT DISTINCT saleordertype  fROM [ELGi_LN].DBO.saletype_master WHERE company =490 AND Sales_Category =1)

update wms_order_status set lddt=A.ORDERDATE ,WMS_ORDERNO=ORDERKEY
FROM(SELECT substring(ltrim(rtrim(externorderkey)),5,20) as Shipment,ORDERDATE,ORDERKEY  FROM wmwhse1_ORDERS)A
WHERE  wms_order_status.SHPM=A.Shipment



-------------------------------STEP 3 - UPDATING PACK STAT DESC ---------------------------------------


-----------Ravi ----------
UPDATE wms_order_status
SET packstat_desc = 
    CASE 
        WHEN wms_order_status.cwar = '103' 
            THEN ISNULL(b.DESCRIPTION, a.DESCRIPTION)
        ELSE a.DESCRIPTION
    END
FROM wms_order_status
LEFT JOIN wmwhse1_CODELKUP a    ON a.SCHEMA_REFERENCE = 'wmwhse1'
    AND a.LISTNAME = 'T19UDF1'   AND a.CODE = wms_order_status.packstatus
LEFT JOIN
(SELECT DISTINCT   b.DESCRIPTION,
        pd.ORDERKEY    FROM wmwhse1_PICKDETAIL pd
    LEFT JOIN wmwhse1_CODELKUP b       ON b.SCHEMA_REFERENCE = 'wmwhse2'
        AND b.LISTNAME = 'ordrstatus'        AND b.CODE = pd.STATUS
    WHERE pd.SCHEMA_REFERENCE = 'wmwhse2') b
    ON wms_order_status.WMS_ORDERNO = b.ORDERKEY  AND wms_order_status.CWAR = '103';


-------------------------------STEP 4 - UPDATING WAVEKEY,STAT603,INVOICE AND ORDER DATES,CUST INFO,PRICE ---------------------------------------

update wms_order_status set WAVEKEY=a.WAVEKEY  from (select distinct WAVEKEY,ORDERKEY  From wmwhse1_PICKDETAIL )a
where wms_order_status.WMS_ORDERNO=a.ORDERKEY 

update wms_order_status set stat603=convert(decimal(19,0),stat), sdat=a.sdat 
from  (select SHPM ,STAT ,max(SDAT) SDAT from tzzsls604490 group by  SHPM ,STAT )a
where wms_order_status.SHPM =a.SHPM

update wms_order_status set Invno=A.invoice FROM(select distinct concat([TRAN],'/',convert(decimal(19,0),IDOC))as invoice,oref  
		From TCISLI310490 where convert(date,DDAT)>'20250101' )A
where wms_order_status.SHPM =a.oref

update wms_order_status set INv_date=A.IDAT FROM(select concat([tran],'/',convert(decimal(19,0),IDOC))as invoice,IDAT  From TCISLI305490 
where convert(date,IDAT)>'20250101' )A
where wms_order_status.Invno =a.invoice

update wms_order_status set orderdate=a.odat from (select ODAT,ORNO  From TTDSLS401490)a
where wms_order_status.ORNO=a.orno

update wms_order_status set custname=a.custname from (select custcode ,SUBSTRING(custname1,1,20) as custname  from [ELGi_LN].dbo.vw_Business_Partner)a
where wms_order_status.OFBP=a.custcode

update wms_order_status set PRICE=a.PRICE FROM (
Select ORNO,PONO,sum(pric)PRICE,cwar
 From TTDSLS401490 WHERE convert(date,odat)>'20230101'and  SQNB=0 group by ORNO,PONO,cwar)A
where wms_order_status.ORNO=a.ORNO
and wms_order_status.PONO=a.PONO
and wms_order_status.cwar = a.cwar

-------- for Rate Convertion
update wms_order_status set PRICE=price* case when RATS$1<=0 then 1 else RATS$1 end from(select distinct ORNO,RATS$1,cwar from TTDSLS400490 where  convert(date,odat)>'20230101')a
where  wms_order_status.ORNO =a.ORNO and wms_order_status.cwar = a.cwar
 	


-------------------------------STEP 5 - UPDATING REMARKS ---------------------------------------
--delete from wms_order_status where sdat is not null

update wms_order_status set remarks ='Picking Not Started'  where stat_desc ='Released'
update wms_order_status set remarks ='Waiting For Released'  where stat_desc in ('Created Externally','Cancelled Internally')
update wms_order_status set remarks ='Not Started'  where stat_desc in ('Not Started','Did Not Allocate')
update wms_order_status set remarks ='In Picking In process'  where stat_desc ='Part Picked'
update wms_order_status set remarks ='Partly Released'  where stat_desc ='Part Released'

update wms_order_status set remarks ='Move to FG Location'  where stat_desc ='Picked Complete' and packstat_desc='Host Packing Completed'
update wms_order_status set remarks ='In Packing'  where stat_desc ='Picked Complete' and packstat_desc='In Packing'
update wms_order_status set remarks ='Waiting For Packing'  where stat_desc ='Picked Complete' and packstat_desc='Ready for Packing'
update wms_order_status set remarks ='Shipment to confirm'  where stat_desc ='Picked Complete' and packstat_desc='Ready for Shipment'
update wms_order_status set remarks ='Move To Door'  where stat_desc ='Picked Complete' and ltrim(rtrim(packstat_desc))=''

update wms_order_status set remarks ='Packing Completed'  where stat_desc ='Pack Complete' and packstat_desc='Host Packing Completed'
update wms_order_status set remarks ='Packing in process'  where stat_desc ='Pack Complete' and packstat_desc='In Packing'
update wms_order_status set remarks ='Shipment to confirm'  where stat_desc  in ('Pack Complete','Part Shipped') and packstat_desc = 'Ready for Shipment'
update wms_order_status set remarks ='In Packing'  where stat_desc ='Pack Complete' and ltrim(rtrim(packstat_desc))=''

update wms_order_status set remarks ='Invoice To be done'  where stat_desc ='Shipped Complete' and INv_date is null
update wms_order_status set remarks ='Waiting For despatch'  where stat_desc ='Shipped Complete' and INv_date is not null and isnull(sdat,'')= ''


--update wms_order_status set remarks='Move to Stage' where cwar='103'  and stat_desc ='Pack Complete' and packstat_desc='Packed'
--update wms_order_status set remarks='Invoice To be done' where cwar='103'  and stat_desc ='Staged' 
--update wms_order_status set remarks ='Waiting For despatch' where  cwar='103'  and stat_desc ='Loaded' and packstat_desc='Loaded'
--update wms_order_status set remarks ='In Loading' where  cwar='103'  and stat_desc ='In Loading' and packstat_desc in ('Packed','Loaded')
--update wms_order_status set remarks ='In Packing'  where  cwar='103'  and stat_desc ='In Packing'


--Added by Ravi

UPDATE wms_order_status SET remarks = 'Part Shipped'
WHERE cwar = '103' AND stat_desc = 'Part Shipped' AND packstat_desc IN ('Shipped', 'Packed');

UPDATE wms_order_status SET remarks = 'Invoice to be done'
WHERE cwar = '103' AND stat_desc = 'Part Shipped' AND packstat_desc IN ('Shipped', 'Packed') AND TRIM(Invno) =''

UPDATE wms_order_status SET remarks = 'Waiting to Ship'
WHERE cwar = '103' AND stat_desc = 'Loaded' AND packstat_desc = 'Loaded';

UPDATE wms_order_status SET remarks = 'Invoice to be done'
WHERE cwar = '103' AND stat_desc = 'Loaded' AND packstat_desc = 'Loaded' AND TRIM(Invno) =''

UPDATE wms_order_status SET remarks = 'In Loading'
WHERE cwar = '103' AND stat_desc = 'In Loading' AND packstat_desc IN ('Loaded', 'Packed');

UPDATE wms_order_status SET remarks = 'Invoice to be done'
WHERE cwar = '103' AND stat_desc = 'In Loading' AND packstat_desc IN ('Loaded', 'Packed') AND TRIM(Invno) =''

UPDATE wms_order_status SET remarks = 'In Loading'
WHERE cwar = '103' AND stat_desc IN ('Staged','Part shipped') AND packstat_desc IN ('Loaded');

UPDATE wms_order_status SET remarks = 'Invoice to be done'
WHERE cwar = '103' AND stat_desc IN ('Staged','Part shipped') AND packstat_desc IN ('Loaded') AND TRIM(Invno) =''

UPDATE wms_order_status SET remarks = 'Waiting to Load'
WHERE cwar = '103' AND stat_desc = 'Staged' AND packstat_desc = 'Packed'

UPDATE wms_order_status SET remarks = 'Invoice to be done'
WHERE cwar = '103' AND stat_desc = 'Staged' AND packstat_desc = 'Packed'AND TRIM(Invno) =''

UPDATE wms_order_status SET remarks = 'Move to OB Staging'
--select remarks,* from wms_order_status
WHERE cwar = '103' AND stat_desc = 'Pack Complete' AND packstat_desc = 'Packed';

UPDATE wms_order_status SET remarks = 'In Packing'
WHERE cwar = '103' AND stat_desc IN ('Pack Complete') AND packstat_desc IN ('Picked/Sorted');

UPDATE wms_order_status SET remarks = 'In Packing'
WHERE cwar = '103'aND stat_desc IN ('In Packing') AND packstat_desc IN ('Packed', 'Picked/Sorted');

UPDATE wms_order_status SET remarks = 'Waiting to Pack'
WHERE cwar = '103' AND stat_desc = 'Picked Complete' AND packstat_desc = 'Picked/Sorted';

UPDATE wms_order_status SET remarks = 'Waiting to Pack'
WHERE cwar = '103' AND stat_desc = 'In Packing' AND packstat_desc = 'Released';

UPDATE wms_order_status SET remarks = 'In Picking In process'
WHERE cwar = '103' AND stat_desc IN ('Part Picked','Released') AND packstat_desc = 'Picked/Sorted';

UPDATE wms_order_status SET remarks = 'In Picking In process'
WHERE cwar = '103' AND stat_desc = 'Picked Complete' AND packstat_desc = 'Packed';

UPDATE wms_order_status SET remarks = 'Picking Not started'
WHERE cwar = '103' AND stat_desc = 'Released' AND packstat_desc IN ('Packed', 'Released');

UPDATE wms_order_status SET remarks = 'Picking Not started'
WHERE cwar = '103' AND stat_desc = 'Part Picked' AND packstat_desc IN ('Released');

UPDATE wms_order_status SET remarks = 'Waiting to Release'
WHERE cwar = '103' AND stat_desc IN ('Created Externally', 'Did Not Allocate', 'Not Started','Part Allocated');

UPDATE wms_order_status SET remarks = 'Waiting to Release'
WHERE cwar = '103' AND stat_desc IN ('Allocated') AND packstat_desc = 'Normal'


--alter table wms_order_status add Remarks1 nvarchar(250)

update wms_order_status set Responsibility=a.COMMENTS from (
select remarks,CASE WHEN remarks IN ('Waiting For despatch','Shipment to confirm','Move to FG Location','Invoice To be done','In Loading') THEN 'Commercial'
WHEN remarks IN ('Waiting For Released') THEN 'Planning'
WHEN remarks IN ('Packing Completed','Waiting For Packing','Partly Released','Picking Not Started','Move To Door','In Packing',
'In Picking In process','Partly Released','Packing in process','Not Started','Move to Stage') THEN 'Stores'
END AS COMMENTS from wms_order_status)a
where wms_order_status.remarks =a.remarks 


--added by Ravi


-------------------------------STEP 6 - UPDATING RESPONSIBILITY ---------------------------------------

UPDATE wms_order_status
SET Responsibility =
    CASE
        WHEN cwar = '103' AND (
               (stat_desc = 'Part Shipped' AND packstat_desc IN ('Shipped', 'Packed'))
            OR (stat_desc = 'Loaded' AND packstat_desc = 'Loaded')
            OR (stat_desc = 'In Loading' AND packstat_desc IN ('Loaded', 'Packed'))
            OR (stat_desc = 'Staged' AND packstat_desc IN ('Packed', 'Loaded'))
			OR (stat_desc = 'Part shipped' AND packstat_desc IN ('Loaded') AND TRIM(Invno) ='')
        )
        THEN 'Commercial'

		When cwar = '103' AND (
               (stat_desc = 'Part shipped' AND packstat_desc IN ('Loaded')) AND TRIM(Invno) <>'')
		THEN 'COMMERCIAL - Non billable activities'

        WHEN cwar = '103' AND (
               (stat_desc = 'Pack Complete' AND packstat_desc IN ('Packed', 'Picked/Sorted'))
            OR (stat_desc = 'In Packing' AND packstat_desc IN ('Packed', 'Picked/Sorted'))
            OR (stat_desc = 'Picked Complete' AND packstat_desc IN ('Picked/Sorted', 'Packed'))
            OR (stat_desc = 'Part Picked' AND packstat_desc IN ('Picked/Sorted', 'Picking Not started', 'Released'))
            OR (stat_desc = 'Released' AND packstat_desc IN ('Packed', 'Released', 'Picked/Sorted'))
			OR (stat_desc = 'In Packing' AND packstat_desc IN ('Released'))
            OR stat_desc IN ('Created Externally', 'Did Not Allocate', 'Not Started','Part Allocated')
			OR (stat_desc = 'Allocated' AND packstat_desc IN ('Normal'))
        )
        THEN 'Stores'

        ELSE NULL
    END
WHERE cwar = '103';



  Update wms_order_status Set Responsibility = 'COMMERCIAL - Non billable activities' Where 
  Responsibility = 'Commercial' and
  remarks <> 'Invoice To be done' and cwar = '103'


  --Alter table wms_order_status
  --add Responsibility1  nvarchar(50)





-------------------------------STEP 7 - UPDATING SHIPMENT STATUS ---------------------------------------

update wms_order_status set Shipment_Status='Open' where shst =1 
update wms_order_status set Shipment_Status='Frozen' where shst =2 
update wms_order_status set Shipment_Status='Confirmed' where shst =3 
update wms_order_status set Shipment_Status='Partially Frozen' where shst =10 
update wms_order_status set Shipment_Status='Confirming' where shst =20
update wms_order_status set Shipment_Status='Projected' where shst =30



-------------------------------STEP 8 - UPDATING FTD AND MTD AND VALUE ---------------------------------------
------------- TOTAL FTD AND MTD AND VALUE

update wms_order_status set FTD=ROUND(VAL,2) FROM (	
SELECT
     c.Warehouse,
    sum(b.AMTH$1/1000000) AS VAL
--	a.*,b.amth$1,c.WareHouse,b.ORNO
FROM
(
    SELECT IDAT, [TRAN], IDOC
    FROM TCISLI305490
    WHERE CONVERT(DATE, IDAT) > '20230101'
) a
INNER JOIN TCISLI310490 b
    ON LTRIM(RTRIM(a.[TRAN])) = LTRIM(RTRIM(b.[TRAN]))
    AND LTRIM(RTRIM(a.IDOC)) = LTRIM(RTRIM(b.IDOC))
inner JOIN ELGi_LN.dbo.Sales_Lines c
     ON b.COMPANY = c.Company
    and b.ORNO = c.OrderNum
    AND b.PONO = c.PositionNum
	and trim(b.item)=trim(c.itemcode) and t_sqnb=0
	--and ltrim(rtrim(c.invnum)) =LTRIM(RTRIM(a.IDOC))
WHERE
    b.sotp NOT IN
    (
        SELECT DISTINCT saleordertype
        FROM ELGi_LN.dbo.saletype_master
        WHERE company = 490 AND Sales_Category = 1
    )
    AND b.COFC NOT IN ('90029','90073')
    AND b.AMTH$1 > 0
    AND CONVERT(DATE, DATEADD(HOUR, 5, a.IDAT)) = CONVERT(DATE, GETDATE())
GROUP BY

   c.Warehouse

)a where wms_order_status.cwar=a.WareHouse


update wms_order_status set MTD=ROUND(VAL,2) FROM (SELECT
     c.Warehouse,
    sum(b.AMTH$1/1000000) AS VAL
--	a.*,b.amth$1,c.WareHouse,b.ORNO
FROM
(
    SELECT IDAT, [TRAN], IDOC
    FROM TCISLI305490
    WHERE CONVERT(DATE, IDAT) > '20230101'
) a
INNER JOIN TCISLI310490 b
    ON LTRIM(RTRIM(a.[TRAN])) = LTRIM(RTRIM(b.[TRAN]))
    AND LTRIM(RTRIM(a.IDOC)) = LTRIM(RTRIM(b.IDOC))
inner JOIN ELGi_LN.dbo.Sales_Lines c
     ON b.COMPANY = c.Company
    and b.ORNO = c.OrderNum
    AND b.PONO = c.PositionNum
	and trim(b.item)=trim(c.itemcode) and t_sqnb=0
	--and ltrim(rtrim(c.invnum)) =LTRIM(RTRIM(a.IDOC))
WHERE
    b.sotp NOT IN
    (
        SELECT DISTINCT saleordertype
        FROM ELGi_LN.dbo.saletype_master
        WHERE company = 490 AND Sales_Category = 1
    )
    AND b.COFC NOT IN ('90029','90073')
    AND b.AMTH$1 > 0
    and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
GROUP BY

   c.Warehouse
)a where wms_order_status.cwar=a.WareHouse

update wms_order_status set value=VAL FROM (select convert(decimal(19,2),SUM(b.AMTH$1)/1000000) as VAL,COFC,SHPM  
from(select IDAT,[TRAN],IDOC From TCISLI305490 where  convert(date,IDAT)>'20230101') a
	left join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	AND sotp not in  (SELECT DISTINCT saleordertype  fROM [ELGi_LN].DBO.saletype_master WHERE company =490 AND Sales_Category =1)
	and COFC not in ('90029','90073')and b.AMTH$1>'0'
		and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
		group by COFC,SHPM
)a
where convert(nvarchar,wms_order_status.susr5) =a.COFC

--and ltrim(rtrim(wms_order_status.SHPM)) =ltrim(rtrim(a.SHPM))
--------------------------------------- END
------- 1ST METHOD
----- SANAND
update wms_order_status set SANAND_MTD=ROUND(VAL,2) FROM (	
select sum(b.AMTH$1/1000000)as VAL,c.WareHouse  from(select IDAT,[TRAN],IDOC From TCISLI305416 WHERE [TRAN]='A12') a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and b.AMTH$1>0
	inner JOIN ELGi_LN.dbo.Sales_Lines c
     ON b.COMPANY = c.Company
    and b.ORNO = c.OrderNum
    AND b.PONO = c.PositionNum
	and trim(b.item)=trim(c.itemcode) and t_sqnb=0

and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
GROUP BY

   c.Warehouse
)a where wms_order_status.cwar=a.WareHouse

update wms_order_status set SANAND_FTD=ROUND(VAL,2) FROM (	select sum(b.AMTH$1/1000000)as VAL,c.WareHouse from(select IDAT,[TRAN],IDOC From TCISLI305416 WHERE [TRAN]='A12') a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC)) and b.AMTH$1>0 
and convert(Date,dateadd(hh,5,IDAT)) =CONVERT(DATE,GETDATE())
	inner JOIN ELGi_LN.dbo.Sales_Lines c
     ON b.COMPANY = c.Company
    and b.ORNO = c.OrderNum
    AND b.PONO = c.PositionNum
	and trim(b.item)=trim(c.itemcode) and t_sqnb=0
	group by c.WareHouse
)a where wms_order_status.cwar=a.WareHouse

-------- END SANAND

update wms_order_status set DOM_MTD=ROUND(VAL,2) FROM (	select sum(b.AMTH$1/1000000)as VAL,c.WareHouse from(select IDAT,[TRAN],IDOC From TCISLI305490) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	AND sotp not in  (SELECT DISTINCT saleordertype  fROM [ELGi_LN].DBO.saletype_master WHERE company =490 AND Sales_Category =1)
	AND (COFC BETWEEN '90000' AND '90091') AND COFC NOT IN ('90029','90073') and b.AMTH$1>0
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	inner JOIN ELGi_LN.dbo.Sales_Lines c
     ON b.COMPANY = c.Company
    and b.ORNO = c.OrderNum
    AND b.PONO = c.PositionNum
	and trim(b.item)=trim(c.itemcode) and t_sqnb=0
	group by c.WareHouse
)a where wms_order_status.cwar=a.WareHouse

update wms_order_status set RLY_MTD=ROUND(VAL,2) FROM (	select sum(b.AMTH$1/1000000)as VAL,c.WareHouse from(select IDAT,[TRAN],IDOC From TCISLI305490) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	AND sotp not in  (SELECT DISTINCT saleordertype  fROM [ELGi_LN].DBO.saletype_master WHERE company =490 AND Sales_Category =1)
	AND COFC IN ('90092')and b.AMTH$1>0
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	inner JOIN ELGi_LN.dbo.Sales_Lines c
     ON b.COMPANY = c.Company
    and b.ORNO = c.OrderNum
    AND b.PONO = c.PositionNum
	and trim(b.item)=trim(c.itemcode) and t_sqnb=0
	group by c.WareHouse
)a where wms_order_status.cwar=a.WareHouse

update wms_order_status set EXP_MTD=ROUND(VAL,2) FROM (	select sum(b.AMTH$1/1000000)as VAL,c.WareHouse from(select IDAT,[TRAN],IDOC From TCISLI305490) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	AND sotp not in  (SELECT DISTINCT saleordertype  fROM [ELGi_LN].DBO.saletype_master WHERE company =490 AND Sales_Category =1)
	AND (COFC NOT BETWEEN '90000' AND '90092' )and b.AMTH$1>0
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
			inner JOIN ELGi_LN.dbo.Sales_Lines c
     ON b.COMPANY = c.Company
    and b.ORNO = c.OrderNum
    AND b.PONO = c.PositionNum
	and trim(b.item)=trim(c.itemcode) and t_sqnb=0
	group by c.WareHouse
)a where wms_order_status.cwar=a.WareHouse



update wms_order_status set SUB_MTD=ROUND(VAL,2) FROM (	select sum(b.AMTH$1/1000000)as VAL,c.WareHouse from(select IDAT,[TRAN],IDOC From TCISLI305490) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	AND sotp not in  (SELECT DISTINCT saleordertype  fROM [ELGi_LN].DBO.saletype_master WHERE company =490 AND Sales_Category =1)
	AND (COFC like'7%' )and b.AMTH$1>0
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	inner JOIN ELGi_LN.dbo.Sales_Lines c
     ON b.COMPANY = c.Company
    and b.ORNO = c.OrderNum
    AND b.PONO = c.PositionNum
	and trim(b.item)=trim(c.itemcode) and t_sqnb=0
	group by c.WareHouse
)a where wms_order_status.cwar=a.WareHouse



update wms_order_status set DIREXP_MTD=ROUND(VAL,2) FROM (	select convert(decimal(19,2),sum(b.AMTH$1/1000000)) as VAL,c.WareHouse from(select IDAT,[TRAN],IDOC From TCISLI305490) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	AND sotp not in  (SELECT DISTINCT saleordertype  fROM [ELGi_LN].DBO.saletype_master WHERE company =490 AND Sales_Category =1)
	AND (COFC>'90094')and b.AMTH$1>0
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
			inner JOIN ELGi_LN.dbo.Sales_Lines c
     ON b.COMPANY = c.Company
    and b.ORNO = c.OrderNum
    AND b.PONO = c.PositionNum
	and trim(b.item)=trim(c.itemcode) and t_sqnb=0
	group by c.WareHouse
)a where wms_order_status.cwar=a.WareHouse



update wms_order_status set DOM_FTD=ROUND(VAL,2) FROM (	select sum(b.AMTH$1/1000000)as VAL,c.WareHouse from(select IDAT,[TRAN],IDOC From TCISLI305490) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC)) 
	AND sotp not in  (SELECT DISTINCT saleordertype  fROM [ELGi_LN].DBO.saletype_master WHERE company =490 AND Sales_Category =1)
		AND (COFC BETWEEN '90000' AND '90091') AND COFC NOT IN ('90029','90073')and b.AMTH$1>0
	and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE())
			inner JOIN ELGi_LN.dbo.Sales_Lines c
     ON b.COMPANY = c.Company
    and b.ORNO = c.OrderNum
    AND b.PONO = c.PositionNum
	and trim(b.item)=trim(c.itemcode) and t_sqnb=0
	group by c.WareHouse
)a where wms_order_status.cwar=a.WareHouse

update wms_order_status set RLY_FTD=ROUND(VAL,2) FROM (	select sum(b.AMTH$1/1000000)as VAL,c.WareHouse from(select IDAT,[TRAN],IDOC From TCISLI305490) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	AND sotp not in  (SELECT DISTINCT saleordertype  fROM [ELGi_LN].DBO.saletype_master WHERE company =490 AND Sales_Category =1)
		AND COFC IN ('90092')and b.AMTH$1>0
	and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE())
		inner JOIN ELGi_LN.dbo.Sales_Lines c
     ON b.COMPANY = c.Company
    and b.ORNO = c.OrderNum
    AND b.PONO = c.PositionNum
	and trim(b.item)=trim(c.itemcode) and t_sqnb=0
	group by c.WareHouse
)a where wms_order_status.cwar=a.WareHouse

update wms_order_status set EXP_FTD=ROUND(VAL,2) FROM (	select sum(b.AMTH$1/1000000)as VAL,c.WareHouse from(select IDAT,[TRAN],IDOC From TCISLI305490) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	AND sotp not in  (SELECT DISTINCT saleordertype  fROM [ELGi_LN].DBO.saletype_master WHERE company =490 AND Sales_Category =1)
	AND (COFC NOT BETWEEN '90000' AND '90092')and b.AMTH$1>0
	and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE())
		inner JOIN ELGi_LN.dbo.Sales_Lines c
     ON b.COMPANY = c.Company
    and b.ORNO = c.OrderNum
    AND b.PONO = c.PositionNum
	and trim(b.item)=trim(c.itemcode) and t_sqnb=0
	group by c.WareHouse
)a where wms_order_status.cwar=a.WareHouse


update wms_order_status set SUB_FTD=ROUND(VAL,2) FROM (	select sum(b.AMTH$1/1000000)as VAL,c.WareHouse from(select IDAT,[TRAN],IDOC From TCISLI305490) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	AND sotp not in  (SELECT DISTINCT saleordertype  fROM [ELGi_LN].DBO.saletype_master WHERE company =490 AND Sales_Category =1)
	AND (COFC like'7%')and b.AMTH$1>0
	and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE())
			inner JOIN ELGi_LN.dbo.Sales_Lines c
     ON b.COMPANY = c.Company
    and b.ORNO = c.OrderNum
    AND b.PONO = c.PositionNum
	and trim(b.item)=trim(c.itemcode) and t_sqnb=0
	group by c.WareHouse
)a where wms_order_status.cwar=a.WareHouse


update wms_order_status set DIREXP_FTD=ROUND(VAL,2) FROM (	select sum(b.AMTH$1/1000000)as VAL,c.WareHouse from(select IDAT,[TRAN],IDOC From TCISLI305490) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	AND sotp not in  (SELECT DISTINCT saleordertype  fROM [ELGi_LN].DBO.saletype_master WHERE company =490 AND Sales_Category =1)
	AND (COFC>'90094')and b.AMTH$1>0
	and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE())
			inner JOIN ELGi_LN.dbo.Sales_Lines c
     ON b.COMPANY = c.Company
    and b.ORNO = c.OrderNum
    AND b.PONO = c.PositionNum
	and trim(b.item)=trim(c.itemcode) and t_sqnb=0
	group by c.WareHouse
)a where wms_order_status.cwar=a.WareHouse



update wms_order_status set TBONO=tb.tnum FROM (select distinct concat(ltrim(rtrim(tpre)),'/',ltrim(rtrim(convert(decimal(19,0),tnum))))as Tnum,invn,ttyp From TZZSLS305490)tb
WHERE wms_order_status.Invno=concat(ltrim(rtrim(ttyp)),'/',ltrim(rtrim(invn)))


-------------------------------STEP 9 - UPDATING PACK COMPLETE DATE ---------------------------------------
--Modified by ravi

--Alter Table  wms_order_status Add Pack_Complete_date datetime
update wms_order_status set Pack_Complete_date = a.EDITDATE1 from (Select LISTNAME,Max(ADDDATE)'EDITDATE1' from wmwhse1_CODELKUP Group BY LISTNAME) a
Where wms_order_status.WMS_ORDERNO = a.LISTNAME
 
 --Modified by ravi



--update wms_order_status set value=MTD  FROM 
--(
--select ROUND(sum(value/1000000),2)as MTD FROM (
--select invdate,invoice,ORNO,PONO,sum(value) as Value    from (
--select distinct a.invdate,a.IDOC as invoice,b.ORNO,b.PONO,value From (select IDAT as invdate,[TRAN],IDOC From TCISLI305490) a
--inner join(select ORNO,PONO,[TRAN] as [TRAN]type,IDOC as invoice,sum(AMTH$1)as value  from TCISLI310490 group by ORNO,PONO,[TRAN],IDOC ) b
--on a.[TRAN]=b.[TRAN]type  
--and a.IDOC=b.invoice)a
--where invdate between dateadd(dd,-(select day(getdate()-1)),getdate()) and getdate()
--group by invdate,invoice,ORNO,PONO 
--)A)A

update wms_order_status set lddt=dateadd(MINUTE,30,dateadd(HH,5,lddt))
update wms_order_status set sdat=dateadd(MINUTE,30,dateadd(HH,5,sdat))
update wms_order_status set INv_date=dateadd(MINUTE,30,dateadd(HH,5,INv_date))
update wms_order_status set orderdate=dateadd(MINUTE,30,dateadd(HH,5,orderdate))


update wms_order_status set NoofLInes=a.cnt
from (select substring(EXTERNORDERKEY,5,20) as shipment,SALESORDERDOCUMENT,SALESORDERLINE,count(*) as cnt,SCHEMA_REFERENCE,
case when SCHEMA_REFERENCE='wmwhse1' then '102'
when SCHEMA_REFERENCE='wmwhse2' then '103' end cwar
 From wmwhse1_ORDERDETAIL 
group by substring(EXTERNORDERKEY,5,20),SALESORDERDOCUMENT,SALESORDERLINE,SCHEMA_REFERENCE
)a
where wms_order_status.SHPM=a.shipment
and wms_order_status.ORNO=a.SALESORDERDOCUMENT
and convert(float,wms_order_status.PONO)=a.SALESORDERLINE and wms_order_status.cwar=a.cwar

update wms_order_status set ITAD=a.ITAD FROM (SELECT COMPANY,ORNO,ITAD FROM TTDSLS400490)A
WHERE wms_order_status.ORNO=A.ORNO

update wms_order_status set SHIPADDRESS =address  FROM 
(select cadr,concat(LN01,', ',ln02,', ',ln03,', ',ln04,', ',LN05,', ',ln06) as address From [ELGi_LN].dbo.TTCCOM130400)A
WHERE wms_order_status.ITAD=A.CADR

-------------------------------STEP 10 - UPDATING REMARKS1 ---------------------------------------

UPDATE wms_order_status SET remarks1 = 'Part Shipped'
WHERE cwar = '103' AND stat_desc = 'Part Shipped' AND packstat_desc IN ('Shipped', 'Packed');

UPDATE wms_order_status SET remarks1 = 'Waiting to Ship'
WHERE cwar = '103' AND stat_desc = 'Loaded' AND packstat_desc = 'Loaded';

UPDATE wms_order_status SET remarks1 = 'In Loading'
WHERE cwar = '103' AND stat_desc = 'In Loading' AND packstat_desc IN ('Loaded', 'Packed');

UPDATE wms_order_status SET remarks1 = 'In Loading'
WHERE cwar = '103' AND stat_desc IN ('Staged','Part shipped') AND packstat_desc IN ('Loaded');

UPDATE wms_order_status SET remarks1 = 'Waiting to Load'
WHERE cwar = '103' AND stat_desc = 'Staged' AND packstat_desc = 'Packed'


	    UPDATE wms_order_status
SET Responsibility1 =
    CASE
        WHEN cwar = '103' AND (
               (stat_desc = 'Part Shipped' AND packstat_desc IN ('Shipped', 'Packed'))
            OR (stat_desc = 'Loaded' AND packstat_desc = 'Loaded')
            OR (stat_desc = 'In Loading' AND packstat_desc IN ('Loaded', 'Packed'))
            OR (stat_desc = 'Staged' AND packstat_desc IN ('Packed', 'Loaded'))
			OR (stat_desc = 'Part shipped' AND packstat_desc IN ('Loaded'))
        )
        THEN 'Commercial' ELSE NULL
		End
		WHERE cwar = '103'

-------------------------------STEP 11 - DELETING RECORDS ---------------------------------------

------------------------------------ due to not scanned vinod send a mail for this on Jul232019

delete  from wms_order_status where SHPM in (
'SHO088837','SHO101327','SHO103668','SHO098098','SHO102675','SHO106440','SHO091745','SHO099298','SHO104925','SHO080596','SHO093411','SHO091902','SHO093411','SHO089838','SHO090977','SHO093733',
'SHO095574','SHO103103','SHO098194','SHO099117','SHO101056','SHO099099','SHO113018','SHO089139','SHO068802','SHO106913','SHO106889','SHO088080','SHO106850','SHO098201','SHO104571','SHO107450',
'SHO103091','SHO101010','SHO109433','SHO105195','SHO166817','SHO365087','SHO365089','SHO418622','SHO429084','SHO335402','SHO302138','SHO427968','SHO247325','SHO292905','SHO292107',
'SHO275124','SHO294236','SHO447445','SHO446843','SHO446419','SHO446420','SHO446421','SHO446422','SHO447444','SHO263158','SHO324638','SHO393598','SHO323296','SHO323463'
,'SHO323908','SHO323908','SHO323915','SHO323749','SHO324034','SHO223725','SHO223725','SHO259404','SHO312309','SHO342231','SHO410638','SHO410942','SHO255522','SHO145516'
,'SHO405925','SHO310720','SHO311346','SHO278011','SHO406124')

delete from wms_order_status  where isnull(shipment_totalqty,0)<=0

delete  from wms_order_status where SHPM in (select distinct SHPM From [TWHINH480490] where PLST=3)

delete  from wms_order_status where SHPM in (select distinct SHPM From tzzsls342490)

delete from wms_order_status where SHPM in (select distinct SHPM from tzzsls604490)

delete from wms_order_status where cwar='103' and stat_desc='Shipped Complete' and packstat_desc='Shipped'

-----------------------------------------------END OF ORDER STATUS --------------------

insert into [wms_order_status1]

Select * from [wms_order_status] where packstat_desc is not null

end

GO

