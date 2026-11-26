
CREATE VIEW [dbo].[vw_sls_IAS] as   

select
a.Dpst,
a.ItemCode,a.ItemDesc,sum(a.Sales_amount) as Sales_amount,
--Product_Group,Type, --To be commented
sum(CASE WHEN day(a.invoice_date)=day(getdate()-1)and month(a.invoice_date)=month(getdate()-1)
and year(a.invoice_date)=year(getdate()-1)THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS ondate_sale,

SUM(CASE WHEN a.Invoice_Date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end )) 
AND 
'03/31/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1)-1 else year(getdate()-1) end ))
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS last_year_sale, 

SUM(CASE WHEN a.Invoice_Date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end )) 
AND 
dateadd(yy, - 1, dateadd(dd, - 1, getdate())) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS last_year_ytd, 

SUM(CASE WHEN a.Invoice_Date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND 
getdate() 
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS this_year_sale,   

SUM(CASE WHEN a.Invoice_Date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 4 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND 
dateadd(dd, - 1, CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy,dateadd(dd, - 1, getdate()))) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS last_month_sale,

SUM(CASE WHEN a.Invoice_Date BETWEEN 
 CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy,dateadd(yy,-1, dateadd(dd, - 1, getdate()))) 
AND 
 dateadd(yy,-1,dateadd(dd, - 1, convert(date,getdate())))
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS last_year_this_month_sale,


SUM(CASE WHEN a.Invoice_Date BETWEEN 
CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())) 
AND 
getdate() 
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS this_month_sale,

SUM(CASE WHEN a.Invoice_Date BETWEEN  
dateadd(mm, - 3, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))   
AND 
dateadd(dd, - 1, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate()))) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END)AS thr_month_sale,

SUM(CASE WHEN a.Invoice_Date BETWEEN  
dateadd(mm, - 1, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))    
AND 
dateadd(dd, - 1, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate()))) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END)AS n1_month_sale,

SUM(CASE WHEN a.Invoice_Date BETWEEN  
dateadd(mm, - 2, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))   
AND 
dateadd(dd,-1,dateadd(mm, - 1, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) +'/1/' + datename(yy, dateadd(dd, - 1, getdate())))) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END)AS n2_month_sale,

SUM(CASE WHEN a.Invoice_Date BETWEEN  
dateadd(mm, - 3, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))   
AND 
dateadd(dd,-1,dateadd(mm, - 2, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) +'/1/' + datename(yy, dateadd(dd, - 1, getdate())))) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END)AS n3_month_sale


FROM 	
(
select a.Dpst,
a.ItemCode,a.ItemDesc,a.Invoice_Date,sum(a.Sales_amount) as Sales_amount
--,b.Product_Group,b.Type --To be commented
from
(
select Company,CustCode,CustName,AreaCode,AreaName,
Dpst,
OrderNum,PositionNum,TranType,InvDate as Invoice_Date,InvNo,
sum(OrderQty) OrderQty,--sum(BudQty) BudQty,
sum(DeliveredQty) DeliveredQty,sum(UnitPrice) UnitPrice,sum(SalesValue) Sales_amount,
REFA,REFB,CPAY,odat,CCUR,CREP,CFCG,DDAT,ItemCode,ItemDesc
from
(
select a.Company,a.CustCode,c.CustName1 as CustName,c.custareacode as AreaCode,e.AreaName,
a.Dpst,
a.OrderNum,b.PositionNum,
b.t_invd as InvDate,b.invnum as InvNo,b.TranType,b.t_qoor as OrderQty,
--b.BQUA as BudQty,
b.t_qidl as DeliveredQty,
b.Price as UnitPrice,(b.t_qidl*b.Price) as SalesValue,a.REFA,a.REFB,
a.PaymentTerm as cpay,a.OrderDate as ODAT,a.Currency as  CCUR,a.SalesRep as CREP,
c.FinCustGrp as CFCG,b.DeliveryDate as DDAT,b.ItemCode,d.ItemDesc
from 
(select * from Sales_Header where company=951)a
left outer join (select * from Sales_Lines where company=951)b
on a.OrderNum=b.OrderNum
left outer join (select * from vw_Business_Partner_IAS)c
on a.CustCode=c.custcode
left outer join (select distinct item,ltrim(rtrim(DSCA)) as ItemDesc from TTCIBD001951)d
on ltrim(rtrim(b.ItemCode))=ltrim(rtrim(d.ITEM))
left outer join vw_AREA_MASTER e
on c.custareacode=e.AreaCode
--where b.invnum is not null
)a
group by Company,CustCode,CustName,AreaCode,AreaName,Dpst,
OrderNum,PositionNum,InvDate,InvNo,TranType,REFA,REFB,CPAY,odat,CCUR,CREP,CFCG,DDAT,ItemCode,ItemDesc


union

select '951' as Company,a.t_itbp as CUNO,c.custname1,c.CustAreaCode,null as AreaName,
Dpst,
t_orno as ordernum,null as Positionnum,t_ttyp,
a.t_docd,a.t_ninv,
null as orderQty,--null as BudQty,
null as DeliveredQty,null as unitprice,t_amth_1,
t_refr,null as refb,t_cpay,
a.t_docd as orderdate,
t_ccur,t_crep,null as cfcg,null as ddat,
null as itemcode,null as Itemdescr
from 
(select a.t_itbp,c.Dpst,
a.t_ttyp,a.t_docd,a.t_docn,a.t_ninv,a.t_amth_1,
a.t_orno,a.t_refr,a.t_cpay,a.t_ccur,a.t_crep
from TTFACR200ALL a
left outer join Sales_Lines b
on a.Company=b.Company
and a.t_ttyp=b.Trantype
and a.t_ninv=b.invnum
left outer join Sales_Header c
on b.Company =c.Company 
and ltrim(rtrim(b.OrderNum))=ltrim(rtrim(c.OrderNum))
where a.company=951
) a
left outer join (select * from vw_Business_Partner_IAS)c
on a.t_itbp=c.custcode
where t_ttyp='csr' and a.t_docn=0
)a

--below table To be commented
--left outer join Item_Master_IAS b
--on ltrim(rtrim(a.ItemCode))=ltrim(rtrim(b.ItemCode))


--left outer join DPST_Master_IAS c


group by a.Dpst,
a.ItemCode,a.ItemDesc,a.Invoice_Date
--,b.Product_Group,b.Type --To be commented
)a
group by a.Dpst, 
ItemCode,ItemDesc
--,Product_Group,Type  --To be commented

GO

