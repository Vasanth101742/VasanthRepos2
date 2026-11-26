
CREATE PROC  [dbo].[sp_daydemand] AS

--7 AM,12 PM,4 PM,5PM
BEGIN 

--alter table daydemand add  PDNO nvarchar(50)
--alter table daydemand add TPL_Code nvarchar(150)
--alter table daydemand add Company nvarchar(5)
--alter table daydemand alter column  Req_Del_Date datetime
--alter table daydemand alter column  Act_Prod_Start_date datetime
--alter table daydemand add Completion_date date
--alter table daydemand add Tri_date date
--alter table daydemand add Lot_No int
--alter table daydemand add Prod_st_date datetime
--ALTER TABLE DAYDEMAND ADD TPL_Code_Desc nvarchar(50)
--ALTER TABLE DAYDEMAND ADD Model nvarchar(50)
--ALTER TABLE DAYDEMAND ADD Variant nvarchar(100)
--alter table daydemand add qrdr int


truncate table daydemand

INSERT INTO [dbo].[DayDemand] (company,pdno,tpl_code,[Child_Item],Req_Del_date,
Act_Prod_Start_date,Completion_date,
[Child_Item_Desc],[Supplier_code],[Buyer_code],
--[Due_Date],
[Pend_Qty],
--[Bin_Qty],
[BOM_Qty],
--tri_date,
lot_no,
Planned_del_date,Prod_st_date,variant,qrdr)

select distinct a.company,ltrim(rtrim(convert(nvarchar(50),b.pdno)))'Produc_order_no',ltrim(rtrim(a.mitm)) 'TPL_Code',b.Child_Item,a.RDLD 'Req_Del_date'
,a.apdt 'Act_Prod_Start_date',a.cmdt 'Completion_date',
d.T_DSCA 'Child_Item_Desc',
e.OTBP 'Supplier_CODE',
e.BUYR 'Buyer_CODE',
--f.Due_Date,
f.Pending_qty
--,f.Bin_Qty
,b.BOM_Qty 
--,f.Trigger_date
,f.lot_no,a.PLDT 'Planned del date',a.PRDT 'Production start date',f.VARI 'Variant',sum(a.qrdr) 'qrdr'

from TTISFC001ALL a

right join  (select distinct company,CONVERT(NVARCHAR(50),pdno)'pdno',ltrim(rtrim(item)) 'Child_Item',sum(qoro) 'BOM_Qty' from  TTIMFC001ALL where ITTP=2  --ITTP=2 means Manufacturing Item only we need to consider
group by CONVERT(NVARCHAR(50),pdno),ltrim(rtrim(item)),COMPANY) b on a.pdno=b.pdno and a.COMPANY=b.COMPANY

left join TTCIBD001400 d on b.Child_Item= LTRIM(RTRIM(d.t_item))

left join TTDIPU001ALL e on b.Child_Item=ltrim(rtrim(e.ITEM)) 
and a.company=e.COMPANY

left join (select company,item,min(duedate) 'Due_Date',sum(pendingqty) 'Pending_qty'
--,min(binqty) 'Bin_Qty'
,min(Tri_Dt) 'Trigger_date',min(lot_no) 'lot_no',VARI from ELGi_OverDue_Triggers
--WHERE ITEM LIKE '%A970008%'
group by company,item,VARI) f on Child_Item= LTRIM(RTRIM(f.ITEM)) and a.company=f.company

where a.company in ('401','450','470') and  a.osta in (1,3) and convert(date,a.rdld)>='20250401'

group by  a.company,ltrim(rtrim(b.pdno)),ltrim(rtrim(a.mitm)),b.Child_Item,a.RDLD,a.apdt,a.cmdt,d.T_DSCA,e.OTBP,e.BUYR,f.Pending_qty,b.BOM_Qty
,f.lot_no,a.PLDT,a.PRDT,f.VARI

----------------------------------------------Updating starts-----------------
--alter table daydemand add sub_division nvarchar(50)
--alter table daydemand add sub_division_sorting int

----------------STEP 1 - BIN QTY and lean type FROM zzpur5555m019 - TZZPUR049----------------

update DayDemand set Bin_Qty =0

--- Lean Triggers

update DayDemand set Bin_Qty = a.binqty, Lean_Type=a.Leantype, rpl=a.rpl from 
(select company,ltrim(rtrim(item)) 'Item',buyr,suno1, sum(cast  (sqty as float)) 'binqty' , min(rplt) 'RPL',
CASE WHEN SOPS=1 THEN 'Two Bin'
	when sops=2 then 'Multi Bin'
	when sops=3 then 'Milk run'
	when sops=4 then 'MR-Motors'
	when sops=5 then 'Forward Cover'
	when SOPS=6 then 'Single Bin'
	when SOPS=7 then 'Fixed Stock'
	when SOPS=8 then 'Reorder Point'
 end 'Leantype'
from TZZPUR049ALL group by company,ltrim(rtrim(item)),buyr,suno1,SOPS) a
where DayDemand.Child_Item=a.item and DayDemand.Company=a.COMPANY and DayDemand.Buyer_code=a.BUYR and DayDemand.Supplier_code=a.SUNO1



-----------------Non Lean 

update DayDemand set Lean_Type=a.Leantype from (
select company,ltrim(rtrim(item)) 'Item',buyr,BPID,'Non lean' as Leantype
from TZZPUR302ALL ) a
where DayDemand.Child_Item=a.item and DayDemand.Company=a.COMPANY and DayDemand.Buyer_code=a.BUYR 
and DayDemand.Supplier_code=a.BPID and DayDemand.Lean_Type is null




update daydemand set lean_type='NVC' where DayDemand.lean_type='NON LEAN'
update daydemand set lean_type='MR' where DayDemand.lean_type='Milk run'
update daydemand set lean_type='MRM' where DayDemand.lean_type='MR-Motors'
update daydemand set lean_type='MB' where DayDemand.lean_type='Multi Bin'
update daydemand set lean_type='TB' where DayDemand.lean_type='Two Bin'

----------------STEP 2 - Item description----------------

update DayDemand set TPL_Code_Desc =a.t_dsca from (
select distinct Ltrim(rtrim(t_item)) 'Item', t_dsca from TTCIBD001400 
)a where DayDemand.TPL_Code=a.Item

update DayDemand set Model =a.model from (
select * from (
select DISTINCT *,ROW_NUMBER() OVER(PARTITION BY TPL ORDER BY MODEL ASC) 'Rn' from DayDemand_Model  
)a where rn=1
)a where DayDemand.TPL_Code=a.tpl

--Since the logic is changed as due date,tri date and due slab should be assigned to the same lotno that we take 
--updating duedate,trigger date,dueslab

--alter table daydemand add RPL int 

----------------STEP 3 - RPL,duedate,tri_Date,dueslab,Red Flag from Elgi overdue triggers----------------

