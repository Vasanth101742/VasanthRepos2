--exec sp_InventoryDetails_Subsidiaries

CREATE proc [dbo].[sp_InventoryDetails_Subsidiaries] as

begin

--Developed inorder to provide additional Fields and to match the 490 company '102' warehouse value mismatch occured
--due to WMS activity. Note: This Table cannot be used for Ageing Analysis

--select * into InventoryDetails from Inventory
Truncate table InventoryDetails_subs_Temp
Truncate table InventoryDetails_Subsidiaries
--Truncate table Elgi_Inv_FullAccess
Truncate Table Inventory_subs_Currency_Conversion



--Alter table InventoryDetails_Subsidiaries add ItemCategory_SOP varchar(50)
--Alter table InventoryDetails_subs_Temp add ItemCategory_SOP varchar(50)
--Alter table InventoryDetails_subs_History add ItemCategory_SOP varchar(50)


--Alter table InventoryDetails_Subsidiaries add Productgroup_SOP varchar(50)
--Alter table InventoryDetails_subs_Temp add Productgroup_SOP varchar(50)
--Alter table InventoryDetails_subs_History add Productgroup_SOP varchar(50)


--Alter table InventoryDetails_Subsidiaries add RRS varchar(50)
--Alter table InventoryDetails_subs_Temp add RRS varchar(50)
--Alter table InventoryDetails_subs_History add RRS varchar(50)

--Alter table InventoryDetails_Subsidiaries add RegionOrder int
--Alter table InventoryDetails_subs_Temp add RegionOrder int
--Alter table InventoryDetails_subs_History add RegionOrder int

--Alter table InventoryDetails_Subsidiaries add Region varchar(25)
--Alter table InventoryDetails_subs_Temp add Region varchar(25)
--Alter table InventoryDetails_subs_History add Region varchar(25)


--Alter table InventoryDetails add Currency varchar(25)
--Alter table InventoryDetails_Temp add Currency varchar(25)
--Alter table InventoryDetails_History add Currency varchar(25)

--Alter table InventoryDetails add INR_Conv_Rate float
--Alter table InventoryDetails_Temp add INR_Conv_Rate float
--Alter table InventoryDetails_History add INR_Conv_Rate float

--Alter table InventoryDetails add Amnt4_INR float
--Alter table InventoryDetails_Temp add Amnt4_INR float
--Alter table InventoryDetails_History add Amnt4_INR float

--Select * into InventoryDetails_Subsidiaries from [ELGI_LN].dbo.InventoryDetails


Insert into InventoryDetails_Subsidiaries(COMPANY,CWAR,ITEM,ItemDescr,TRDT,SEQN,INWP,QSKT,Amnt,Ageing,AgeingOrdr,
stock_955,Cumulative_stk,Remarks,OrderType,QSTK,IssueDate,Amnt2,Amnt3,CITG,CITG_desc,Amnt4)
select COMPANY,CWAR,ITEM,ItemDescr,TRDT,SEQN,INWP,QSKT,Amnt,
null Ageing,null AgeingOrdr,null stock_955,null Cumulative_stk,null Remarks,
OrderType,QSTK,IssueDate,Amnt2,Amnt3,CITG,CITG_desc,Amnt4
from Inventory_Subsidiaries


------------------------Production WIP Inventory -----------------------------------------------
----Commented as LN Table is not available
--Insert into InventoryDetails (COMPANY,CWAR,ITEM,ItemDescr,CITM,CDSCA,ORDT,PDNO,--PONO,QRDR,
--WQTY,WAMT,UPDT)
--select COMPANY,CWAR,MITM,MDSCA,CITM,CDSCA,ORDT,PDNO,--PONO,QRDR,
--sum(WQTY) WQTY,
--sum(WAMT) WAMT,Date1 as UPDT
--from
--(select * from tzzsfc918all a
--where Date1=(select max(Date1) from tzzsfc918all where Date1<>'9999-01-01 00:00:00.000')
--)a
--group by COMPANY,CWAR,MITM,MDSCA,CITM,CDSCA,ORDT,PDNO,Date1



----------------------End: Production WIP Inventory ----------------------------------------------

update InventoryDetails_Subsidiaries set citg_desc=a.DSCA
from (select * from LN_TCMCS023)a
where InventoryDetails_Subsidiaries.COMPANY=a.COMPNR
and ltrim(rtrim(InventoryDetails_Subsidiaries.CITG))=ltrim(rtrim(a.CITG))


--update InventoryDetails_Subsidiaries set IssueDate=isnull(T$CTDT,IssueDate)
--from (select COMPANY,T$CWAR,T$ITEM,max(T$CTDT) T$CTDT,datediff(dd,max(T$CTDT),(getdate()-1)) as DaysDiff  
--from TWHINA114ALL
--group by COMPANY,T$CWAR,T$ITEM)a
--where InventoryDetails_Subsidiaries.COMPANY=a.COMPANY
--and ltrim(rtrim(InventoryDetails_Subsidiaries.CWAR))=ltrim(rtrim(a.T$CWAR))
--and ltrim(rtrim(InventoryDetails_Subsidiaries.ITEM))=ltrim(rtrim(a.T$ITEM))
--and InventoryDetails_Subsidiaries.COMPANY=490




update InventoryDetails_Subsidiaries set Amnt2=isnull(a.AMNT_1,0)
from 
(select COMPANY,CWAR,ITEM,TRDT,SEQN,INWP,--CPCP,
QSKT,QSTK,sum(AMNT_1) AMNT_1 from 
Inventory_subs_Amnt2_Tmp
group by COMPANY,CWAR,ITEM,TRDT,SEQN,INWP--,CPCP
,QSKT,QSTK
) a
where InventoryDetails_Subsidiaries.COMPANY=a.COMPANY
and InventoryDetails_Subsidiaries.CWAR=a.CWAR
and InventoryDetails_Subsidiaries.ITEM=a.ITEM
and InventoryDetails_Subsidiaries.TRDT=a.TRDT
and InventoryDetails_Subsidiaries.SEQN=a.SEQN
and InventoryDetails_Subsidiaries.INWP=a.INWP


update InventoryDetails_Subsidiaries set Amnt3=isnull(Amnt,0)+isnull(Amnt2,0)



--Commented as LN Table is not available
--update InventoryDetails set FrtRate=a.FrtRate,Duty=a.Duty--Amnt3+Amnt3*FrtRate
--from (select ITEM,isnull(DUTY,0) as Duty,
--isnull(FRTP,0)+isnull(SEAF,0) as FrtRate 
----isnull(FRTP,0)+isnull(DUTY,0)+isnull(SEAF,0) as FrtRate 
--from TZZYIN301400
---- where ltrim(rtrim(ITEM)) ='B004705760006'
--)a
--where ltrim(rtrim(InventoryDetails.ITEM))=ltrim(rtrim(a.ITEM))
--and company like '4%'



--Method1 till 24-Nov-2021
--update InventoryDetails set Amnt4=Amnt3+(Amnt3*isnull(FrtRate,0))/100 

--Method 2 : Since 25-Nov-2021
update InventoryDetails_Subsidiaries set Amnt4=Amnt3+(Amnt3*isnull(Duty,0))/100 + (Amnt3*isnull(FrtRate,0))/100

update InventoryDetails_Subsidiaries set Amnt4=WAMT where WAMT is not null  
update InventoryDetails_Subsidiaries set QSKT=WQTY where WQTY is not null  


----Commented as LN Table is not available
--update InventoryDetails_Subsidiaries set WLOC=a.WLOC
--from (select * from  TZZINV700ALL
--where WLOC is not null
--and ltrim(rtrim(WLOC))<>'')a
--where InventoryDetails_Subsidiaries.company=a.company
--and InventoryDetails_Subsidiaries.cwar=a.cwar
--and ltrim(rtrim(InventoryDetails_Subsidiaries.ITEM))=ltrim(rtrim(a.item))


