
CREATE procedure [dbo].[sp_inventorydetails_withinvfab]
As
Begin

Truncate table inventorydetails_withinvfab

Insert into inventorydetails_withinvfab  


Select a.*,
STRING_AGG(CAST( b.ORNO AS VARCHAR(MAX)), ', ') AS ORNO,STRING_AGG(CAST(c.Invoice AS VARCHAR(MAX)), ', ') AS Invoice,
STRING_AGG(
    CAST(COALESCE(d.serl, e.serl) AS VARCHAR(MAX)),
    ', '
) AS Fab,STRING_AGG(CAST(f.Inv_date AS VARCHAR(MAX)), ', ') AS Inv_date,Null as Ordernum,
NULL as Inviuce_num,NULL as Fab_num,NULL as Invoice_Date from (
select COMPANY,CWAR,ITEM,ItemDescr,TRDT,
sum(QSKT) QSKT,sum(Amnt4) Amnt4,	
sum(Amnt) Amnt,sum(Amnt2) Amnt2,sum(Amnt3) Amnt3,FrtRate,Duty,WLOC,
LedgerCode,LedgerDesc,INVType,CompName,Vertical,LeanType,SuppCode,SuppName,
BuyerCode,BuyerName,CITM,CDSCA,ORDT,PDNO,PONO,QRDR,WQTY,WAMT,UPDT,Category,
Revision,AgeingOrdr,Ageing,IsNonMoving,VARI,DEMCLASS,category2,TargetValue,
PLMT,PLMT1,Category3
from (
select COMPANY,CWAR,ITEM,ItemDescr,convert(date,TRDT) TRDT,
QSKT,Amnt4,
Amnt,Amnt2,Amnt3,FrtRate,Duty,WLOC,
--sum(QSKT) QSKT),sum(Amnt4) Amnt4,	
LedgerCode,LedgerDesc,INVType,CompName,Vertical,LeanType,SuppCode,SuppName,
BuyerCode,BuyerName,CITM,CDSCA,ORDT,PDNO,PONO,QRDR,WQTY,WAMT,UPDT,Category,
Revision,AgeingOrdr,Ageing,IsNonMoving,VARI,DEMCLASS,category2,TargetValue,
PLMT,PLMT1,Category3
from inventorydetails
where 
--company in (@Company)
--and CWAR in (@Warehouse)
--and INVType in (@InvType) and
 INVType not in ('Not considered')
)a
group by COMPANY,CWAR,ITEM,ItemDescr,TRDT,FrtRate,Duty,WLOC,
LedgerCode,LedgerDesc,INVType,CompName,Vertical,LeanType,SuppCode,SuppName,
BuyerCode,BuyerName,CITM,CDSCA,ORDT,PDNO,PONO,QRDR,WQTY,WAMT,UPDT,Category,
Revision,AgeingOrdr,Ageing,IsNonMoving,VARI,DEMCLASS,category2,TargetValue,
PLMT,PLMT1,Category3
--order by updt
)a

LEFT JOIN (Select Distinct COMPANY,CWAR,LTRIM(RTRIM(ITEM))'ITEM',convert(date,TRDT)'TRDT',ORNO from [TWHINR110ALL]) b 
on a.COMPANY = b.COMPANY and a.CWAR = b.CWAR and LTRIM(RTRIM(a.ITEM)) = b.ITEM
and convert(date,a.TRDT) = b.TRDT
LEFT JOIN (Select Distinct COMPANY,t_item,t_orno,concat(Company,t_tran,t_idoc)'Invoice' from TCISLI310ALL) c
on b.COMPANY = c.COMPANY and LTRIM(RTRIM(b.ITEM)) = LTRIM(RTRIM(c.t_item))
and b.ORNO = c.t_orno
LEFT JOIN TWHINH312ALL d
on b.company = d.company and LTRIM(RTRIM(b.ORNO)) = LTRIM(RTRIM(d.ORNO)) and 
LTRIM(RTRIM(b.ITEM)) = LTRIM(RTRIM(d.item)) and d.SERL is NOT NULL and d.SERL <> ' '
LEFT JOIN [TWHINH431ALL] e
on b.company = e.company and LTRIM(RTRIM(b.ORNO)) = LTRIM(RTRIM(e.WORN)) and 
LTRIM(RTRIM(b.ITEM)) = LTRIM(RTRIM(e.item)) and e.SERL is NOT NULL and e.SERL <> ' '
LEFT JOIN (Select Distinct company,t_tran,t_idoc,Convert(date,t_idat)'Inv_date' from tcisli305ALL) f on c.Invoice = concat(f.company,f.t_tran,f.t_idoc)

Group BY a.COMPANY,a.CWAR,a.ITEM,ItemDescr,a.TRDT,
QSKT,Amnt4,a.Amnt,Amnt2,Amnt3,FrtRate,Duty,WLOC,
LedgerCode,LedgerDesc,INVType,CompName,Vertical,LeanType,SuppCode,SuppName,
BuyerCode,BuyerName,CITM,CDSCA,ORDT,PDNO,a.PONO,QRDR,WQTY,WAMT,UPDT,Category,
Revision,AgeingOrdr,Ageing,IsNonMoving,VARI,DEMCLASS,category2,TargetValue,
PLMT,PLMT1,Category3


--Alter table inventorydetails_withinvfab
--Add Ordernum VARCHAR(MAX)

UPDATE inventorydetails_withinvfab
SET Ordernum =
(
    SELECT STRING_AGG(value, ', ')
    FROM
    (
        SELECT DISTINCT LTRIM(RTRIM(value)) AS value
        FROM STRING_SPLIT(a.ORNO, ',')
    ) d
)
FROM inventorydetails_withinvfab a;


UPDATE inventorydetails_withinvfab
SET Inviuce_num =
(
    SELECT STRING_AGG(value, ', ')
    FROM
    (
        SELECT DISTINCT LTRIM(RTRIM(value)) AS value
        FROM STRING_SPLIT(a.Invoice, ',')
    ) d
)
FROM inventorydetails_withinvfab a;

UPDATE inventorydetails_withinvfab
SET Fab_num =
(
    SELECT STRING_AGG(value, ', ')
    FROM
    (
        SELECT DISTINCT LTRIM(RTRIM(value)) AS value
        FROM STRING_SPLIT(a.Fab, ',')
    ) d
)
FROM inventorydetails_withinvfab a;

UPDATE inventorydetails_withinvfab
SET Invoice_Date =
(
    SELECT STRING_AGG(value, ', ')
    FROM
    (
        SELECT DISTINCT LTRIM(RTRIM(value)) AS value
        FROM STRING_SPLIT(a.Inv_date, ',')
    ) d
)
FROM inventorydetails_withinvfab a;


--Alter table inventorydetails_withinvfab
--Add Ordernum VARCHAR(MAX)

--Alter table inventorydetails_withinvfab
--Add Inviuce_num VARCHAR(MAX)

--Alter table inventorydetails_withinvfab
--Add Fab_num VARCHAR(MAX)

--Alter table inventorydetails_withinvfab
--Add Invoice_Date VARCHAR(MAX)

End

GO