-- Changed to LN session directly from April-09, 2026

--update DayDemand set rpl=a.rpl from 
--(select company,ltrim(rtrim(item)) 'Item',min(rplt) 'RPL',SupplierNum from ELGi_OverDue_Triggers
--group by company,item,suppliernum)a
--where DayDemand.child_item=a.ITEM and DayDemand.supplier_code=a.SupplierNum and a.company=DayDemand.Company
--Alter table daydemand add RedFlag nvarchar(50)

update daydemand set due_date=a.duedate, tri_date=a.tri_dt,dueslab=a.dueslab,redflag=a.redflag  from 

(
select distinct company,ltrim(rtrim(item)) 'Item',nama,BUYR,lot_no,duedate,tri_dt,dueslab,redflag 
from ELGi_OverDue_Triggers
--where company='401'

) a
where daydemand.child_item=a.item and daydemand.Lot_No=a.lot_no and a.company=DayDemand.Company


--alter table daydemand add AQTY FLOAT

----------------STEP 4 - Due month from tzzpur302----------------


update DayDemand set due_month=a.dm from (
select COMPANY,
case when MNTH=1 then 'Jan'
     when MNTH=2 then 'Feb'
     when MNTH=3 then 'Mar'
     when MNTH=4 then 'Apr'
	 when MNTH=5 then 'May'
	 when MNTH=6 then 'Jun'
     when MNTH=7 then 'Jul'
     when MNTH=8 then 'Aug'
     when MNTH=9 then 'Sept'
     when MNTH=10 then 'Oct'
     when MNTH=11 then 'Nov'
     when MNTH=12 then 'Dec'
	 end 'DM',LOTN,ORNO,ITEM
	 --,sum(convert(float,AQTY)) 'AQTY' 
	 from TZZPUR302ALL
where company in ('401','450','470')
and stat<>'C'

--group by company,LOTN,ORNO,ITEM,MNTH

)a where DayDemand.Company=a.company and 
DayDemand.Child_Item=LTRIM(RTRIM(a.ITEM)) and 
DayDemand.Lean_Type='NVC' and 
DayDemand.Lot_No=a.LOTN


----------------STEP 5 - Supplier name----------------


Update daydemand set Supplier_Name=v.custname1
from vw_Business_Partner v
where ltrim(rtrim(daydemand.supplier_code))=ltrim(rtrim(v.custcode))

----------------STEP 6 - Buyer name----------------

update daydemand set Buyer_name=a.NAMA
from (select * from TTCCOM001ALL where company=400)a
where daydemand.buyer_code=a.EMNO 

----------------STEP 7 - Stock, Actstock, Block stock----------------

update daydemand set stock= a.Act_Stock_Qty,Block_Stock_Qty=a.Block_Qty from (
select distinct company,ltrim(rtrim(item)) 'Item_Code',sum(qhnd) 'Stock_Qty',sum(qblk) 'Block_Qty',sum(qhnd)-sum(qblk) 'Act_Stock_Qty' from [dbo].[TWHWMD215ALL]
where cwar in ('U53','209','210','212','253','353','453','553','V53','O53','246','V57') and COMPANY=401
group by ltrim(rtrim(item)),COMPANY
)a
where daydemand.child_item= ltrim(rtrim(a.Item_Code)) and DayDemand.Company=a.company

update daydemand set stock= a.Act_Stock_Qty,Block_Stock_Qty=a.Block_Qty from (
select distinct company,ltrim(rtrim(item)) 'Item_Code',sum(qhnd) 'Stock_Qty',sum(qblk) 'Block_Qty',sum(qhnd)-sum(qblk) 'Act_Stock_Qty' from [dbo].[TWHWMD215ALL]
where cwar in ('251') and COMPANY=450
group by ltrim(rtrim(item)),COMPANY
)a
where daydemand.child_item= ltrim(rtrim(a.Item_Code)) and DayDemand.Company=a.COMPANY

--470 Stock
update daydemand set stock= a.Act_Stock_Qty,Block_Stock_Qty=a.Block_Qty from (
select distinct company,ltrim(rtrim(item)) 'Item_Code',sum(qhnd) 'Stock_Qty',sum(qblk) 'Block_Qty',sum(qhnd)-sum(qblk) 'Act_Stock_Qty'
from [dbo].[TWHWMD215ALL]
where cwar in ('P53') and COMPANY=470
group by ltrim(rtrim(item)),COMPANY
)a
where daydemand.child_item= ltrim(rtrim(a.Item_Code)) and DayDemand.Company=a.COMPANY

----------------STEP 8 - Current Month demand----------------


update daydemand set [Curr_Month_Demand] = a.Curr_Month_Demand_child_item from 

(select a.company,a.pdno,ltrim(rtrim(mitm)) 'TPL_Code',sum(qrdr) 'Curr_Month_Demand_TPL',
ltrim(rtrim(b.Child_Item)) 'Child_Item',
sum(bom_qty) 'Curr_Month_Demand_child_item' 
from TTISFC001all a
right join  (select distinct pdno,ltrim(rtrim(item)) 'Child_Item',sum(qoro) 'BOM_Qty' from 
TTIMFC001ALL where ITTP=2 
group by pdno,ltrim(rtrim(item))) b on a.pdno=b.pdno

where convert(date,RDLD ) between DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0) and eomonth(getdate()) and a.COMPANY in ('401','450')
group by a.pdno,ltrim(rtrim(mitm)),Child_Item,COMPANY

) a where daydemand.child_item=a.Child_Item
and daydemand.pdno=ltrim(rtrim(a.PDNO)) and DayDemand.Company=a.COMPANY


----------------STEP 9 - Day demand----------------


update daydemand set day_Demand = a.Day_Demand_child_item from 

(select a.pdno,ltrim(rtrim(mitm)) 'TPL_Code',sum(qrdr) 'Day_Demand_TPL',ltrim(rtrim(b.Child_Item)) 'Child_Item',
sum(bom_qty) 'Day_Demand_child_item' ,a.COMPANY
from TTISFC001all a
right join  (select distinct company,pdno,ltrim(rtrim(item)) 'Child_Item',sum(qoro) 'BOM_Qty' from  TTIMFC001ALL where ITTP=2 
group by pdno,ltrim(rtrim(item)),COMPANY) b on a.pdno=b.pdno

where convert(date,RDLD ) =convert(date,getdate()) and a.COMPANY in ('401','450')
group by a.pdno,ltrim(rtrim(mitm)),Child_Item,a.COMPANY

) a where daydemand.child_item=a.Child_Item
and daydemand.pdno=ltrim(rtrim(a.PDNO)) and a.company=DayDemand.Company

----------------STEP 10 - DEM Qty----------------