update InventoryDetails_Subsidiaries set MultiplyFactor=1 where MultiplyFactor is null

update InventoryDetails_Subsidiaries set Amnt4=Amnt4*MultiplyFactor


update InventoryDetails_Subsidiaries set Currency='USD' where company like '31%'
update InventoryDetails_Subsidiaries set Currency='BRL' where company = '2000'
update InventoryDetails_Subsidiaries set Currency='EUR' where company in('1100','1700')



--EUR to INR Conversion
--select CCUR,BCUR,convert(date,STDT) STDT,max(RATE) RATE from TTCMCS008ALL 
--where RTYP='PUR' 
--and bcur in ('IND','INR')
--and RATE>1
--and ccur ='EUR'
----and convert(date,stdt)='2024-01-08'
--group by CCUR,BCUR,convert(date,STDT)



insert into Inventory_subs_Currency_Conversion(TRDT,Currency,BCUR,CCUR,STDT,RATE,DaysDiff,Rnk)
--select * into Inventory_Currency_Conversion from (
select TRDT,Currency,BCUR,CCUR,STDT,RATE,DaysDiff,Rnk 
from (select *,datediff(dd,STDT,TRDT) as DaysDiff,
row_number() over (partition by Currency,TRDT order by datediff(dd,STDT,TRDT)) as Rnk 
from (select distinct TRDT,Currency from inventorydetails_subsidiaries
where currency in ('USD','EUR','BRL')
)a
left outer join 
(select CCUR,BCUR,RTYP,convert(date,STDT) STDT,max(RATE) RATE
from [ELGi_LN].dbo.TTCMCS008ALL 
where ccur in ('USD','EUR','BRL')
and bcur in ('IND','INR')
and RATE<>1
--and convert(date,stdt)='2024-01-08'
group by CCUR,BCUR,RTYP,convert(date,STDT)
)b
on a.currency=b.ccur
and a.TRDT>=b.STDT
)a
where Rnk=1
--)a




update InventoryDetails_Subsidiaries set INR_Conv_Rate=a.RATE
from (select * from Inventory_subs_Currency_Conversion)a
where InventoryDetails_Subsidiaries.Currency=a.Currency
and InventoryDetails_Subsidiaries.TRDT=a.TRDT

update InventoryDetails_Subsidiaries set INR_Conv_Rate=1
where currency in('IND')

update InventoryDetails_Subsidiaries set Amnt4_INR=isnull(INR_Conv_Rate,1)*Amnt4


--alter table InventoryDetails_Subsidiaries add Location nvarchar(250)



--select * from Inventorydetails
--where company like '5%'
--and company<>'581'


------DHI to INR Conversion
--select CCUR,BCUR,RTYP,convert(date,STDT) STDT,max(RATE) RATE from TTCMCS008ALL 
--where --RTYP='PUR' and 
--bcur in ('IND','INR')
--and RATE<>1
--and ccur ='DHI'
----and convert(date,stdt)='2024-01-08'
--group by CCUR,BCUR,RTYP,convert(date,STDT)


------AUD to INR Conversion
----select CCUR,BCUR,RTYP,convert(date,STDT) STDT,max(RATE) RATE from TTCMCS008ALL 
----where --RTYP='PUR' and 
----bcur in ('IND','INR')
----and RATE<>1
----and ccur ='AUD'
------and convert(date,stdt)='2024-01-08'
----group by CCUR,BCUR,RTYP,convert(date,STDT)



------IDR to INR Conversion Not available
----select CCUR,BCUR,RTYP,convert(date,STDT) STDT,max(RATE) RATE from TTCMCS008ALL 
----where --RTYP='PUR' and 
----ccur in ('IND','INR')
------and RATE<>1
----and 
----bcur ='IDR'
------and convert(date,stdt)='2024-01-08'
----group by CCUR,BCUR,RTYP,convert(date,STDT)


----select CCUR,BCUR,RTYP,convert(date,STDT) STDT,max(RATE) RATE from TTCMCS008ALL 
----where --RTYP='PUR' and 
----bcur in ('IND','INR')
------and RATE<>1
----and 
----ccur ='IDR'
------and convert(date,stdt)='2024-01-08'
----group by CCUR,BCUR,RTYP,convert(date,STDT)



----MYR to INR Conversion
----select CCUR,BCUR,RTYP,convert(date,STDT) STDT,max(RATE) RATE from TTCMCS008ALL 
----where --RTYP='PUR' and 
----bcur in ('IND','INR')
----and RATE<>1
----and ccur ='MYR'
------and convert(date,stdt)='2024-01-08'
----group by CCUR,BCUR,RTYP,convert(date,STDT)





----Commented as below data not applicalble for Subsidiaries
--update Inventory_Master set INVType=ltrim(rtrim(INVType))
--update Inventory_Master set ItemType=ltrim(rtrim(ItemType))
--update Inventory_Master set RecptType=ltrim(rtrim(RecptType))
--update Inventory_Master set Vertical=ltrim(rtrim(Vertical))
--update Inventory_Master set CompName=ltrim(rtrim(CompName))


--update inventory_master set CompName=a.CompName
--from (select distinct comp,CompName from inventory_master where CompName is not null)a
--where Inventory_Master.Comp=a.Comp
--and Inventory_Master.CompName is null



--update InventoryDetails set CompName=ltrim(rtrim(a.CompName))
--from Inventory_Master a
--where InventoryDetails.COMPANY=a.Comp


--update InventoryDetails set INVType=a.INVType,ItemType=a.ItemType,
--RecptType=a.RecptType,Vertical=a.Vertical,CompName=a.CompName
--from Inventory_Master a
--where InventoryDetails.COMPANY=a.Comp
--and InventoryDetails.CWAR=a.WH

----Method2
--update InventoryDetails set INVType=a.INVType,ItemType=a.ItemType,
--RecptType=a.ReceiptType--,Vertical=a.Vertical
--from Inventory_Master2 a
--where InventoryDetails.COMPANY=a.COMPANY
--and InventoryDetails.CWAR=a.CWAR
--and ltrim(rtrim(InventoryDetails.item))=ltrim(rtrim(a.ITEM))
----and InventoryDetails.OrderType=a.OrderType
--and (a.INVType is not null or a.INVType='RM')
----and ltrim(rtrim(InventoryDetails.item))='411300085' and InventoryDetails.CWAR='253' --Testing


----Method3
--update InventoryDetails set INVType='RM'
--from (select distinct a.Comp,a.WH,a.INVType as InvType1,a.Vertical,b.InvType  as InvType2 from inventory_master a
--left outer join 
--(select distinct company,cwar,InvType from Inventory_Master2) b
--on concat(a.Comp,a.wh)=concat(b.COMPANY,b.CWAR)
--and a.INVType<>b.InvType
--where b.InvType ='FG'
--and a.vertical is null
--)a
--where concat(InventoryDetails.COMPANY,InventoryDetails.CWAR) =concat(a.Comp,a.wh)
--and InventoryDetails.INVType='FG'
--and InventoryDetails.Vertical is null
----and ltrim(rtrim(InventoryDetails.item))='411300085' and InventoryDetails.CWAR='253' --Testing

--update InventoryDetails set INVType='WIP' where WAMT is not null

--update InventoryDetails set INVType='RM',--'Sub Con',
--RecptType='sub con  WH Stock'
--where company in (select company from ELGI_Companies_Master where CompanyGroup='ELGi')
--and INVType is null
--and len(CWAR)>3

----Special Case: on request from Robert (Materials)

--update InventoryDetails set INVType='FG',ItemType='Purchased',RecptType='Finished Goods'
--where concat(company,CWAR,ltrim(rtrim(item)))='401291S411073'


--update InventoryDetails set INVType=a.Group1,vertical=a.Group2
--from Inventory_Master_ATS a
--where company in (select company from ELGI_Companies_Master where CompanyGroup='ATS')
--and ltrim(rtrim(InventoryDetails.CWAR))=ltrim(rtrim(a.WH))

----Method1 : On Hold, as all the data are maintained under 400 company in LN Master
----update InventoryDetails set Category=a.CATG
----from TZZINV310ALL a
----where InventoryDetails.company=a.company 
----and ltrim(rtrim(InventoryDetails.item))=ltrim(rtrim(a.item))

----Method2 :
--update InventoryDetails set Category=a.CATG,VARI=a.VARI2,PLMT=a.PLMT
--from (select *,case when VARI is null or ltrim(rtrim(VARI))='' then null else VARI end as VARI2 
--from TZZINV310ALL where company=400
--) a
--where ltrim(rtrim(InventoryDetails.item))=ltrim(rtrim(a.item))
----and InventoryDetails.company=a.company 
--and InventoryDetails.company like '4%'


--update InventoryDetails set Category=a.CATG,VARI=a.VARI,PLMT=a.PLMT
--from (select * from TZZINV310ALL where company=470) a
--where ltrim(rtrim(InventoryDetails.item))=ltrim(rtrim(a.item))
----and InventoryDetails.company=a.company 
--and InventoryDetails.company = '470'


----Alter table InventoryDetails add VARI nvarchar(60)
----Alter table InventoryDetails add DEMCLASS nvarchar(255)
----Alter table InventoryDetails_Temp add VARI nvarchar(60)
----Alter table InventoryDetails_Temp add DEMCLASS nvarchar(255)
----Alter table InventoryDetails_History add VARI nvarchar(60)
----Alter table InventoryDetails_History add DEMCLASS nvarchar(255)

----Select * from InventoryDetails where ltrim(rtrim(ITEM))='000010300' --Test data
----select * from TZZINV310ALL where company=400 and ltrim(rtrim(ITEM))='000010300'--Test data

--update InventoryDetails set DEMCLASS=a.DEMCLASS
--from (select DISTINCT LTRIM(RTRIM(ITEMCODE))AS ITEM,DIVISION,DEMCLASS,DEMSUBCLASS ,PRODUCTLINE ,SUBDIVISION,YEAR,MONTH  
--From OTA_TPL_MASTER)a
--where ltrim(rtrim(InventoryDetails.item))=ltrim(rtrim(a.item))


--update InventoryDetails set category2=a.Category,TargetValue=a.Target
--from(select * from ACP_inventory_Master where [Po Series]='No'
--and EntryDate=(select max(EntryDate) from ACP_inventory_Master)
--)a
--where InventoryDetails.company=a.company
--and InventoryDetails.CWAR=a.Warehouse
--and InventoryDetails.PDNO is null


--update InventoryDetails set category2=a.Category,TargetValue=a.Target
--from(select * from ACP_inventory_Master where [Po Series]='Yes'
--and EntryDate=(select max(EntryDate) from ACP_inventory_Master)
--)a
--where InventoryDetails.company=a.company
--and InventoryDetails.CWAR=a.Warehouse
--and InventoryDetails.PDNO is not null 


--update InventoryDetails set category2='Others'
--where company=450 and category2 is null
----from(select * from ACP_inventory_Master where 
----EntryDate=(select max(EntryDate) from ACP_inventory_Master)
----)a
----where InventoryDetails.company=a.company
----and InventoryDetails.CWAR<>a.Warehouse





--delete from InventoryDetails where INVType= 'Others'
----delete from InventoryDetails where concat(COMPANY,CWAR) in ('400625','450604')--Old Method
----After Sivaranjani's Mail
--delete from InventoryDetails where concat(COMPANY,CWAR) in ('450604')






Insert into InventoryDetails_subs_Temp(COMPANY,CWAR,ITEM,ItemDescr,TRDT,SEQN,INWP,QSKT,Amnt,Ageing,AgeingOrdr,stock_955,Cumulative_stk,Remarks,
OrderType,QSTK,IssueDate,Amnt2,Amnt3,CITG,CITG_desc,INVType,ItemType,RecptType,LedgerCode,LedgerDesc,SuppCode,
SuppName,BuyerCode,BuyerName,LeanType,Vertical,InvTypeOrder,Amnt4,CompName,VerticalOrder,FrtRate,TargetRnk,
--MITM,MDSCA,
CITM,CDSCA,ORDT,PDNO,PONO,QRDR,WQTY,WAMT,UPDT,MultiplyFactor,Category,
Duty,WLOC,VARI,DEMCLASS,Category2,TargetValue,PLMT,Currency,INR_Conv_Rate,Amnt4_INR
)
--select * into InventoryDetails_Temp from (
select COMPANY,CWAR,ITEM,ItemDescr,TRDT,SEQN,INWP,QSKT,Amnt,Ageing,AgeingOrdr,stock_955,Cumulative_stk,Remarks,
OrderType,QSTK,IssueDate,Amnt2,Amnt3,CITG,CITG_desc,INVType,ItemType,RecptType,LedgerCode,LedgerDesc,SuppCode,
SuppName,BuyerCode,BuyerName,LeanType,Vertical,InvTypeOrder,Amnt4,CompName,VerticalOrder,FrtRate,
row_number() over(partition by INVType,Vertical,CompName order by INVType,Vertical,CompName) as TargetRnk,  
--MITM,MDSCA,
CITM,CDSCA,ORDT,PDNO,PONO,QRDR,WQTY,WAMT,UPDT,MultiplyFactor,Category,
Duty,WLOC,VARI,DEMCLASS,Category2,TargetValue,PLMT,Currency,INR_Conv_Rate,Amnt4_INR
from InventoryDetails_subsidiaries
--)a


Truncate table InventoryDetails_subsidiaries

Insert into InventoryDetails_subsidiaries(COMPANY,CWAR,ITEM,ItemDescr,TRDT,SEQN,INWP,QSKT,Amnt,Ageing,AgeingOrdr,stock_955,Cumulative_stk,Remarks,
OrderType,QSTK,IssueDate,Amnt2,Amnt3,CITG,CITG_desc,INVType,ItemType,RecptType,LedgerCode,LedgerDesc,SuppCode,
SuppName,BuyerCode,BuyerName,LeanType,Vertical,InvTypeOrder,Amnt4,CompName,VerticalOrder,FrtRate,TargetRnk,TargetDays,
CITM,CDSCA,ORDT,PDNO,PONO,QRDR,WQTY,WAMT,UPDT,MultiplyFactor,Category,
Duty,WLOC,VARI,DEMCLASS,category2,TargetValue,PLMT,Currency,INR_Conv_Rate,Amnt4_INR
)
select 
COMPANY,CWAR,ITEM,ItemDescr,TRDT,SEQN,INWP,QSKT,Amnt,Ageing,AgeingOrdr,stock_955,Cumulative_stk,Remarks,
OrderType,QSTK,IssueDate,Amnt2,Amnt3,CITG,CITG_desc,INVType,ItemType,RecptType,LedgerCode,LedgerDesc,SuppCode,
SuppName,BuyerCode,BuyerName,LeanType,Vertical,InvTypeOrder,Amnt4,CompName,VerticalOrder,FrtRate,TargetRnk,null as TargetDays,
CITM,CDSCA,ORDT,PDNO,PONO,QRDR,WQTY,WAMT,UPDT,MultiplyFactor,Category,
Duty,WLOC,VARI,DEMCLASS,category2,TargetValue,PLMT,Currency,INR_Conv_Rate,Amnt4_INR
from InventoryDetails_subs_Temp


----Commented as Not applicable for Subsidiaries
--update Inventory_Targetdays_Master set INVType=ltrim(rtrim(INVType))
--update Inventory_Targetdays_Master set Vertical=ltrim(rtrim(Vertical))
--update Inventory_Targetdays_Master set CompName=ltrim(rtrim(CompName))