update DayDemand set DEM=a.DEM_Qty from (
select tpl_code,sum(dem_qty) 'DEM_Qty' from DayDemand_DEM
group by TPL_Code
)a where daydemand.Child_Item =a.TPL_Code

--update daydemand set [Day_Demand_Shortage]=stock-day_demand

--update daydemand set [Sum_of_Coverage] =day_demand where [Day_Demand_Shortage]>0

--update  daydemand set [Sum_of_Coverage] =stock where [Day_Demand_Shortage]<0

--update DayDemand set DEM_Shortage = Stock-DEM

--alter table daydemand add Description nvarchar(55)
--alter table daydemand add Division nvarchar(55)

----------------STEP 11 - Division/ Description----------------


update DayDemand set Description=b.Description,Division=b.Division
from (
select distinct a.company,Description,prd_from,prd_to,Division from ELGi_Production_Master a
left outer join ELGi_AssemblyLine_Master b
on b.code = a.assemblycode
)b
where DayDemand.PDNO between b.prd_from  and b.prd_to
and DayDemand.company = b.company and b.company in ('401','450','470')


update DayDemand set sub_division=a.[Sub-division],sub_division_sorting=a.[Sub-division_Sorting]  from (

select pdno,
case 
     when pdno like '%Y%' then 'Tier4Porject'
     WHEN COMPANY='470' AND PDNO LIKE 'PRO%'  then 'PVD'
	 when Description like 'Vacuum' then 'VACUUM'
	 WHEN Description LIKE 'REWORKORDERS' THEN 'REWORK ORDERS'
	 when Description like 'Wiper' then 'RLYS-WIPER'
	 when Description like 'Sepsac' then 'SEPSAC'
	 when Description like 'Dpsac' then 'DPSAC'
	 when Description like 'Lepsac' then 'LEPSAC'
	 when Description like 'Ofsac' then 'OFSAC'	
	 when PDNO between 510000000 and 519999999 then 'RLYS-SPARES'
	 WHEN Description LIKE 'RAILWAYS' THEN 'RLYS-UNIT ASSY'
	 when PDNO between 520000000 and 529999999 then 'RLYS-SIEMENS'
 	 when Description like 'Dryers' then 'DRYERS'
	 when PDNO between 300000000 and 319999999 then 'RCD UNIT ASSY'	
	 when PDNO between 400000000 and 499999999  then 'RCD-ENGC'
	 when PDNO between 320000000 and 329999999 then 'OE ASSY' 
	 When PDNO between 340000000 and 349999999 then 'RCD BOREWELL' 
	 when Description like 'Accessories' then 'ACCESSORIES'
	 when Description like 'Kit  Accessories' then 'ROCD-VALVES'
	 when Description like 'RCD Spares' then 'RCD-SPARES'
	 when company='450' and PDNO between 815000000 and 815999999 then 'AIR END'
	 when COMPANY='450' and PDNO between 823000000 and 823999999 then 'CASTING SHOP'
	 when COMPANY='450' and PDNO between 831000000 and 831999999 then 'ROTOR SHOP'
	 when COMPANY='450' and PDNO between 863000000 and 863999999 then 'RCD MC SHOP'
	 when COMPANY='450' and PDNO between 892000000 and 892999999 then 'RCD /HV TOP BLOCK'
	 when COMPANY='450' and PDNO between 901000000 and 901999999 then 'GSC SPARES'
	 when COMPANY='450' and PDNO between 931000000 and 931999999 then 'ENGC TOP BLOCK'
	 WHEN COMPANY='450' AND PDNO between 991000000 and 991999999 then 'ACP REWORK ORDER'
	 WHEN COMPANY='450' AND PDNO between 981000000 and 981999999 then 'STANDARD WIP'
     else 'Others'
	 end 'Sub-division',
case 
     when pdno like '%Y%' then 29

     WHEN COMPANY='470' AND PDNO LIKE 'PRO%'  then 28
	 when Description like 'Vacuum' then 13
	 WHEN Description LIKE 'REWORK ORDERS' THEN 18
	 when Description like 'Wiper' then 14
	 when Description like 'Sepsac' then 1
	 when Description like 'Dpsac' then 2
	 when Description like 'Lepsac' then 3
	 when Description like 'Ofsac' then 4	
	 when PDNO between 510000000 and 519999999 then 16
	 WHEN Description LIKE 'RAILWAYS' THEN 5
	 when PDNO between 520000000 and 529999999 then 7
 	 when Description like 'Dryers' then 6
	 when PDNO between 300000000 and 319999999 then 8
	 when PDNO between 400000000 and 499999999  then 9
	 when PDNO between 320000000 and 329999999 then 10
	 When PDNO between 340000000 and 349999999 then 11
	 when Description like 'Accessories' then 12
	 when Description like 'Kit  Accessories' then 15
	 when Description like 'RCD Spares' then 17
	 when company='450' and PDNO between 815000000 and 815999999 then 19
	 when COMPANY='450' and PDNO between 823000000 and 823999999 then 23
	 when COMPANY='450' and PDNO between 831000000 and 831999999 then 24
	 when COMPANY='450' and PDNO between 863000000 and 863999999 then 25
	 when COMPANY='450' and PDNO between 892000000 and 892999999 then 20
	 when COMPANY='450' and PDNO between 901000000 and 901999999 then 22
	 when COMPANY='450' and PDNO between 931000000 and 931999999 then 21
	 WHEN COMPANY='450' AND PDNO between 991000000 and 991999999 then 26
	 WHEN COMPANY='450' AND PDNO between 981000000 and 981999999 then 27
	 else 30
	 end 'Sub-division_Sorting'

	 from DayDemand
	 
)a  where DayDemand.PDNO=a.PDNO



----------------STEP 12 - Order status----------------

--alter table DayDemand add Order_status nvarchar(55)

update daydemand set Order_status= a.Order_status from (
select pdno,case when osta=1 then 'Planned'
 when osta=3 then 'Document Printed' end 'Order_status'
 from TTISFC001ALL where company in ('401','450','470') and  osta in (1,3)
)a where DayDemand.PDNO=a.PDNO

----------------STEP 13 - Lean stock out----------------

--alter table daydemand add Lean_Stock_Out nvarchar(50)

update DayDemand set lean_stock_out = a.Lean_stock_out from (
select distinct ITEM,LOT_NO,SUPP,buyr,Trig_Dt ,'Lean_Stock_Out' 'Lean_stock_out' from Lean_Stock_Out
) a where a.LOT_NO=DayDemand.lot_no

--alter table daydemand add dueslab nvarchar(50)
--update DayDemand set dueslab = a.DueSlab from (
--select distinct LTRIM(RTRIM(item)) 'Item',min(duedate) 'Due_Date',min(LOT_NO) 'Lot_No',DueSlab from ELGi_OverDue_Triggers
--group by item,lot_no,DueSlab
--) a where a.Due_Date=DayDemand.Due_Date AND DayDemand.Child_Item=a.Item

--alter table daydemand add ASN_Number int

----------------STEP 14 - ASN Number ----------------

update DayDemand set ASN_Number = a.ASNO from (
select company,suno,item,lotn,max(asno) 'asno' from TZZPUR926ALL
--where company=401
group by company,suno,item,lotn

) a where a.LOTN=DayDemand.lot_no and DayDemand.Child_Item=ltrim(rtrim(a.item)) 
and DayDemand.Company=a.COMPANY

--alter table daydemand add Month_Consump float

----------------STEP 15 - Maximum Consumption ----------------



--Takes much time here 
update DayDemand set MaxConsump= a.maxqty from 

(select item,sum(maxqty) 'Maxqty',company from vw_gr_import_parts
group by item,COMPANY) a where DayDemand.Child_Item=a.item and a.COMPANY=DayDemand.Company

----------------STEP 16 - Month Consumption ----------------


update DayDemand set month_Consump=a.consump from 
(select company,ltrim(rtrim(itemcode)) 'Item',ItemDescr,BuyrCode
,BuyrName,SuppCode,SuppName,sum(production_consumption)+sum(Sales_Consumption) 'Consump'
from Consumption
where CalMonth=month(getdate()) and CalYear=YEAR(GETDATE())

group by company,ltrim(rtrim(itemcode)),ItemDescr,BuyrCode,BuyrName,SuppCode,SuppName
)a where DayDemand.Child_Item=a.Item and a.COMPANY=DayDemand.Company


----------------STEP 17 - CBR Calculation ----------------


------------------------METHOD-1 : OVERALL ALLOCATION-FIFO-------------------------------
--alter table DayDemand add [SNo] int

update DayDemand set SNo=a.SINo from (
select company,pdno,TPL_Code,child_item,Req_Del_Date,
ROW_NUMBER() over (partition by company,child_item order by company,req_del_date,pdno asc) 'SINo' 
from DayDemand 

)a where a.PDNO=DayDemand.pdno and DayDemand.TPL_Code=a.TPL_Code
and DayDemand.Child_Item=a.Child_Item and daydemand.company=a.Company



--alter table daydemand add CBR nvarchar(10)
--alter table daydemand alter column Stock_Status nvarchar(100)

update DayDemand set stock_status=a.stock_status from (

select distinct Company,pdno,TPL_Code,child_item,Child_Item_Desc,Req_Del_Date, BOM_Qty,Stock,SNo,
sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno rows between unbounded preceding and current row) 'Running_BOM_Qty',
case 
 when Child_Item_Desc like '%Manual%' then 'Stock_available'
  when Child_Item_Desc like '%Balancing%' then 'Stock_available'
when sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno rows between unbounded preceding and current row) <= stock then 'Stock_available'
else 'No stock' end 'Stock_Status'
from DayDemand 
)a where DayDemand.PDNO=a.PDNO and DayDemand.TPL_Code=a.TPL_Code and DayDemand.Child_Item=a.Child_Item 
and DayDemand.Company=a.Company



update DayDemand set CBR= a.cbr from (
select company,pdno, CASE 
        WHEN MIN(CASE WHEN Stock_Status = 'Stock_available' THEN 1 ELSE 0 END) = 1
        THEN 'YES'
        ELSE 'NO'
    END AS CBR
from ( 
select distinct company,pdno,TPL_Code,child_item,Child_Item_Desc,Req_Del_Date, BOM_Qty,Stock,SNo,
sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno rows between unbounded preceding and current row) 'Running_BOM_Qty',
case 
 when Child_Item_Desc like '%Manual%' then 'Stock_available'
  when Child_Item_Desc like '%Balancing%' then 'Stock_available'
when sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno rows between unbounded preceding and current row) <= stock then 'Stock_available'
else 'No stock' end 'Stock_Status'
from DayDemand 

)a
--where convert(date,Req_Del_Date)=convert(date,getdate()) 
--and
--where pdno='500018464'
group by pdno,Company
)a where DayDemand.PDNO=a.PDNO and DayDemand.company=a.Company


update DayDemand set [status]= 'Can be Released' where DayDemand.cbr='Yes'
update DayDemand set [status]='Shortage' where DayDemand.cbr='No'




------------------------METHOD-2 : ALLOCATED FOR N,N+1-------------------------------

--ALTER TABLE DayDemand ADD stock_status_T NVARCHAR(50)
--ALTER TABLE DayDemand ADD SNO_T INT

--update DayDemand set SNo_T=a.SINo from (
--select pdno,TPL_Code,child_item,Req_Del_Date,ROW_NUMBER() over (partition by child_item order by req_del_date,pdno asc) 'SINo' 
--from DayDemand 
--WHERE CONVERT(DATE,Req_Del_Date) BETWEEN CONVERT(DATE,GETDATE()) AND CONVERT(DATE,GETDATE()+1)
----ORDER BY Req_Del_Date
--)a where a.PDNO=DayDemand.pdno and DayDemand.TPL_Code=a.TPL_Code and DayDemand.Child_Item=a.Child_Item


--update DayDemand set stock_status_T=a.stock_status from (

--select distinct pdno,TPL_Code,child_item,Child_Item_Desc,Req_Del_Date, BOM_Qty,Stock,SNo_T,
--sum(BOM_Qty) over (partition by child_item order by child_item,sno_T rows between unbounded preceding and current row) 'Running_BOM_Qty',
--case 
-- when Child_Item_Desc like '%Manual%' then 'Stock_available'
--  when Child_Item_Desc like '%Balancing%' then 'Stock_available'
--when sum(BOM_Qty) over (partition by child_item order by child_item,sno_T rows between unbounded preceding and current row) <= stock then 'Stock_available'
--else 'No stock' end 'Stock_Status'
--from DayDemand 
--WHERE CONVERT(DATE,Req_Del_Date) BETWEEN CONVERT(DATE,GETDATE()) AND CONVERT(DATE,GETDATE()+1)
----ORDER BY Req_Del_DatE,

--)a where DayDemand.PDNO=a.PDNO and DayDemand.TPL_Code=a.TPL_Code and DayDemand.Child_Item=a.Child_Item

----ALTER TABLE DayDemand ADD CBR_T NVARCHAR(50)