--update InventoryDetails set TargetDays=a.TargetDays
--from (select concat(INVType,isnull(vertical,''),CompName) as ColA,* from Inventory_Targetdays_Master 
--where CalYear=year(getdate()-1)
--and CalMonth=month(getdate()-1)
--)a
--where concat(isnull(InventoryDetails.INVType,''),isnull(InventoryDetails.vertical,''),isnull(InventoryDetails.CompName,''))=a.ColA
--and TargetRnk=1
--and month(getdate()-1)=a.CalMonth
--and year(getdate()-1)=a.CalYear



--update InventoryDetails set LedgerCode=a.LedgerCode,LedgerDesc=a.LedgerDesc
--from InventoryMappingMaster a
--where InventoryDetails.COMPANY=a.Company
--and InventoryDetails.CWAR between a.WarFrom and a.WarTo
--and substring(ltrim(rtrim(InventoryDetails.ITEM)),1,3) between a.ItemGroupFrom and a.ItemGroupTo



--update InventoryDetails set LedgerCode=a.LedgerCode,LedgerDesc=a.LedgerDesc
--from InventoryMappingMaster a
--where InventoryDetails.COMPANY=a.Company
--and InventoryDetails.CWAR between a.WarFrom and a.WarTo
----and substring(ltrim(rtrim(InventoryDetails.ITEM)),1,3) between a.ItemGroupFrom and a.ItemGroupTo
--and InventoryDetails.LedgerCode is null


--update InventoryDetails set SuppCode=a.SUNO1
--from (select * from TZZPUR049ALL where company in (select company from ELGI_Companies_Master where CompanyGroup='ELGI'))a
--where InventoryDetails.COMPANY=a.COMPANY
--and ltrim(rtrim(InventoryDetails.ITEM))=ltrim(rtrim(a.ITEM))

update InventoryDetails_subsidiaries set SuppCode=a.OTBP,BuyerCode=a.BUYR
from LN_TDIPU001 a
where InventoryDetails_subsidiaries.COMPANY=a.COMPNR
and ltrim(rtrim(InventoryDetails_subsidiaries.ITEM))=ltrim(rtrim(a.ITEM))


update InventoryDetails_subsidiaries set SuppName=a.custname1
from vw_Business_Partner_US a
where InventoryDetails_subsidiaries.Suppcode = a.custcode

--update InventoryDetails set BuyerCode=a.BUYR
--from (select * from TZZPUR049ALL where company in (select company from ELGI_Companies_Master where CompanyGroup='ELGI'))a
--where InventoryDetails.COMPANY=a.COMPANY
--and ltrim(rtrim(InventoryDetails.ITEM))=ltrim(rtrim(a.ITEM))

update InventoryDetails_subsidiaries set BuyerName=a.emp_name
from [Elgi_Intranet].dbo.Employee_Detail a
where InventoryDetails_subsidiaries.Buyercode =  convert(varchar,a.new_emp_code)



update InventoryDetails_subsidiaries set ItemCategory_SOP=a.Item_Category,
Productgroup_SOP=a.Product_group
from( select * from [ELGi_SOP].dbo.TPL_MASTER_REF)a
where InventoryDetails_subsidiaries.Region=a.Region
and ltrim(rtrim(InventoryDetails_subsidiaries.Item))=ltrim(rtrim(a.item))

update InventoryDetails_subsidiaries set RRS=a.RRS_Classification
from (select distinct 
case when Region in ('Africa','ME') then 'Gulf' else Region end as Region,
item,RRS_Classification from 
(select distinct a.Region,b.item,a.RRS_Classification from 
(select case when organ in (
'Channel','Direct','C&M','WW',
'ACP-AFM-Industrial','ACP-AFM-Portables',
'GSC-AFM-Industrial','GSC-AFM-Portables','GSC-AFM-Railway',
'HO-AFM-Industrial','HO-AFM-Portables','HO-AFM-Railway',
'Railway Units','Railways Wiper','SA','ATS') then 'India' 
else Organ end as Region,
Organ,DFUCode,RRS_Classification from [ELGi_SOP].dbo.SalesQtyForecast_Monthwise_Analysis) a
left outer join (select * from [ELGi_SOP].dbo.TPL_MASTER_REF)b
on a.Region=b.Region
and ltrim(rtrim(a.DFUCode))=ltrim(rtrim(b.Demand_Forecasting_Unit_DFU))
)a1)a
where ltrim(rtrim(InventoryDetails_subsidiaries.Region))=ltrim(rtrim(a.Region))
and ltrim(rtrim(InventoryDetails_subsidiaries.ITEM))=ltrim(rtrim(a.ITEM))



--Alter table InventoryDetails_subsidiaries add OrderNum nvarchar(255)

update InventoryDetails_subsidiaries set ItemExtDescr=ltrim(rtrim(a.cdf_extd)),StandardItemDesc=trim(a.dscd) from  LN_TCIBD001 a

where  ltrim(rtrim(InventoryDetails_subsidiaries.Item))=ltrim(rtrim(a.item)) 
and (case when InventoryDetails_Subsidiaries.COMPANY like '3%' then '3100' else InventoryDetails_Subsidiaries.COMPANY end)
=a.compnr

update InventoryDetails_subsidiaries set OrderTypeDesc=replace(a.koor_kw,'tckoor.','')  from (select * from ln_whina112) a 
where InventoryDetails_Subsidiaries.COMPANY
=a.compnr and InventoryDetails_subsidiaries.ordertype=a.koor



UPDATE InventoryDetails_subsidiaries SET OrderTypeDesc=A.Description from  (SELECT * FROM [LN_WHINA112_OrderTypedesc])A WHERE TRIM(ORDERTYPEDESC)=A.[NAME]


update InventoryDetails_Subsidiaries set ProductType=a.CTYP
from (select * from LN_TCIBD001)a
where (CASE WHEN InventoryDetails_Subsidiaries.COMPANY LIKE '31%' THEN '3100' ELSE InventoryDetails_Subsidiaries.COMPANY END )=a.compnr
and TRIM(InventoryDetails_Subsidiaries.ITEM)= TRIM(A.ITEM)

update InventoryDetails_Subsidiaries set ProductDesc=a.DSCA
from (select * from LN_TCMCS015)a
where (CASE WHEN InventoryDetails_Subsidiaries.COMPANY LIKE '31%' THEN '3100' ELSE InventoryDetails_Subsidiaries.COMPANY END )=a.compnr
and TRIM(InventoryDetails_Subsidiaries.ProductType)= TRIM(A.ctyp)

---Location


update InventoryDetails_Subsidiaries set Location=a.loca
from (select * from LN_WHINR140 WHERE deleted='N')a
where InventoryDetails_Subsidiaries.COMPANY=a.compnr
and TRIM(InventoryDetails_Subsidiaries.Item)= TRIM(A.item) and InventoryDetails_Subsidiaries.cwar=a.cwar and InventoryDetails_Subsidiaries.QSKT=a.qhnd

update InventoryDetails_Subsidiaries set Ordernum=a.orno from  (
select COMPNR,CWAR,Trim(ITEM) 'Item',convert(datetime,TRDT) 'TRDT',SEQN,INWP,KOOR,
sum(QSTK) QSTK,sum(QSKT) QSKT,koor_kw,orno 
from LN_WHINA112
group by COMPNR,CWAR,ITEM,TRDT,SEQN,INWP,KOOR,koor_kw,orno
having sum(QSKT)>0
) a 
where InventoryDetails_Subsidiaries.company=a.compnr and InventoryDetails_Subsidiaries.cwar=a.cwar and trim(InventoryDetails_Subsidiaries.Item)=a.item
and InventoryDetails_Subsidiaries.trdt=a.trdt and InventoryDetails_Subsidiaries.seqn=a.seqn and InventoryDetails_Subsidiaries.inwp=a.inwp 
and InventoryDetails_Subsidiaries.ordertype=a.koor