--update DayDemand set CBR_T= a.cbr from (
--select pdno, CASE 
--        WHEN MIN(CASE WHEN stock_status_T = 'Stock_available' THEN 1 ELSE 0 END) = 1
--        THEN 'YES'
--        ELSE 'NO'
--    END AS CBR
--from ( 
--select distinct pdno,TPL_Code,child_item,Child_Item_Desc,Req_Del_Date, BOM_Qty,Stock,SNo_T,
--sum(BOM_Qty) over (partition by child_item order by child_item,sno_T rows between unbounded preceding and current row) 'Running_BOM_Qty',
--case 
-- when Child_Item_Desc like '%Manual%' then 'Stock_available'
--  when Child_Item_Desc like '%Balancing%' then 'Stock_available'
--when sum(BOM_Qty) over (partition by child_item order by child_item,sno_T rows between unbounded preceding and current row) <= stock then 'Stock_available'
--else 'No stock' end 'Stock_Status_t'
--from DayDemand 
--WHERE  CONVERT(DATE,Req_Del_Date) BETWEEN CONVERT(DATE,GETDATE()) AND CONVERT(DATE,GETDATE()+1)


--)a
----where convert(date,Req_Del_Date)=convert(date,getdate()) 
----and
----where pdno='500018464'

--group by pdno

--)a where DayDemand.PDNO=a.PDNO


----ALTER TABLE DAYDEMAND ADD STATUS_T NVARCHAR(50)

--update DayDemand set [status_T]= 'Can be Released' where DayDemand.cbr_T='Yes'
--update DayDemand set [status_T]='Shortage' where DayDemand.cbr_T='No'


--lOGIC ADDED ON 18/12/2025

------------------------METHOD-3 : DEPARTMENT WISE ALLOCATED TO N-1,N,N+1-------------------------------

--ALTER TABLE DayDemand ADD SNO_D INT 
--ALTER TABLE DAYDEMAND ADD stock_status_D NVARCHAR(50)
--ALTER TABLE DAYDEMAND ADD CBR_D NVARCHAR(50)
--ALTER TABLE DAYDEMAND ADD status_D NVARCHAR(50)



update DayDemand set SNo_D=a.SINo from (

select pdno,TPL_Code,child_item,Req_Del_Date,SUB_DIVISION,company,
ROW_NUMBER() over (partition by company,child_item order by company,SUB_DIVISION_SORTING,SUB_DIVISION,req_del_date,pdno asc) 'SINo' 
from DayDemand 
WHERE CONVERT(DATE,Req_Del_Date) BETWEEN CONVERT(DATE,GETDATE()-1) AND CONVERT(DATE,GETDATE()+1)
)a where a.PDNO=DayDemand.pdno and DayDemand.TPL_Code=a.TPL_Code and DayDemand.Child_Item=a.Child_Item 
and a.company=DayDemand.Company

--alter table daydemand add CBR nvarchar(10)
--alter table daydemand alter column Stock_Status nvarchar(100)
update DayDemand set stock_status_D=a.stock_status from (

select distinct company,pdno,TPL_Code,child_item,Child_Item_Desc,Req_Del_Date, BOM_Qty,Stock,SNo_D,
sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno_D rows between unbounded preceding and current row) 'Running_BOM_Qty',
case 
 when Child_Item_Desc like '%Manual%' then 'Stock_available'
  when Child_Item_Desc like '%Balancing%' then 'Stock_available'
when sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno_D rows between unbounded preceding and current row) <= stock then 'Stock_available'
else 'No stock' end 'Stock_Status'
from DayDemand 
WHERE CONVERT(DATE,Req_Del_Date) BETWEEN CONVERT(DATE,GETDATE()-1) AND CONVERT(DATE,GETDATE()+1)
)a where DayDemand.PDNO=a.PDNO and DayDemand.TPL_Code=a.TPL_Code and DayDemand.Child_Item=a.Child_Item
and DayDemand.company=a.Company



update DayDemand set CBR_D= a.cbr from (
select company,pdno, CASE 
        WHEN MIN(CASE WHEN Stock_Status = 'Stock_available' THEN 1 ELSE 0 END) = 1
        THEN 'YES'
        ELSE 'NO'
    END AS CBR
from ( 
select distinct pdno,TPL_Code,child_item,Child_Item_Desc,Req_Del_Date, BOM_Qty,Stock,SNo_D,company,
sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno_D rows between unbounded preceding and current row) 'Running_BOM_Qty',
case 
 when Child_Item_Desc like '%Manual%' then 'Stock_available'
  when Child_Item_Desc like '%Balancing%' then 'Stock_available'
when sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno_D rows between unbounded preceding and current row) <= stock then 'Stock_available'
else 'No stock' end 'Stock_Status'
from DayDemand 
WHERE CONVERT(DATE,Req_Del_Date) BETWEEN CONVERT(DATE,GETDATE()-1) AND CONVERT(DATE,GETDATE()+1)
)a
--where convert(date,Req_Del_Date)=convert(date,getdate()) 
--and
--where pdno='500018464'
group by pdno,company
)a where DayDemand.PDNO=a.PDNO and DayDemand.Company=a.Company


update DayDemand set [status_D]= 'Can be Released' where DayDemand.cbr_d='Yes'
update DayDemand set [status_D]='Shortage' where DayDemand.cbr_d='No'



--lOGIC ADDED ON 28/01/2026

------------------------METHOD-4 : DEPARTMENT WISE ALLOCATED TO N-1,N,N+1 AND Reallocated to items with less number of shortage-------------------------------

--ALTER TABLE DayDemand ADD SNO_4 INT 
--ALTER TABLE DAYDEMAND ADD stock_status_4 NVARCHAR(50)
--ALTER TABLE DAYDEMAND ADD CBR_4 NVARCHAR(50)
--ALTER TABLE DAYDEMAND ADD status_4 NVARCHAR(50)



--update DayDemand set SNo_4=a.SINo from (

--select pdno,TPL_Code,child_item,Req_Del_Date,SUB_DIVISION,
--ROW_NUMBER() over (partition by child_item order by SUB_DIVISION_SORTING,SUB_DIVISION,req_del_date,pdno asc) 'SINo' 
--from DayDemand 
--WHERE CONVERT(DATE,Req_Del_Date) BETWEEN CONVERT(DATE,GETDATE()-1) AND CONVERT(DATE,GETDATE()+1)
--)a where a.PDNO=DayDemand.pdno and DayDemand.TPL_Code=a.TPL_Code and DayDemand.Child_Item=a.Child_Item 


--update DayDemand set stock_status_4=a.stock_status from (

--select distinct pdno,TPL_Code,child_item,Child_Item_Desc,Req_Del_Date, BOM_Qty,Stock,SNo_4,
--sum(BOM_Qty) over (partition by child_item order by child_item,sno_4 rows between unbounded preceding and current row) 'Running_BOM_Qty',
--case 
-- when Child_Item_Desc like '%Manual%' then 'Stock_available'
--  when Child_Item_Desc like '%Balancing%' then 'Stock_available'
--when sum(BOM_Qty) over (partition by child_item order by child_item,sno_4 rows between unbounded preceding and current row) <= stock then 'Stock_available'
--else 'No stock' end 'Stock_Status'
--from DayDemand 
--WHERE CONVERT(DATE,Req_Del_Date) BETWEEN CONVERT(DATE,GETDATE()-1) AND CONVERT(DATE,GETDATE()+1)
--)a where DayDemand.PDNO=a.PDNO and DayDemand.TPL_Code=a.TPL_Code and DayDemand.Child_Item=a.Child_Item