--ALter table InventoryDetails_Subsidiaries add ReceiptNum nvarchar(100)

update InventoryDetails_Subsidiaries set ReceiptNum=null 

update InventoryDetails_Subsidiaries set ReceiptNum=a.rcno from (
SELECT distinct compnr,trim(orno) 'OrderNum',trim(item)'Item',rcno

FROM [dbo].LN_TDPUR401
where oltp<>1 --and orno='MPO007466' and trim(item)='526-21-0005' 
and LEN(rcno)>=1

) a where InventoryDetails_Subsidiaries.company=a.compnr and  trim(InventoryDetails_Subsidiaries.Item)=a.item 
and  trim(InventoryDetails_Subsidiaries.OrderNum)=a.OrderNum and OrderTypeDesc ='Purchase Order' --and TRDT=convert(datetime,ddte)


update InventoryDetails_Subsidiaries set Fabno=a.serl from (
SELECT distinct compnr,trim(orno) 'OrderNum',trim(item)'Item',serl

FROM [dbo].LN_WHLTC500
--where OSER=2 --and QHND<>0

) a where  InventoryDetails_Subsidiaries.company =a.compnr and  trim(InventoryDetails_Subsidiaries.Item)=a.item 
and  trim(InventoryDetails_Subsidiaries.OrderNum)=a.OrderNum




--alter table InventoryDetails_Subsidiaries add FabNo nvarchar(50)


--******Temporarily Commented as yet to load the Table TTEIDM101ALL ********
--Update inventorydetails set Revision=c.REVI
--from (select * from 
--(select company,ITEM,EITM,REVI,DEIC,ROW_NUMBER() over(partition by company,ITEM--,EITM,REVI 
--order by DEIC desc) as ItemRnk 
--from (select * from TTEIDM101ALL where DEIC<=getdate()-1)a
--)b
--where ItEmRnk=1)c
--where inventorydetails.COMPANY=c.COMPANY
--and ltrim(rtrim(inventorydetails.ITEM))=ltrim(rtrim(c.ITEM))

--Update inventorydetails set Revision=c.REVI
--from (select * from 
--(select company,ITEM,EITM,REVI,DEIC,ROW_NUMBER() over(partition by company,ITEM--,EITM,REVI 
--order by DEIC desc) as ItemRnk 
--from (select * from TTEIDM101ALL where company=400 and DEIC<=getdate()-1)a
--)b
--where ItEmRnk=1)c
--where ltrim(rtrim(inventorydetails.ITEM))=ltrim(rtrim(c.ITEM))
--and inventorydetails.COMPANY between 401 and 465



--update InventoryDetails set LeanType=a.sops
--from (select * from TZZPUR049ALL where company in (select company from ELGI_Companies_Master where CompanyGroup='ELGI'))a
--where InventoryDetails.COMPANY=a.COMPANY
--and ltrim(rtrim(InventoryDetails.ITEM))=ltrim(rtrim(a.ITEM))


update InventoryDetails_subsidiaries set LeanType='TWO BIN' where LeanType='1'
update InventoryDetails_subsidiaries set LeanType='MULTI BIN' where LeanType='2'
update InventoryDetails_subsidiaries set LeanType='MILK RUN' where LeanType='3'
update InventoryDetails_subsidiaries set LeanType='MILKRUN MOTORS' where LeanType='4'
update InventoryDetails_subsidiaries set LeanType='MILK RUN(1)' where LeanType='5'
update InventoryDetails_subsidiaries set LeanType='SINGLE BIN' where LeanType='6'
update InventoryDetails_subsidiaries set LeanType='NVC' where LeanType is null


update InventoryDetails_subsidiaries set InvTypeOrder=1 where InvType= 'RM'
update InventoryDetails_subsidiaries set InvTypeOrder=2 where InvType= 'WIP'
update InventoryDetails_subsidiaries set InvTypeOrder=3 where InvType= 'FG'
update InventoryDetails_subsidiaries set InvTypeOrder=10 where InvType is null


--Alter table InventoryDetails add VerticalOrder int
update InventoryDetails_subsidiaries set VerticalOrder=1 where vertical='Channel'
update InventoryDetails_subsidiaries set VerticalOrder=2 where vertical='Direct'
update InventoryDetails_subsidiaries set VerticalOrder=3 where vertical='C&M'
update InventoryDetails_subsidiaries set VerticalOrder=4 where vertical='WW'
update InventoryDetails_subsidiaries set VerticalOrder=5 where vertical='RLY'
update InventoryDetails_subsidiaries set VerticalOrder=5.01 where vertical='OFSAC'
update InventoryDetails_subsidiaries set VerticalOrder=5.02 where vertical='After Market'

update InventoryDetails_subsidiaries set VerticalOrder=6 where vertical='GSC'
update InventoryDetails_subsidiaries set VerticalOrder=7 where vertical='SAAME'
update InventoryDetails_subsidiaries set VerticalOrder=8 where vertical='Cosea'
update InventoryDetails_subsidiaries set VerticalOrder=9 where vertical='ID'
update InventoryDetails_subsidiaries set VerticalOrder=10 where vertical='America'
update InventoryDetails_subsidiaries set VerticalOrder=11 where vertical='Europe'

update InventoryDetails_subsidiaries set VerticalOrder=12 where vertical='R&D'
update InventoryDetails_subsidiaries set VerticalOrder=13 where vertical='PMMO'
update InventoryDetails_subsidiaries set VerticalOrder=14 where vertical='SRN'
update InventoryDetails_subsidiaries set VerticalOrder=15 where vertical='Traded'
update InventoryDetails_subsidiaries set VerticalOrder=16 where vertical='PVD'
--update InventoryDetails set VerticalOrder=18 where vertical='PVD'
update InventoryDetails_subsidiaries set VerticalOrder=19 where vertical='Rotair Parts'
update InventoryDetails_subsidiaries set VerticalOrder=20 where vertical='Planning'

update InventoryDetails_subsidiaries set VerticalOrder=21 where vertical='Sauer'
update InventoryDetails_subsidiaries set VerticalOrder=22 where vertical='Foundry'
update InventoryDetails_subsidiaries set VerticalOrder=23 where vertical='Vacuum'


update InventoryDetails_subsidiaries set IsNonMoving ='Yes' 
--where DATEDIFF(dd,IssueDate,getdate()-1)>180 -- OLD METHOD
where concat(COMPANY,CWAR,ltrim(rtrim(item))) in 
(Select distinct concat(COMPANY,CWAR,ltrim(rtrim(item))) from Inventory_subs_AcrossCompany_Issue_Manipulation)

update InventoryDetails_subsidiaries set ageingdays=datediff(dd,TRDT,getdate()-1) 

update InventoryDetails_subsidiaries set Ageing='0-30' where datediff(dd,TRDT,getdate()-1) <30
update InventoryDetails_subsidiaries set Ageing='30-60' where datediff(dd,TRDT,getdate()-1) between 30 and 60
update InventoryDetails_subsidiaries set Ageing='61-90' where datediff(dd,TRDT,getdate()-1) between 61 and 90
update InventoryDetails_subsidiaries set Ageing='91-120' where datediff(dd,TRDT,getdate()-1) between 91 and 120
update InventoryDetails_subsidiaries set Ageing='121-150' where datediff(dd,TRDT,getdate()-1) between 121 and 150
update InventoryDetails_subsidiaries set Ageing='151-180' where datediff(dd,TRDT,getdate()-1) between 151 and 180
update InventoryDetails_subsidiaries set Ageing='181-365' where datediff(dd,TRDT,getdate()-1) between 181 and 365
update InventoryDetails_subsidiaries set Ageing='1-2 years' where datediff(dd,TRDT,getdate()-1) between 366 and 730
update InventoryDetails_subsidiaries set Ageing='2-3 years' where datediff(dd,TRDT,getdate()-1) between 731 and 1095
update InventoryDetails_subsidiaries set Ageing='3-4 years' where datediff(dd,TRDT,getdate()-1) between 1096 and 1460
update InventoryDetails_subsidiaries set Ageing='4-5 years' where datediff(dd,TRDT,getdate()-1) between 1460 and 1826
update InventoryDetails_subsidiaries set Ageing='5-6 years' where datediff(dd,TRDT,getdate()-1) between 1827 and 2192
update InventoryDetails_subsidiaries set Ageing='>6 years' where datediff(dd,TRDT,getdate()-1) > 2192