--update DayDemand set CBR_4= a.cbr from (
--select pdno, CASE 
--        WHEN MIN(CASE WHEN Stock_Status = 'Stock_available' THEN 1 ELSE 0 END) = 1
--        THEN 'YES'
--        ELSE 'NO'
--    END AS CBR
--from ( 
--select distinct pdno,TPL_Code,child_item,Child_Item_Desc,Req_Del_Date, BOM_Qty,Stock,SNo_4,
--sum(BOM_Qty) over (partition by child_item order by child_item,sno_4 rows between unbounded preceding and current row) 'Running_BOM_Qty',
--case 
-- when Child_Item_Desc like '%Manual%' then 'Stock_available'
--  when Child_Item_Desc like '%Balancing%' then 'Stock_available'
--when sum(BOM_Qty) over (partition by child_item order by child_item,sno_D rows between unbounded preceding and current row) <= stock then 'Stock_available'
--else 'No stock' end 'Stock_Status'
--from DayDemand 
--WHERE CONVERT(DATE,Req_Del_Date) BETWEEN CONVERT(DATE,GETDATE()-1) AND CONVERT(DATE,GETDATE()+1)
--)a
----where convert(date,Req_Del_Date)=convert(date,getdate()) 
----and
----where pdno='500018464'
--group by pdno
--)a where DayDemand.PDNO=a.PDNO


update DayDemand set cbr_4=CBR_D
update DayDemand set [status_4]= 'Can be Released' where DayDemand.cbr_4='Yes'
update DayDemand set [status_4]='Shortage' where DayDemand.cbr_4='No'


--------------Method -4 : Part -2 --> Reallocating stock to balance cbr='No' Dptwise,N-1,N,N+1------- 
--alter table daydemand_temp_M4 add Child_Item_Desc nvarchar(250)
--alter table daydemand_temp_M4 add Company nvarchar(50)
Truncate table daydemand_temp_M4

insert into daydemand_temp_M4 (sub_division,sub_division_sorting ,pdno,tpl_code,child_item,child_item_desc,Req_del_date ,bom_qty,company)
select sub_division,sub_division_sorting ,pdno,tpl_code,child_item,Child_Item_Desc,Req_del_date ,sum(bom_qty) 'BOM_Qty',company from DayDemand 

where cbr_4='No' 
group by sub_division,sub_division_sorting,PDNO,TPL_Code,Child_Item,Req_Del_Date,Child_Item_Desc,company
order by sub_division_sorting,pdno,TPL_Code 

update daydemand_temp_M4 set stock=isnull(a.balance_stock,0) from 
(select company,Child_Item,sum(BOM_Qty) 'BOM_Qty',max(Stock) 'Stock_Qty',isnull(max(stock)-sum(bom_qty),0) 'Balance_stock' 
from DayDemand
where cbr_4='yes' 
group by company,Child_Item

)a where a.Child_Item=daydemand_temp_M4.child_item and a.Company=daydemand_temp_M4.company


--alter table daydemand_temp_M4 add Shortage_Items_Count int
update daydemand_temp_M4 set Shortage_Items_Count=a.Shortage_Items_Count from (
select company,pdno,tpl_code,count(stock_status_D) 'Shortage_Items_Count'
from DayDemand 
where cbr_4='No'  and stock_status_D='No stock'
group by PDNO,TPL_Code, Company 
--order by count(stock_status_4),PDNO
)a where daydemand_temp_M4.pdno=a.PDNO and daydemand_temp_M4.tpl_code=a.TPL_Code and a.Company=daydemand_temp_M4.company


update daydemand_temp_M4 set stock=0 where stock is null

--ALTER TABLE daydemand_temp_M4 ADD SNO INT 
--ALTER TABLE daydemand_temp_M4 ADD stock_status NVARCHAR(50)
--ALTER TABLE daydemand_temp_M4 ADD CBR NVARCHAR(50)
--ALTER TABLE daydemand_temp_M4 ADD status NVARCHAR(50)

update daydemand_temp_M4 set sno= a.sino 
from (
select pdno,tpl_code,child_item,company,
ROW_NUMBER() over (partition by company,child_item order by SUB_DIVISION_SORTING,shortage_items_count asc) 'SINo'  
from daydemand_temp_M4  
)a where daydemand_temp_M4.pdno=a.pdno and daydemand_temp_M4.tpl_code=a.tpl_code 
and daydemand_temp_M4.child_item=a.child_item and daydemand_temp_M4.company=a.company



update daydemand_temp_M4 set stock_status=a.stock_status from (

select distinct pdno,TPL_Code,child_item, BOM_Qty,Stock,SNo,company,
sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno rows between unbounded preceding and current row) 'Running_BOM_Qty',
case 
    when Child_Item_Desc like '%Manual%' then 'Stock_available'
    when Child_Item_Desc like '%Balancing%' then 'Stock_available'
    when sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno rows between unbounded preceding and current row) <= Stock then 'Stock_available'
    else 'No stock' 
end 'Stock_Status'
from daydemand_temp_M4 

)a where daydemand_temp_M4.pdno=a.pdno and daydemand_temp_M4.tpl_code=a.tpl_code and daydemand_temp_M4.child_item=a.child_item
 and daydemand_temp_M4.company=a.company

update daydemand_temp_M4 set CBR= a.cbr from (
select company,pdno, CASE 
        WHEN MIN(CASE WHEN Stock_Status = 'Stock_available' THEN 1 ELSE 0 END) = 1
        THEN 'YES'
        ELSE 'NO'
    END AS CBR
from ( 
select distinct pdno,TPL_Code,child_item,Child_Item_Desc, BOM_Qty,Stock,SNo,company,
sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno rows between unbounded preceding and current row) 'Running_BOM_Qty',
case 
 when Child_Item_Desc like '%Manual%' then 'Stock_available'
  when Child_Item_Desc like '%Balancing%' then 'Stock_available'
when sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno rows between unbounded preceding and current row) <= stock then 'Stock_available'
else 'No stock' end 'Stock_Status'
from daydemand_temp_M4 

)a
--where convert(date,Req_Del_Date)=convert(date,getdate()) 
--and
--where pdno='500018464'
group by pdno,company
)a where daydemand_temp_M4.PDNO=a.PDNO  and daydemand_temp_M4.company=a.company

update daydemand_temp_M4 set [status]= 'Can be Released' where daydemand_temp_M4.cbr='Yes'
update daydemand_temp_M4 set [status]='Shortage' where daydemand_temp_M4.cbr='No'