update InventoryDetails_subsidiaries set AgeingOrdr=1 where Ageing='0-30'
update InventoryDetails_subsidiaries set AgeingOrdr=2 where Ageing='30-60'
update InventoryDetails_subsidiaries set AgeingOrdr=3 where Ageing='61-90'
update InventoryDetails_subsidiaries set AgeingOrdr=4 where Ageing='91-120'
update InventoryDetails_subsidiaries set AgeingOrdr=5 where Ageing='121-150'
update InventoryDetails_subsidiaries set AgeingOrdr=6 where Ageing='151-180'
update InventoryDetails_subsidiaries set AgeingOrdr=7 where Ageing='181-365'
update InventoryDetails_subsidiaries set AgeingOrdr=8 where Ageing='1-2 years'
update InventoryDetails_subsidiaries set AgeingOrdr=12 where Ageing='2-3 years'
update InventoryDetails_subsidiaries set AgeingOrdr=13 where Ageing='3-4 years'
update InventoryDetails_subsidiaries set AgeingOrdr=14 where Ageing='4-5 years'
update InventoryDetails_subsidiaries set AgeingOrdr=15 where Ageing='5-6 years'
update InventoryDetails_subsidiaries set AgeingOrdr=16 where Ageing='>0 years'
update InventoryDetails_subsidiaries set AgeingOrdr=100 where Ageing ='NA'


update InventoryDetails_subsidiaries set Region ='USA' where company like '31%'
update InventoryDetails_subsidiaries set Region ='Europe' where company in  ('1100','1700')
update InventoryDetails_subsidiaries set Region ='Brazil' where company ='2000'

update InventoryDetails_subsidiaries set RegionOrder=1 where Region ='USA'
update InventoryDetails_subsidiaries set RegionOrder=2 where Region ='Europe'
update InventoryDetails_subsidiaries set RegionOrder=2 where Region ='Brazil'




if exists ( select * from Inventory_subs_History where CalYear=year(getdate()-1) and CalMonth=month(getdate()-1))
begin
delete from Inventory_subs_History where CalYear=year(getdate()-1) and CalMonth=month(getdate()-1)
delete from InventoryDetails_subs_History where CalYear=year(getdate()-1) and CalMonth=month(getdate()-1)
end

Insert into InventoryDetails_subs_History(COMPANY,CWAR,ITEM,ItemDescr,TRDT,SEQN,INWP,QSKT,Amnt,
Ageing,AgeingOrdr,stock_955,Cumulative_stk,Remarks,OrderType,QSTK,IssueDate,Amnt2,Amnt3,
CITG,CITG_desc,INVType,ItemType,RecptType,LedgerCode,LedgerDesc,SuppCode,SuppName,
BuyerCode,BuyerName,LeanType,Vertical,InvTypeOrder,Amnt4,CompName,VerticalOrder,
FrtRate,TargetRnk,TargetDays,CITM,CDSCA,ORDT,PDNO,PONO,QRDR,WQTY,WAMT,UPDT,CalYear,CalMonth,MultiplyFactor,Category,
Duty,WLOC,Revision,IsNonMoving,VARI,DEMCLASS,category2,TargetValue,PLMT,Currency,INR_Conv_Rate,Amnt4_INR,
Region,RegionOrder,ItemCategory_SOP,Productgroup_SOP,RRS)
select COMPANY,CWAR,ITEM,ItemDescr,TRDT,SEQN,INWP,QSKT,Amnt,
Ageing,AgeingOrdr,stock_955,Cumulative_stk,Remarks,OrderType,QSTK,IssueDate,Amnt2,Amnt3,
CITG,CITG_desc,INVType,ItemType,RecptType,LedgerCode,LedgerDesc,SuppCode,SuppName,
BuyerCode,BuyerName,LeanType,Vertical,InvTypeOrder,Amnt4,CompName,VerticalOrder,
FrtRate,TargetRnk,TargetDays,CITM,CDSCA,ORDT,PDNO,PONO,QRDR,WQTY,WAMT,UPDT,
year(getdate()-1) as CalYear,month(getdate()-1) as CalMonth,MultiplyFactor,Category,
Duty,WLOC,Revision,IsNonMoving,VARI,DEMCLASS,category2,TargetValue,PLMT,Currency,INR_Conv_Rate,Amnt4_INR,
Region,RegionOrder,ItemCategory_SOP,Productgroup_SOP,RRS
from InventoryDetails_subsidiaries



Insert into Inventory_subs_History
--select * into Inventory_History from (
select COMPANY,InvTypeOrder,INVType,VerticalOrder,Vertical,CompName,
sum(isnull(TargetDays,0)) TargetDays,
sum(isnull(Amnt4,0)) as Amnt4,
year(getdate()-1) as CalYear,
month(getdate()-1) as CalMonth,
null as FinYear,
null as FinMonth,
null as Sales_Amount,
null as ActualDays
from inventorydetails_subsidiaries
--where CompName is not null
group by COMPANY,InvTypeOrder,INVType,VerticalOrder,Vertical,CompName
--)a
order by COMPANY,InvTypeOrder,VerticalOrder,CompName


----set @Finyear =case when @monthnum<4 then @year-1 else @year end
----set @Finmonthnum =case when @monthnum<4 then @monthnum+9 else @monthnum-3 end


update Inventory_subs_History set Finyear=CalYear-1 where CalMonth<4
update Inventory_subs_History set Finyear=CalYear where CalMonth>=4

update Inventory_subs_History set FinMonth=CalMonth+9 where CalMonth<4
update Inventory_subs_History set FinMonth=CalMonth-3 where CalMonth>=4

--update Inventory_History set Sales_amount=null

----*******Temporarily Commneted as Sales Table yet to be worked *********
--update Inventory_subs_History set Sales_amount=a.Sales_amount
--from (select c.[Description] as descr,
--sum(Sales_amount) Sales_amount,
----sum(case when cal_year=year(getdate()-1) and cal_Month=month(getdate()-1) then Sales_amount/day(getdate()-1)
----else Sales_amount end
----) Sales_amount,
--cal_year,cal_Month from ELGi_Sales_Details a
--left JOIN vw_AREA_MASTER b
--ON b.AreaCode = a.areacode
--left JOIN vw_DPST_MASTER c 
--ON c.DpstCode = a.Dpst  
--WHERE	(c.Description IN ('Compressor-RLY','After Sales', 'Compressor-WW','Compressor-C&M', 'Compressor-Channel', 'Compressor-Direct')) 
--and sales_category not in (1)
--and Invoice_Date>='2019-06-01'
--group by c.Description,cal_year,cal_Month
--)a
--where ltrim(rtrim(Inventory_History.Vertical))=substring(ltrim(rtrim(a.descr)),12,20)
--and Inventory_History.CalYear=a.cal_year
--and Inventory_History.CalMonth=a.cal_Month