update DayDemand set status_4=a.[status],cbr_4=a.cbr from (
select company,pdno,tpl_code,[status],cbr from daydemand_temp_M4 
)a where daydemand.pdno=a.pdno and daydemand.tpl_code=a.tpl_code and daydemand.company=a.company




--lOGIC ADDED ON 28/01/2026

------------------------METHOD-5 :overall allocation-fifo --Reallocated to items with less number of shortage-------------------------------

----ALTER TABLE DayDemand ADD SNO_5 INT 
----ALTER TABLE DAYDEMAND ADD stock_status_5 NVARCHAR(50)
----ALTER TABLE DAYDEMAND ADD CBR_5 NVARCHAR(50)
----ALTER TABLE DAYDEMAND ADD status_5 NVARCHAR(50)


--update DayDemand set SNo_5=a.SINo from (
--select pdno,TPL_Code,child_item,Req_Del_Date,ROW_NUMBER() over (partition by child_item order by req_del_date,pdno asc) 'SINo' 
--from DayDemand 
--)a where a.PDNO=DayDemand.pdno and DayDemand.TPL_Code=a.TPL_Code and DayDemand.Child_Item=a.Child_Item



----alter table daydemand add CBR nvarchar(10)
----alter table daydemand alter column Stock_Status nvarchar(100)

--update DayDemand set stock_status_5=a.stock_status from (

--select distinct pdno,TPL_Code,child_item,Child_Item_Desc,Req_Del_Date, BOM_Qty,Stock,SNo,
--sum(BOM_Qty) over (partition by child_item order by child_item,sno_5 rows between unbounded preceding and current row) 'Running_BOM_Qty',
--case 
-- when Child_Item_Desc like '%Manual%' then 'Stock_available'
--  when Child_Item_Desc like '%Balancing%' then 'Stock_available'
--when sum(BOM_Qty) over (partition by child_item order by child_item,sno_5 rows between unbounded preceding and current row) <= stock then 'Stock_available'
--else 'No stock' end 'Stock_Status'
--from DayDemand 
--)a where DayDemand.PDNO=a.PDNO and DayDemand.TPL_Code=a.TPL_Code and DayDemand.Child_Item=a.Child_Item



--update DayDemand set CBR_5= a.cbr from (
--select pdno, CASE 
--        WHEN MIN(CASE WHEN Stock_Status = 'Stock_available' THEN 1 ELSE 0 END) = 1
--        THEN 'YES'
--        ELSE 'NO'
--    END AS CBR
--from ( 
--select distinct pdno,TPL_Code,child_item,Child_Item_Desc,Req_Del_Date, BOM_Qty,Stock,SNo,
--sum(BOM_Qty) over (partition by child_item order by child_item,sno_5 rows between unbounded preceding and current row) 'Running_BOM_Qty',
--case 
-- when Child_Item_Desc like '%Manual%' then 'Stock_available'
--  when Child_Item_Desc like '%Balancing%' then 'Stock_available'
--when sum(BOM_Qty) over (partition by child_item order by child_item,sno_5 rows between unbounded preceding and current row) <= stock then 'Stock_available'
--else 'No stock' end 'Stock_Status'
--from DayDemand 

--)a
----where convert(date,Req_Del_Date)=convert(date,getdate()) 
----and
----where pdno='500018464'
--group by pdno
--)a where DayDemand.PDNO=a.PDNO

update DayDemand set cbr_5=CBR
update DayDemand set [status_5]= 'Can be Released' where DayDemand.cbr_5='Yes'
update DayDemand set [status_5]='Shortage' where DayDemand.cbr_5='No'



--------------Method -5 : Part -2 --> Reallocating stock to balance cbr='No' Dptwise,N-1,N,N+1------- 
--alter table daydemand_temp_M5 add Company nvarchar(250)

Truncate table daydemand_temp_M5

insert into daydemand_temp_M5 (sub_division,sub_division_sorting ,pdno,tpl_code,child_item,child_item_desc,Req_del_date ,bom_qty,company)
select sub_division,sub_division_sorting ,pdno,tpl_code,child_item,Child_Item_Desc,Req_del_date ,sum(bom_qty) 'BOM_Qty',company from DayDemand 

where CBR_5='No' 
group by sub_division,sub_division_sorting,PDNO,TPL_Code,Child_Item,Req_Del_Date,Child_Item_Desc,company
order by sub_division_sorting,pdno,TPL_Code 

update daydemand_temp_M5 set stock=isnull(a.balance_stock,0) from 
(select company,Child_Item,sum(BOM_Qty) 'BOM_Qty',max(Stock) 'Stock_Qty',isnull(max(stock)-sum(bom_qty),0) 'Balance_stock' from DayDemand
where CBR_5='Yes' 
group by Child_Item,company

)a where a.Child_Item=daydemand_temp_M5.child_item and a.company=daydemand_temp_M5.company


--alter table daydemand_temp_M4 add Shortage_Items_Count int
update daydemand_temp_M5 set Shortage_Items_Count=a.Shortage_Items_Count from (
select company,pdno,tpl_code,count(stock_status) 'Shortage_Items_Count'
from DayDemand 
where CBR_5='No'  and stock_status='No stock'
group by PDNO,TPL_Code,Company 
--order by count(stock_status_4),PDNO
)a where daydemand_temp_M5.pdno=a.PDNO and daydemand_temp_M5.tpl_code=a.TPL_Code  and a.company=daydemand_temp_M5.company

update daydemand_temp_M5 set stock=0 where stock is null

--ALTER TABLE daydemand_temp_M5 ADD SNO INT 
--ALTER TABLE daydemand_temp_M5 ADD stock_status NVARCHAR(50)
--ALTER TABLE daydemand_temp_M5 ADD CBR NVARCHAR(50)
--ALTER TABLE daydemand_temp_M5 ADD status NVARCHAR(50)

update daydemand_temp_M5 set sno= a.sino 
from (
select company,pdno,tpl_code,child_item,ROW_NUMBER() over (partition by company,child_item order by shortage_items_count asc) 'SINo'  
from daydemand_temp_M5  
)a where daydemand_temp_M5.pdno=a.pdno and daydemand_temp_M5.tpl_code=a.tpl_code and daydemand_temp_M5.child_item=a.child_item
 and a.company=daydemand_temp_M5.company


update daydemand_temp_M5 set stock_status=a.stock_status from (

select distinct company,pdno,TPL_Code,child_item, BOM_Qty,Stock,SNo,
sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno rows between unbounded preceding and current row) 'Running_BOM_Qty',
case 
    when Child_Item_Desc like '%Manual%' then 'Stock_available'
    when Child_Item_Desc like '%Balancing%' then 'Stock_available'
    when sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno rows between unbounded preceding and current row) <= Stock then 'Stock_available'
    else 'No stock' 
end 'Stock_Status'
from daydemand_temp_M5 

)a where daydemand_temp_M5.pdno=a.pdno and daydemand_temp_M5.tpl_code=a.tpl_code and daydemand_temp_M5.child_item=a.child_item
 and a.company=daydemand_temp_M5.company


update daydemand_temp_M5 set CBR= a.cbr from (
select company,pdno, CASE 
        WHEN MIN(CASE WHEN Stock_Status = 'Stock_available' THEN 1 ELSE 0 END) = 1
        THEN 'YES'
        ELSE 'NO'
    END AS CBR
from ( 
select distinct company,pdno,TPL_Code,child_item,Child_Item_Desc, BOM_Qty,Stock,SNo,
sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno rows between unbounded preceding and current row) 'Running_BOM_Qty',
case 
 when Child_Item_Desc like '%Manual%' then 'Stock_available'
  when Child_Item_Desc like '%Balancing%' then 'Stock_available'
when sum(BOM_Qty) over (partition by company,child_item order by company,child_item,sno rows between unbounded preceding and current row) <= stock then 'Stock_available'
else 'No stock' end 'Stock_Status'
from daydemand_temp_M5 

)a
--where convert(date,Req_Del_Date)=convert(date,getdate()) 
--and
--where pdno='500018464'
group by pdno,company
)a where daydemand_temp_M5.PDNO=a.PDNO and daydemand_temp_M5.company=a.company

update daydemand_temp_M5 set [status]= 'Can be Released' where daydemand_temp_M5.cbr='Yes'
update daydemand_temp_M5 set [status]='Shortage' where daydemand_temp_M5.cbr='No'


update DayDemand set status_5=a.[status],cbr_5=a.cbr from (
select company,pdno,tpl_code,[status],cbr from daydemand_temp_M5 
)a  where daydemand.pdno=a.pdno and daydemand.tpl_code=a.tpl_code and DayDemand.Company=a.company




------------------------METHOD-6 : For N-------------------------------
--alter table DayDemand add [SNo_6] int

update DayDemand set SNo_6=a.SINo from (
select company,pdno,TPL_Code,child_item,Req_Del_Date,ROW_NUMBER() over (partition by company,child_item order by company,req_del_date,pdno asc) 'SINo' 
from DayDemand 

WHERE CONVERT(DATE,Req_Del_Date) = CONVERT(DATE,GETDATE())

)a where a.PDNO=DayDemand.pdno and DayDemand.TPL_Code=a.TPL_Code and DayDemand.Child_Item=a.Child_Item  and DayDemand.Company=a.Company



--alter table daydemand add CBR_6 nvarchar(10)
--alter table daydemand ADD Stock_Status_6 nvarchar(100)

update DayDemand set stock_status_6=a.stock_status from (

select distinct company,pdno,TPL_Code,child_item,Child_Item_Desc,Req_Del_Date, BOM_Qty,Stock,SNo_6,
sum(BOM_Qty) over (partition by company,child_item order by child_item,sno_6 rows between unbounded preceding and current row) 'Running_BOM_Qty',
case 
 when Child_Item_Desc like '%Manual%' then 'Stock_available'
  when Child_Item_Desc like '%Balancing%' then 'Stock_available'
when sum(BOM_Qty) over (partition by company,child_item order by child_item,sno_6 rows between unbounded preceding and current row) <= stock then 'Stock_available'
else 'No stock' end 'Stock_Status'
from DayDemand 
WHERE CONVERT(DATE,Req_Del_Date) = CONVERT(DATE,GETDATE())
)a where DayDemand.PDNO=a.PDNO and DayDemand.TPL_Code=a.TPL_Code and DayDemand.Child_Item=a.Child_Item 
and DayDemand.Company=a.Company



update DayDemand set CBR_6= a.cbr from (

select company,pdno, CASE 
        WHEN MIN(CASE WHEN Stock_Status = 'Stock_available' THEN 1 ELSE 0 END) = 1
        THEN 'YES'
        ELSE 'NO'
    END AS CBR
from ( 

select distinct company,pdno,TPL_Code,child_item,Child_Item_Desc,Req_Del_Date, BOM_Qty,Stock,SNo_6,
sum(BOM_Qty) over (partition by company,child_item order by child_item,sno_6 rows between unbounded preceding and current row) 'Running_BOM_Qty',
case 
 when Child_Item_Desc like '%Manual%' then 'Stock_available'
  when Child_Item_Desc like '%Balancing%' then 'Stock_available'
when sum(BOM_Qty) over (partition by company,child_item order by child_item,sno_6 rows between unbounded preceding and current row) <= stock then 'Stock_available'
else 'No stock' end 'Stock_Status'
from DayDemand 
WHERE CONVERT(DATE,Req_Del_Date) = CONVERT(DATE,GETDATE())-- and Company='470'

)a
--where convert(date,Req_Del_Date)=convert(date,getdate()) 
--and
--where pdno='500018464'
group by pdno,company
)a where DayDemand.PDNO=a.PDNO and DayDemand.Company=a.Company

--alter table daydemand ADD Status_6 nvarchar(10)

update DayDemand set [status_6]= 'Can be Released' where DayDemand.cbr_6='Yes'
update DayDemand set [status_6]='Shortage' where DayDemand.cbr_6='No'


----alter table DayDemand add warehouse nvarchar(50)

update  daydemand set warehouse= a.CWAR from  TTISFC001ALL a where daydemand.company=a.company and daydemand.pdno=a.pdno
and daydemand.TPL_Code=ltrim(rtrim(a.mitm))


--Updating responsible as per EBS team Rules

--alter table daydemand add Responsible nvarchar(250)

update daydemand set Responsible = 'Aircenter' where Supplier_name like '%ELGI EQUIPMENTS LIMITED (AIRCENTER)%' and Buyer_name like '%JAYAPAL%'

update daydemand set Responsible = 'PVD' where Supplier_name like '%ELGI EQUIPMENTS LIMITED - PVD%' and Buyer_name like '%KUPPUSAMY A%'

update daydemand set Responsible = 'MOTOR' where Supplier_name like '%ELGI EQUIPMENTS LIMITED (MOTOR DIVI%' and Buyer_name like '%ARUNPRASAD MANOHARAN%'

update daydemand set Responsible = 'Inhouse' where Supplier_name like '%ELGI EQUIPMENTS LIMITED%' and Buyer_name like '%NITHISHKUMAR K.J%'

update daydemand set Responsible = 'Inhouse' where Supplier_name like '%ELGI EQUIPMENTS LIMITED%' and Buyer_name like '%VIJAYAKUMAR S%'

update daydemand set Responsible='Materials' where responsible is null

--alter table daydemand add UpdatedDate datetime

update DayDemand set UpdatedDate= getdate()

end

GO