--update Inventory_History set Sales_amount=a.Sales_amount
--from (select b.Organ,
--sum(Sales_amount) Sales_amount,
----sum(case when cal_year=year(getdate()-1) and cal_Month=month(getdate()-1) then Sales_amount/day(getdate()-1)
----else Sales_amount end
----) Sales_amount,
--cal_year,cal_Month from ELGi_Sales_Details a
--left JOIN vw_SALESMAPPING_MASTER b
--on a.dpst=b.DPSTCode
--and a.areacode=b.Areacode
--where sales_category not in (1)
--and Invoice_Date>='2019-06-01'
--and b.organ<>'India'
--and ltrim(rtrim(a.user_names)) not in ('GULF TO CUST - UNITS','GULF TO CUST - SPARES')
--and ltrim(rtrim(a.Division)) not in ('AUSTRALIA TO CUST','CHINA','INDONESIA TO CUST')
--group by b.Organ,cal_year,cal_Month
--)a
--where ltrim(rtrim(Inventory_History.Vertical))=ltrim(rtrim(a.Organ))
--and Inventory_History.CalYear=a.cal_year
--and Inventory_History.CalMonth=a.cal_Month


--update Inventory_History set Sales_amount=a.Sales_amount
--from (
--select cal_year,cal_Month,sum(Sales_amount) Sales_amount from (
--select c.[Description] as descr,
--sum(Sales_amount) Sales_amount,
----sum(case when cal_year=year(getdate()-1) and cal_Month=month(getdate()-1) then Sales_amount/day(getdate()-1)
----else Sales_amount end
----) Sales_amount,
--cal_year,cal_Month from ELGi_Sales_Details a
--left JOIN vw_AREA_MASTER b
--ON b.AreaCode = a.areacode
--left JOIN vw_DPST_MASTER c 
--ON c.DpstCode = a.Dpst  
--WHERE	ltrim(rtrim(c.Description)) IN ('Compressor-RLY','After Sales', 'Compressor-WW','Compressor-C&M', 'Compressor-Channel', 'Compressor-Direct',
--'After Sales')
--and sales_category not in (1)
--and Invoice_Date>='2019-06-01'
--group by c.Description,cal_year,cal_Month

--union

--select b.Organ,
--sum(Sales_amount) Sales_amount,
----sum(case when cal_year=year(getdate()-1) and cal_Month=month(getdate()-1) then Sales_amount/day(getdate()-1)
----else Sales_amount end
----) Sales_amount,
--cal_year,cal_Month from ELGi_Sales_Details a
--left JOIN vw_SALESMAPPING_MASTER b
--on a.dpst=b.DPSTCode
--and a.areacode=b.Areacode
--where sales_category not in (1)
--and Invoice_Date>='2019-06-01'
--and b.organ<>'India'
--and ltrim(rtrim(a.user_names)) not in ('GULF TO CUST - UNITS','GULF TO CUST - SPARES')
--and ltrim(rtrim(a.Division)) not in ('AUSTRALIA TO CUST','CHINA','INDONESIA TO CUST')
--group by b.Organ,cal_year,cal_Month

--)a1
--group by cal_year,cal_Month
--)a
--where 
----ltrim(rtrim(Inventory_History.Vertical))=ltrim(rtrim(a.Organ)) and 
--Inventory_History.CalYear=a.cal_year
--and Inventory_History.CalMonth=a.cal_Month
--and Inventory_History.Sales_Amount is null


-----Target days updation for Total

--delete from Inventory_History where invtype like '%Total%'
--delete from Inventory_History where Vertical like '%Total%'


--Insert into Inventory_History (InvTypeOrder,INVType,VerticalOrder,Vertical,CompName,Amnt4,
--CalYear,CalMonth,FinYear,FinMonth,Sales_Amount)
--select 
--InvTypeOrder,InvType,VerticalOrder,a.Vertical,'Total' as CompName,
--sum(Amnt4) Amnt4,
--a.CalYear,a.CalMonth,FinYear,FinMonth,
--max(sales_amount) as Sales_Amount
--from 
--(select 1.1 as InvTypeOrder,'RM-Total' as InvType,
--VerticalOrder,Vertical,
--sum(isnull(Amnt4,0)) Amnt4,
--CalYear,CalMonth,FinYear,FinMonth,
--max(sales_amount) as sales_amount
--from Inventory_History 
--where INVType='RM'
--and CompName is not null
--group by VerticalOrder,Vertical,FinYear,FinMonth,CalYear,CalMonth
--)a
--group by a.InvTypeOrder,a.InvType,VerticalOrder,a.Vertical,a.CalYear,a.CalMonth,a.FinYear,a.FinMonth


--Insert into Inventory_History (InvTypeOrder,INVType,VerticalOrder,Vertical,CompName,Amnt4,
--CalYear,CalMonth,FinYear,FinMonth,Sales_Amount)
--select InvTypeOrder,InvType,VerticalOrder,a.Vertical,'Total' as CompName,
--sum(Amnt4) Amnt4,
--a.CalYear,a.CalMonth,FinYear,FinMonth,
--max(sales_amount) as Sales_Amount
--from 
--(select 2.1 as InvTypeOrder,'WIP-Total' as InvType,
--VerticalOrder,Vertical,
--sum(Amnt4) Amnt4,
--CalYear,CalMonth,FinYear,FinMonth,
--max(sales_amount) as sales_amount
--from Inventory_History 
--where INVType='WIP'
--and CompName is not null
--group by VerticalOrder,Vertical,FinYear,FinMonth,CalYear,CalMonth
--)a
--group by a.InvTypeOrder,a.InvType,VerticalOrder,a.Vertical,a.CalYear,a.CalMonth,a.FinYear,a.FinMonth



--Insert into Inventory_History (InvTypeOrder,INVType,Amnt4,
--CalYear,CalMonth,FinYear,FinMonth,Sales_Amount)
--select InvTypeOrder,InvType,
--sum(Amnt4) Amnt4,
--CalYear,CalMonth,FinYear,FinMonth,
--max(sales_amount) as Sales_Amount
--from 
--(select 3.1 as InvTypeOrder,'FG-Total' as InvType,
--VerticalOrder,Vertical,
--sum(TargetDays) TargetDays,
--sum(Amnt4) Amnt4,
--CalYear,CalMonth,FinYear,FinMonth,
--max(sales_amount) as sales_amount
--from Inventory_History 
--where INVType='FG'
--and CompName is not null
--group by InvTypeOrder,InvType,VerticalOrder,Vertical,FinYear,FinMonth,CalYear,CalMonth
--)a
--group by InvTypeOrder,InvType,CalYear,CalMonth,FinYear,FinMonth



--Insert into Inventory_History (InvTypeOrder,INVType,VerticalOrder,Vertical,Amnt4,
--CalYear,CalMonth,FinYear,FinMonth,Sales_Amount)
--select 
--InvTypeOrder,InvType,VerticalOrder,a.Vertical,
--sum(Amnt4) Amnt4,
--a.CalYear,a.CalMonth,FinYear,FinMonth,
--max(sales_amount2) as Sales_Amount
--from 
--(select InvTypeOrder,InvType,
--5.10 as VerticalOrder,'India-Total' as Vertical,
--sum(case when vertical in ('Channel','Direct','C&M','WW','RLY','OFSAC','After Market') then Amnt4 end ) Amnt4,
--CalYear,CalMonth,FinYear,FinMonth,
--sum(case when vertical in ('Channel','Direct','C&M','WW','RLY','OFSAC','After Market') then sales_amount end) as sales_amount2
--from Inventory_History 
--where INVType='FG'
--and CompName is not null
--group by InvTypeOrder,InvType,FinYear,FinMonth,CalYear,CalMonth
--)a
--group by InvTypeOrder,InvType,VerticalOrder,a.Vertical,a.Vertical,a.CalYear,a.CalMonth,a.FinYear,a.FinMonth



--Insert into Inventory_History (InvTypeOrder,INVType,VerticalOrder,Vertical,Amnt4,
--CalYear,CalMonth,FinYear,FinMonth,Sales_Amount)
--select 
--InvTypeOrder,InvType,VerticalOrder,a.Vertical,
--sum(Amnt4) Amnt4,
--a.CalYear,a.CalMonth,FinYear,FinMonth,
--max(sales_amount) as Sales_Amount
--from 
--(select InvTypeOrder,InvType,
--11.1 as VerticalOrder,'Exports-Total' as Vertical,
--sum(case when vertical in ('SAAME','Cosea','ID','America','Europe')  then Amnt4 end ) Amnt4,
--CalYear,CalMonth,FinYear,FinMonth,
--max(sales_amount) as sales_amount
--from Inventory_History 
--where INVType='FG'
--and CompName is not null
--group by InvTypeOrder,InvType,FinYear,FinMonth,CalYear,CalMonth
--)a
--group by InvTypeOrder,InvType,VerticalOrder,a.Vertical,a.Vertical,a.CalYear,a.CalMonth,a.FinYear,a.FinMonth



--Insert into Inventory_History (InvTypeOrder,INVType,VerticalOrder,Vertical,Amnt4,
--CalYear,CalMonth,FinYear,FinMonth,Sales_Amount)
--select 
--InvTypeOrder,InvType,VerticalOrder,a.Vertical,
--sum(Amnt4) Amnt4,
--a.CalYear,a.CalMonth,FinYear,FinMonth,
--max(sales_amount) as Sales_Amount
--from 
--(select InvTypeOrder,InvType,
--23.1 as VerticalOrder,'Others-Total' as Vertical,--Vertical,
----sum(case when vertical not in ('Channel','Direct','C&M','WW','RLY','OFSAC','After Market','GSC','SAAME','Cosea','ID','America','Europe')  then Amnt4 end ) Amnt4,
--sum(case when vertical in ('R&D','PMMO','SRN','Traded','PVD','Rotair Parts','Sauer','Foundry','Vacuum')  then Amnt4 end ) Amnt4,
--CalYear,CalMonth,FinYear,FinMonth,
--max(sales_amount) as sales_amount
--from Inventory_History 
--where INVType='FG'
--and CompName is not null
--group by InvTypeOrder,InvType,VerticalOrder,Vertical,FinYear,FinMonth,CalYear,CalMonth
--)a
--group by InvTypeOrder,InvType,VerticalOrder,a.Vertical,a.CalYear,a.CalMonth,a.FinYear,a.FinMonth


--update Inventory_History set TargetDays=a.TargetDays
--from (select * from Inventory_Targetdays_Master where invtype like '%TOTAL%' 
--and CalYear=year(getdate()-1)
--and CalMonth=month(getdate()-1)
--)a
--where Inventory_History.calyear=a.calyear
--and Inventory_History.calmonth=a.calmonth
--and Inventory_History.invtype=a.invtype
--and Inventory_History.Vertical is null


--update Inventory_History set TargetDays=a.TargetDays
--from (select * from Inventory_Targetdays_Master where vertical like '%TOTAL%' 
--and CalYear=year(getdate()-1)
--and CalMonth=month(getdate()-1)
--)a
--where Inventory_History.calyear=a.calyear
--and Inventory_History.calmonth=a.calmonth
--and Inventory_History.invtype=a.invtype
--and Inventory_History.vertical=a.vertical

--update Inventory_History set ActualDays=(Amnt4/(Sales_Amount + 0.001))*30

--update Inventory_History set ActualDays=(Amnt4/(((Sales_Amount + 0.001)/day(getdate()-1))*30))*30
--where CalYear=year(getdate()-1) and CalMonth=month(getdate()-1)


----Since New warehouses are added frequently, access if not given manually for full access users,
----those inventory transactions will not be accessible by them in their Detailed Inventory report.
----Also there will be a mismatch between Summary report and Detailed Report in their point of view.
----in order to eliminate this below logic is implemented.

--Truncate table Elgi_Inv_FullAccess

--Insert into Elgi_Inv_FullAccess
----select * into Elgi_Inv_FullAccess from(
--select userid,row_number() over(order by userid) as Rnk from ELGi_InvData_Access
----where userid like '%elgi\roberts%'
--group by Userid
--having count(*)>100
----)a

--declare @Count1 int=1
--declare @TotalCount int
--declare @userid varchar(50)

--set @TotalCount=(select count(userid) from Elgi_Inv_FullAccess)

--while (@Count1<=@TotalCount)
--begin

--set @userid=(select userid from Elgi_Inv_FullAccess where Rnk=@Count1)

--insert into ELGi_InvData_Access
--select distinct company,CWAR,@userid from InventoryDetails
--where concat(COMPANY,CWAR) not in (
--select concat(Company,Warehouse) from ELGi_InvData_Access
--where userid =@userid)
--and company like '4%'

--set @Count1=@Count1+1

--end 



----Non Moving InventoryTable  Updation

----select * from InventoryDetails

----Alter table Inventory_AcrossCompany_Issue_Manipulation add InvTypeOrder	int
----Alter table Inventory_AcrossCompany_Issue_Manipulation add INVType	varchar(50)
----Alter table Inventory_AcrossCompany_Issue_Manipulation add CompName	varchar(50)
----Alter table Inventory_AcrossCompany_Issue_Manipulation add VerticalOrder	int
----Alter table Inventory_AcrossCompany_Issue_Manipulation add Vertical	varchar(50)


update Inventory_subs_AcrossCompany_Issue_Manipulation set InvTypeOrder=a.InvTypeOrder,INVType=a.INVType
from (select distinct company,CWAR,ITEM,InvTypeOrder,INVType,CompName,
VerticalOrder,Vertical from InventoryDetails_subsidiaries)a
where Inventory_subs_AcrossCompany_Issue_Manipulation.COMPANY=a.COMPANY
and Inventory_subs_AcrossCompany_Issue_Manipulation.CWAR=a.CWAR
and ltrim(rtrim(Inventory_subs_AcrossCompany_Issue_Manipulation.ITEM))=ltrim(rtrim(a.ITEM))

update Inventory_subs_AcrossCompany_Issue_Manipulation set compname=a.CompName,
Vertical=a.Vertical,VerticalOrder=a.VerticalOrder
from (select distinct company,CWAR,ITEM,InvTypeOrder,INVType,CompName,
VerticalOrder,Vertical from InventoryDetails_subsidiaries)a
where Inventory_subs_AcrossCompany_Issue_Manipulation.COMPANY=a.COMPANY
and Inventory_subs_AcrossCompany_Issue_Manipulation.CWAR=a.CWAR
and ltrim(rtrim(Inventory_subs_AcrossCompany_Issue_Manipulation.ITEM))=ltrim(rtrim(a.ITEM))

update Inventory_subs_AcrossCompany_Issue_Manipulation set LastUpdateDate=getdate()-1


----------------------------------------------------------------


--if exists (select * from ACP_Daily_Inventory_Trend where month(EntryDate)<>month(convert(date,getdate()-1)))
--begin 
--Truncate table ACP_Daily_Inventory_Trend
--end


--if exists (select * from ACP_Daily_Inventory_Trend where EntryDate=convert(date,getdate()-1))
--begin 
--Delete from ACP_Daily_Inventory_Trend where EntryDate=convert(date,getdate()-1)
--end

--insert into ACP_Daily_Inventory_Trend(Category2,TargetValue,Amnt4,Status,EntryDate)
----select * into ACP_Daily_Inventory_Trend from (
--select Category2,avg(TargetValue) TargetValue,sum(Amnt4/1000000) Amnt4,
--(sum(Amnt4/1000000)/avg(TargetValue))*100 as Status,convert(date,getdate()-1) as EntryDate
--from InventoryDetails
--where company=450
--and Category2 is not null
--and Invtype <>'RM'
--group by Category2
----)a



end

select * from InventoryDetails_subsidiaries

--select CompName,sum(Amnt4) Amnt4 from InventoryDetails where INVType like '%wip%' and WAMT is null
--group by CompName




select top 1 * from InventoryDetails_subsidiaries

GO

