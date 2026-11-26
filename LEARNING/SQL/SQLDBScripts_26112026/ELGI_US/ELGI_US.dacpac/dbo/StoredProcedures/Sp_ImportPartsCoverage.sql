CREATE proc [dbo].[Sp_ImportPartsCoverage]  as 
begin
--alter table ImportPartsCoverage add Region nvarchar(50)
Truncate table ImportPartsCoverage

----------------------------------STEP 1- Stock , Regular, Consignment stock-------------------------------------------------

-----Australia Stock ------

Insert into ImportPartsCoverage (Region,ItemCode,ItemDesc,Stock,Regular) 

select 
	case when company='551' then 'Australia' end 'Region',ltrim(rtrim(item)) 'Itemcode',ItemDescr,sum(qskt) 'StockQty' 
	,sum(qskt)'Regular'
	from [elgi_ln].dbo.Inventorydetails 	
	where company in ('551')
    group by region,ltrim(rtrim(item)),ItemDescr,Company


-----Brazil Stock ------

Insert into ImportPartsCoverage (Region,ItemCode,ItemDesc,Stock,Regular) 


select distinct case  when a.compnr=2000 then'Brazil' end Region
,ltrim(rtrim(a.item)) 'Itemcode',b.dsca as 'ItemDescr',SUM(c.stock) 'Stock_Qty',sum(c.stock) 'Regular'

from [ELGI_US].dbo.LN_whwmd215 a

left join  [ELGI_US].dbo.LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item, ' ','') and b.compnr=2000

left join (select replace(a.item, ' ','')'Item',a.compnr,sum(a.qskt) 'stock',sum(b.amnt_1)'StockVal',a.cwar
	from  [ELGI_US].dbo.LN_whina112 a
	left join  [ELGI_US].dbo.LN_whina113 b on b.compnr=a.compnr
			and replace(b.item, ' ','')=replace(a.item, ' ','') and b.cwar=a.cwar and b.trdt=a.trdt and b.seqn=1
--where  a.qskt>0
	group by replace(a.item, ' ',''),a.compnr,a.cwar)
	c on c.item=replace(a.item, ' ','') and c.compnr=a.compnr

WHERE  a.compnr in (2000) -- and replace(b.item,' ','')='S015601'
GROUP BY a.compnr,ltrim(rtrim(a.item)),b.dsca

-----Europe Stock ------

INSERT INTO ImportPartsCoverage (Region,ItemCode,ItemDesc,Stock,Regular,Consignment)

select Region,item,Itemdescr,sum(stock)'Stock' ,sum(stock_qty_regular) 'Regular', sum(stock_qty_consignment) 'Consignment' from (

SELECT DISTINCT CASE  WHEN LEFT(c.cwar, 2) IN ('17', 'CB', 'CO', 'SC') THEN 'Europe'ELSE 'Rotair' END AS Region,
Ltrim(rtrim(a.item)) 'Item',b.dsca 'Itemdescr',c.stock 'Stock',
CASE WHEN C.CWAR IN ('170001','SC0985') THEN c.stock END Stock_Qty_REGULAR,
CASE WHEN C.cwar NOT IN ('170001','SC0985','170992','SC0986','170995') THEN C.Stock END Stock_Qty_CONSIGNMENT
FROM [ELGI_US].dbo.LN_whwmd215 a
LEFT JOIN [ELGI_US].dbo.LN_tcibd001 b ON REPLACE(b.item, ' ', '') = REPLACE(a.item, ' ', '') AND b.compnr = 1100

LEFT JOIN (
            SELECT REPLACE(a.item, ' ', '') AS Item,a.compnr,SUM(a.qskt) AS Stock,SUM(b.amnt_1) AS StockVal,a.cwar
            FROM [ELGI_US].dbo.LN_whina112 a
            LEFT JOIN [ELGI_US].dbo.LN_whina113 b ON b.compnr = a.compnr
               AND REPLACE(b.item, ' ', '') = REPLACE(a.item, ' ', '') AND b.cwar = a.cwar  AND b.trdt = a.trdt AND b.seqn = 1
          --  WHERE a.qskt > 0
            GROUP BY 
                REPLACE(a.item, ' ', ''), a.compnr, a.cwar
        ) c 
            ON c.Item = REPLACE(a.item, ' ', '') 
           AND c.compnr = a.compnr
WHERE 
--c.stock > 0  AND 
LEFT(c.cwar, 2) IN ('17', 'CB', 'CO', 'SC') and c.cwar NOT IN ('170981') and a.compnr IN (1100)
group by CASE  WHEN LEFT(c.cwar, 2) IN ('17', 'CB', 'CO', 'SC') THEN 'Europe'ELSE 'Rotair' END,
Ltrim(rtrim(a.item)),b.dsca,c.cwar,c.Stock
)a
group by region,Item,Itemdescr


-----USA Stock ------

--ALTER TABLE ImportPartsCoverage ADD Stock_Qty_110LAX FLOAT


INSERT INTO ImportPartsCoverage (Region,ItemCode,ItemDesc,Stock,Regular,Consignment,Stock_Qty_110LAX,Stock_Qty_110CLT)

select  region,Item,ITEMdesc,sum(stock_qty) 'Stock',
sum(Stock_Qty_Regular) 'Stock_Qty_Regular',
sum(Stock_Qty_Consignment) 'Stock_Qty_Consignment',
SUM(Stock_Qty_110LAX) 'Stock_Qty_110LAX',
SUM(Stock_Qty_110CLT) 'Stock_Qty_110CLT'


from 
(
select distinct 'USA' Region,
replace(a.item, ' ','') 'Item',b.dsca  'ItemDesc',c.stock 'Stock_Qty',
case when c.cwar in ('110CLT','110LAX') then c.stock end 'Stock_Qty_Regular',
case when c.cwar in ('110VAL','110REP','110SDW','110TRD') then c.stock end 'Stock_Qty_Others',
case when c.cwar not in ('110CLT','110LAX','110VAL','110REP','110SDW','110TRD') then c.stock end 'Stock_Qty_Consignment',
case when c.cwar in ('110CLT') then c.stock end 'Stock_Qty_110CLT',
case when c.cwar in ('110LAX') then c.stock end 'Stock_Qty_110LAX',


case when c.cwar in ('110CLT','110LAX') then c.StockVal end 'Stock_Val_regular',
case when c.cwar in ('110VAL','110REP','110SDW','110TRD') then c.StockVal end 'Stock_Val_Others',
case when c.cwar not in ('110CLT','110LAX','110VAL','110REP','110SDW','110TRD') then c.StockVal end 'Stock_Val_Consignment'

from [ELGI_US].dbo.LN_whwmd215 a
left join [ELGI_US].dbo.LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item, ' ','') and b.compnr=3100

left join (select replace(a.item, ' ','')"Item",a.compnr,
	sum(a.qskt) "stock",sum(b.amnt_1)"StockVal",a.cwar
	from [ELGI_US].dbo.LN_whina112 a
	left join [ELGI_US].dbo.LN_whina113 b on b.compnr=a.compnr
			and replace(b.item, ' ','')=replace(a.item, ' ','') and b.cwar=a.cwar and b.trdt=a.trdt and b.seqn=1
		--	where  a.qskt>0
	group by replace(a.item, ' ',''),a.compnr,a.cwar)
	c on c.item=replace(a.item, ' ','') and c.compnr=a.compnr
where
--c.stock>0 and
 a.compnr in (3110)  
) a

group by region,Item,ItemDesc
order by Item

----------------------------------STEP 2- Update Transit Details-------------------------------------------------

update ImportPartsCoverage set TotalTransit=a.DelQty  from 

(
select region, itemcode, sum(DeliveredQty) 'DelQty' from (
select COMP,[TRAN],idoc,REQN, CUNO,NAMA,CCTY,CONA,CCUR,FORW,VESL,DEST,ETD,atd,ATA,ETA,b.ItemCode,b.Item_desc
,sum(b.DeliveredQty) 'DeliveredQty',blad 'BOL',BODT'BOL Date',convert(date,idat)'Inv Date',sum(convert(decimal(18,2),b.AssesValue))'Line Value'
,sum(sales_usd) 'sales_usd',rate_usd'rate_usd',b.Currency 'currency',sum(b.t_rate_1)'t_rate_1',sum(b.Foreign_currency_amount)'Foreign_currency_amount',
c.t_refb,b.OrderNum,b.order_Date,b.areacode,
case when ccty= 'USA' then 'USA'
	 when ccty in ('BEL') then 'Europe'
	 when ccty='BRA' then 'Brazil'
	 When ccty='Aus' then 'Australia'
end Region

from elgi_ln.dbo.TZZSLS336ALL a
left join elgi_ln.dbo.sales_report_LN b on b.company=a.COMP and b.trantype=a.[TRAN] and b.Invoice=a.idoc
left join elgi_ln.dbo.TTDSLS400ALL c on c.company=a.COMP and c.t_orno=b.OrderNum and c.t_ofbp=b.CustCode
where convert(date,idat)>'20240401' and convert(date,ata)='99990101'--and CUNO='CU1E00625'  and 
group by COMP,[TRAN],idoc,REQN, CUNO,NAMA,CCTY,CONA,CCUR,FORW,VESL,DEST,ETD,atd,ATA,ETA,CONA,b.ItemCode,b.Item_desc,BLAD,BODT,convert(date,idat),
c.t_refb,b.OrderNum,b.order_Date,b.areacode,b.Currency,b.rate_usd
--order by REQN asc 

)a 
where region is not null 
group by Region,ItemCode
) a where ImportPartsCoverage.Region=a.Region and ImportPartsCoverage.ItemCode=a.ItemCode


----------------------------------STEP 3- Update Open Order & WEEK SPLIT FOR OPEN ORDERS UPTO 20 WEEKS-------------------------------------------------

----- Australia OPEN OERDR ------

update ImportPartsCoverage set TotalPendingOrder=a.openqty, 
 POw1=a.w1,POW2=a.W2,POW3=a.W3,POW4=a.W4,POW5=a.w5,POW6=a.W6,POW7=a.W7,POW8=a.W8,POW9=a.w9,POW10=a.W10
,POW11=A.W11
from ( 

select areaname 'Region',itemcode,sum(pendQty) 'OpenQty',
sum(w1) 'W1',SUM(W2) 'W2',SUM(W3)'W3',SUM(W4)'W4',SUM(W5) 'W5',SUM(W6)'W6',
SUM(W7) 'W7',SUM(W8) 'W8',SUM(W9) 'W9',SUM(W10) 'W10', sum(w11)'W11'
from 
(select *
From (
select currency,areacode,areaname,company,dpst,dpstname,PositionNum,OrderNum,ordertype,
origin,Baan_orderno ,Baan_positionno,DeliveryDate,ItemCode,Item_desc,TaxCode,Price,
DiscPerc1,buyer,Indent ,OrderDate,CustCode,Custname,t_rats_1,
sum(value)as value,sum(ord_qty_new)ord_qty,sum(delqty)delqty,
sum(PendQty)as pendQty,sum(ShipQty)as ShipQty,sum(t_oamt) as t_oamt,plan_del_date,
   -- SUM(CASE WHEN convert(date,plan_del_date) ='99990101' THEN pendQty ELSE 0 END) AS ETANotGiven,
 --   SUM(CASE WHEN convert(date,Plan_del_Date) < convert(date,getdate()) THEN pendQty ELSE 0 END) AS ETACrossed,
  -- SUM(CASE WHEN convert(date,Plan_del_Date) >= convert(date,getdate()) and DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 0 THEN pendQty ELSE 0 END) AS W1,

--As informed , before = today will be considered as week1 
 
     SUM(CASE WHEN convert(date,Plan_del_Date) <= convert(date,getdate()) 
	 or DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 0  THEN pendQty ELSE 0 END) AS W1,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 1 THEN pendQty ELSE 0 END) AS W2,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 2 THEN pendQty ELSE 0 END) AS W3,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 3 THEN pendQty ELSE 0 END) AS W4,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 4 THEN pendQty ELSE 0 END) AS W5,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 5 THEN pendQty ELSE 0 END) AS W6,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 6 THEN pendQty ELSE 0 END) AS W7,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 7 THEN pendQty ELSE 0 END) AS W8,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 8 THEN pendQty ELSE 0 END) AS W9,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 9 THEN pendQty ELSE 0 END) AS W10,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) >= 10 THEN pendQty ELSE 0 END) AS 'W11'
  
from (select *,ord_qty-isnull(cancel_qty,0) as ord_qty_new 
From elgi_ln.dbo.pending_orders where company in (490,401) --where OrderNum ='236001180'and PositionNum=10
)a
group by currency,areacode,areaname,dpst,dpstname,PositionNum,OrderNum,ordertype,
origin,Baan_orderno ,Baan_positionno,DeliveryDate,ItemCode,Item_desc,TaxCode,Price,
DiscPerc1,buyer ,OrderDate,CustCode,Custname,Indent,company,t_rats_1,plan_Del_date
)a
where pendQty >0 and areacode ='631'

)A
--where CONVERT(DATE,OrderDate) between'2017-07-01' and '2017-07-19'

group by ItemCode,areaname


)a where ImportPartsCoverage.Region=a.Region and ImportPartsCoverage.ItemCode=a.ItemCode


----- BRAZIL OPEN OERDR ------


update ImportPartsCoverage set TotalPendingOrder=a.openqty,
 POw1=a.w1,POW2=a.W2,POW3=a.W3,POW4=a.W4,POW5=a.w5,POW6=a.W6,POW7=a.W7,POW8=a.W8,POW9=a.w9,POW10=a.W10
,POW11=A.W11
--,POW12=A.W12,POW13=A.W13,POW14=A.W14,POW15=A.W15,POW16=A.W16,POW17=A.W17,POW18=A.W18,POW19=A.W19,POW20=A.W20
--,POETACrossed=a.ETACrossed, POETANotGiven=a.ETANotGiven

from ( 
select region,itemcode, sum(openQty) 'OpenQty',

  --SUM(CASE WHEN convert(date,plan_del_date) ='99990101' THEN OpenQty ELSE 0 END) AS ETANotGiven,
  --  SUM(CASE WHEN convert(date,Plan_del_Date) < convert(date,getdate()) THEN OpenQty ELSE 0 END) AS ETACrossed,
  -- SUM(CASE WHEN convert(date,Plan_del_Date) >= convert(date,getdate()) and DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 0 THEN OpenQty ELSE 0 END) AS W1,

  
--As informed , before = today will be considered as week1 
 
     SUM(CASE WHEN convert(date,Plan_del_Date) <= convert(date,getdate()) 
	 or DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 0  THEN openQty ELSE 0 END) AS W1,

    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 1 THEN OpenQty ELSE 0 END) AS W2,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 2 THEN OpenQty ELSE 0 END) AS W3,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 3 THEN OpenQty ELSE 0 END) AS W4,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 4 THEN OpenQty ELSE 0 END) AS W5,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 5 THEN OpenQty ELSE 0 END) AS W6,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 6 THEN OpenQty ELSE 0 END) AS W7,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 7 THEN OpenQty ELSE 0 END) AS W8,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 8 THEN OpenQty ELSE 0 END) AS W9,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 9 THEN OpenQty ELSE 0 END) AS W10,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) >= 10 THEN OpenQty ELSE 0 END) AS W11


from (

select  'Brazil' region,a.compnr,
dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))) as odat,replace(a.item,' ','')"ItemCode",b.dsca,a.orno,pono,sqnb,a.cwar,a.clyn,c.refa,c.sotp,c.refb ,
case when c.refa like '%SO#%' then 'Take StockOrder' else 'LN Order' end "Type"
,a.pric,pror_KW,chrq_kw ,a.oamt,CONVERT(DATE,dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,a.ddta2)))) 'Plan_Del_Date',
YEAR (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat))))'CalYear',MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat))))'CalMonth'
,c.hdst_kw,
case when YEAR (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2)))) <4 
     then YEAR (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))-1 
     else YEAR (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2)))) end 'FinYear',
case when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=1 then 10
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=2 then 11
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=3 then 12
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=4 then 1
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=5 then 2
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=6 then 3
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=7 then 4
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=8 then 5
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=9 then 6
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=10 then 7
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=11 then 8
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=12 then 9
else 0 
end 'FinMonth',format(convert(datetime,c.odat),'MMM-yyyy') 'Month-Year',
qoor,qidl,qbbo,(a.qoor-a.qidl-qbbo)'openQty',(((a.qoor-a.qidl-qbbo)*a.pric)-amld)'OpenPrice',g.nama,b.cpln,amld


from LN_tdsls401 a 
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='2000' and b.deleted='N'
left join LN_tdsls400 c on c.compnr=a.compnr and c.orno=a.orno and c.deleted='N' 
left join LN_TCCom100 g on g.bpid=c.ofbp  and g.deleted='N' and g.compnr='2000'
where a.compnr='2000'
and a.deleted='N'   and a.qidl=0
and isnull(sotp,'-')<>'-' 
and a.clyn=2 and c.hdst_kw not in ('tdsls.hdst.cancelled','tdsls.hdst.closed') and isnull(YEAR(c.odat),'')<>''
and c.clyn=2  
and  CONCAT(a.compnr,a.orno,pono,a.sqnb) not in  (select concat(a.compnr,a.orno,pono,a.sqnb) from  LN_TDSLS406 a)
)a 

group by region,ItemCode

)a where ImportPartsCoverage.Region=a.Region and ImportPartsCoverage.ItemCode=a.ItemCode


----- EUROPE OPEN OERDR ------

update ImportPartsCoverage set TotalPendingOrder=a.openqty,
 POw1=a.w1,POW2=a.W2,POW3=a.W3,POW4=a.W4,POW5=a.w5,POW6=a.W6,POW7=a.W7,POW8=a.W8,POW9=a.w9,POW10=a.W10
,POW11=A.W11
--,POW12=A.W12,POW13=A.W13,POW14=A.W14,POW15=A.W15,POW16=A.W16,POW17=A.W17,POW18=A.W18,POW19=A.W19,POW20=A.W20
--,POETACrossed=a.ETACrossed, POETANotGiven=a.ETANotGiven




from ( 
select Region, itemcode,sum(openQty) 'OpenQty',
  --SUM(CASE WHEN convert(date,plan_del_date) ='99990101' THEN OpenQty ELSE 0 END) AS ETANotGiven,
  --  SUM(CASE WHEN convert(date,Plan_del_Date) < convert(date,getdate()) THEN OpenQty ELSE 0 END) AS ETACrossed,
  -- SUM(CASE WHEN convert(date,Plan_del_Date) >= convert(date,getdate()) and DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 0 THEN OpenQty ELSE 0 END) AS W1,
  
--As informed , before = today will be considered as week1 
 
     SUM(CASE WHEN convert(date,Plan_del_Date) <= convert(date,getdate()) 
	 or DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 0  THEN OpenQty ELSE 0 END) AS W1,
  
  SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 1 THEN OpenQty ELSE 0 END) AS W2,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 2 THEN OpenQty ELSE 0 END) AS W3,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 3 THEN OpenQty ELSE 0 END) AS W4,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 4 THEN OpenQty ELSE 0 END) AS W5,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 5 THEN OpenQty ELSE 0 END) AS W6,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 6 THEN OpenQty ELSE 0 END) AS W7,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 7 THEN OpenQty ELSE 0 END) AS W8,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 8 THEN OpenQty ELSE 0 END) AS W9,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) = 9 THEN OpenQty ELSE 0 END) AS W10,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.Plan_del_Date) >= 10 THEN OpenQty ELSE 0 END) AS W11


from (

select distinct case when
b.cpln<>'L02' then'Rotair' when 
b.cpln='L02' then'Europe' else 'Rotair' end
Region,
dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))) as odat,replace(a.item,' ','')"ItemCode",b.dsca,a.orno,pono,sqnb,a.cwar,a.clyn,c.refa,c.sotp,c.refb ,
case when c.refa like '%SO#%' then 'Take StockOrder' else 'LN Order' end "Type"
,a.pric,pror_KW,chrq_kw ,a.oamt,dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,a.ddta2))) as 'Plan_Del_Date'
,YEAR (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))'CalYear',MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))'CalMonth'
,c.hdst_kw,
case when YEAR (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2)))) <4 
     then YEAR (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))-1 
     else YEAR (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2)))) end 'FinYear',
 case when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=1 then 10
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=2 then 11
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=3 then 12
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=4 then 1
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=5 then 2
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=6 then 3
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=7 then 4
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=8 then 5
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=9 then 6
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=10 then 7
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=11 then 8
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=12 then 9
else 0 
end 'FinMonth',format(convert(datetime,dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2)))),'MMM-yyyy') 'Month-Year',
qoor,qidl,(a.qoor-a.qidl-qbbo)'openQty',(((a.qoor-a.qidl-qbbo)*a.pric)-amld)'OpenPrice',g.nama,b.cpln,amld
from LN_tdsls401 a 
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='1100' and b.deleted='N'
left join LN_tdsls400 c on c.compnr=a.compnr and c.orno=a.orno and c.deleted='N'
left join LN_TCCom100 g on g.bpid=c.ofbp  and g.deleted='N'
where a.compnr in('1100','1700') and a.deleted='N' and (a.qoor-a.qidl-qbbo)>0 and isnull(sotp,'-')<>'-' 
and a.clyn=2 and c.hdst_kw<>'tdsls.hdst.cancelled' and isnull(YEAR(c.odat2),'')<>''
)a
where Region = 'Europe'
group by Region,ItemCode
)a where ImportPartsCoverage.Region=a.Region and ImportPartsCoverage.ItemCode=a.ItemCode

----- USA OPEN OERDR ------

update ImportPartsCoverage set TotalPendingOrder=a.openqty ,
 POw1=a.w1,POW2=a.W2,POW3=a.W3,POW4=a.W4,POW5=a.w5,POW6=a.W6,POW7=a.W7,POW8=a.W8,POW9=a.w9,POW10=a.W10,POW11=A.W11


from ( 
select distinct 'USA' Region,ItemCode, sum(openqty) 'OpenQty',
  --SUM(CASE WHEN convert(date,DelDate) ='99990101' THEN OpenQty ELSE 0 END) AS ETANotGiven,
  --  SUM(CASE WHEN convert(date,DelDate) < convert(date,getdate()) THEN OpenQty ELSE 0 END) AS ETACrossed,
  -- SUM(CASE WHEN convert(date,DelDate) >= convert(date,getdate()) and DATEDIFF(WEEK, GETDATE(), DelDate) = 0 THEN OpenQty ELSE 0 END) AS W1,

--As informed , before = today will be considered as week1 
 
     SUM(CASE WHEN convert(date,DelDate) <= convert(date,getdate()) 
	 or DATEDIFF(WEEK, GETDATE(), DelDate) = 0  THEN OpenQty ELSE 0 END) AS W1,


    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), DelDate) = 1 THEN OpenQty ELSE 0 END) AS W2,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), DelDate) = 2 THEN OpenQty ELSE 0 END) AS W3,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), DelDate) = 3 THEN OpenQty ELSE 0 END) AS W4,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), DelDate) = 4 THEN OpenQty ELSE 0 END) AS W5,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), DelDate) = 5 THEN OpenQty ELSE 0 END) AS W6,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), DelDate) = 6 THEN OpenQty ELSE 0 END) AS W7,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), DelDate) = 7 THEN OpenQty ELSE 0 END) AS W8,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), DelDate) = 8 THEN OpenQty ELSE 0 END) AS W9,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), DelDate) = 9 THEN OpenQty ELSE 0 END) AS W10,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), DelDate) >= 10 THEN OpenQty ELSE 0 END) AS W11


from [US_OpenOrder] where compnr='3110' 
group by compnr,ItemCode
)a where ImportPartsCoverage.Region=a.Region and ImportPartsCoverage.ItemCode=a.ItemCode



----------------------------------STEP 4- ETA DATE WEEKWISE-------------------------------------------------

--ALTER TABLE ImportPartsCoverage ADD W20 FLOAT


update ImportPartsCoverage set w1=a.w1,W2=a.W2,W3=a.W3,W4=a.W4,W5=a.w5,W6=a.W6,W7=a.W7,W8=a.W8,W9=a.w9,W10=a.W10
,W11=A.W11
--,W12=A.W12,W13=A.W13,W14=A.W14,W15=A.W15,W16=A.W16,W17=A.W17,W18=A.W18,W19=A.W19,W20=A.W20
--,ETACrossed=a.ETACrossed, ETANotGiven=a.ETANotGiven

from ( 

 
select region,ItemCode, sum(w1) 'W1',SUM(W2) 'W2',SUM(W3)'W3',SUM(W4)'W4',SUM(W5) 'W5',SUM(W6)'W6',
SUM(W7) 'W7',SUM(W8) 'W8',SUM(W9) 'W9',SUM(W10) 'W10', sum(w11)'W11'

from ( 
select COMP,[TRAN],idoc,REQN, CUNO,NAMA,CCTY,CONA,CCUR,FORW,VESL,DEST,ETD,atd,ATA,ETA,b.ItemCode,b.Item_desc
,sum(b.DeliveredQty) 'DeliveredQty',blad 'BOL',BODT'BOL Date',convert(date,idat)'Inv Date',sum(convert(decimal(18,2),b.AssesValue))'Line Value'
,sum(sales_usd) 'sales_usd',rate_usd'rate_usd',b.Currency 'currency',sum(b.t_rate_1)'t_rate_1',sum(b.Foreign_currency_amount)'Foreign_currency_amount',
c.t_refb,b.OrderNum,b.order_Date,b.areacode,
case when ccty= 'USA' then 'USA'
	 when ccty ='BEL' then 'Europe'
	 when ccty='BRA' then 'Brazil'
	 When ccty='Aus' then 'Australia'
end Region,
   -- SUM(CASE WHEN convert(date,eta) ='99990101' THEN DeliveredQty ELSE 0 END) AS ETANotGiven,
   -- SUM(CASE WHEN convert(date,eta) < convert(date,getdate()) THEN DeliveredQty ELSE 0 END) AS ETACrossed,
   --SUM(CASE WHEN convert(date,eta) >= convert(date,getdate()) and DATEDIFF(WEEK, GETDATE(), a.ETA) = 0 THEN DeliveredQty ELSE 0 END) AS W1,
   
--As informed , before = today will be considered as week1 
 
     SUM(CASE WHEN convert(date,ETA) <= convert(date,getdate()) 
	 or DATEDIFF(WEEK, GETDATE(), a.ETA) = 0  THEN DeliveredQty ELSE 0 END) AS W1,

    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.ETA) = 1 THEN DeliveredQty ELSE 0 END) AS W2,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.ETA) = 2 THEN DeliveredQty ELSE 0 END) AS W3,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.ETA) = 3 THEN DeliveredQty ELSE 0 END) AS W4,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.ETA) = 4 THEN DeliveredQty ELSE 0 END) AS W5,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.ETA) = 5 THEN DeliveredQty ELSE 0 END) AS W6,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.ETA) = 6 THEN DeliveredQty ELSE 0 END) AS W7,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.ETA) = 7 THEN DeliveredQty ELSE 0 END) AS W8,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.ETA) = 8 THEN DeliveredQty ELSE 0 END) AS W9,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.ETA) = 9 THEN DeliveredQty ELSE 0 END) AS W10,
    SUM(CASE WHEN DATEDIFF(WEEK, GETDATE(), a.ETA) >= 10 THEN DeliveredQty ELSE 0 END) AS W11



from elgi_ln.dbo.TZZSLS336ALL a
left join elgi_ln.dbo.sales_report_LN b on b.company=a.COMP and b.trantype=a.[TRAN] and b.Invoice=a.idoc
left join elgi_ln.dbo.TTDSLS400ALL c on c.company=a.COMP and c.t_orno=b.OrderNum and c.t_ofbp=b.CustCode
where convert(date,idat)>'20240401' and convert(date,ata)='99990101'
--and convert(date,eta) >=convert(date,getdate())--and CUNO='CU1E00625'  and 
group by COMP,[TRAN],idoc,REQN, CUNO,NAMA,CCTY,CONA,CCUR,FORW,VESL,DEST,ETD,atd,ATA,ETA,CONA,b.ItemCode,b.Item_desc,BLAD,BODT,convert(date,idat),
c.t_refb,b.OrderNum,b.order_Date,b.areacode,b.Currency,b.rate_usd
)a
where region is not null
--and ItemCode='B008706030003'

 GROUP BY REGION,ItemCode
-- ORDER BY ETA
)a where ImportPartsCoverage.Region=a.Region and ImportPartsCoverage.ItemCode=a.ItemCode

----------------------------------STEP 5- UCD UPDATION, DFUCode, India_TPL-------------------------------------------------

--ALTER TABLE ImportPartsCoverage add Variant nvarchar(150)



update ImportPartsCoverage set DFUCode=a.Demand_Forecasting_Unit_DFU, INDIATpl=a.India_TPL,
Model=a.Model,ItemCategory=a.Item_Category,ProductGroup= a.Product_group,HP=a.HP,KW= a.KW, Variant= a.Variant

from  (

select distinct REGION,Item,Demand_Forecasting_Unit_DFU,India_TPL,Model,Item_Category, Product_group,HP, KW,  Variant from ELGi_SOP.DBO.TPL_MASTER_REF
)a WHERE ImportPartsCoverage.ItemCode=A.ITEM and ImportPartsCoverage.Region=a.region


--alter table importpartscoverage add L12M float

--alter table ImportPartsCoverage add UCD_NextMonth2 float

------------UCD CurrentMonth--------

update ImportPartsCoverage set UCD_CurrentMonth =a.ucd from (

select  region,LTRIM(RTRIM(TPL_CODE)) 'Item',sum(unconstrained_demand) 'UCD',dfu,sum(last_3months) 'L3M',
sum(last_6_months) 'L6M',sum(last_year_sales) 'L12M',pilot,month,year

from ELGi_SOP.dbo.tbl_collaboration_tool 
where 
-- Match pilot dynamically based on month
pilot = 4 + DATEDIFF(
            MONTH,
            DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1),
            DATEFROMPARTS([year],[month],1)
        )
and [month]=month(getdate()-1)  and [year]=year(getdate()-1)
--and PILOT = (SELECT MAX(PILOT) FROM ELGi_SOP.dbo.tbl_collaboration_tool) 
group by region,LTRIM(RTRIM(TPL_CODE)),dfu,pilot,month,year

) a WHERE ImportPartsCoverage.indiatpl=A.ITEM and ImportPartsCoverage.Region=a.region

-----------UCD CUrrentMonth+1


update ImportPartsCoverage set UCD_NextMonth =a.ucd from (

select  region,LTRIM(RTRIM(TPL_CODE)) 'Item',sum(unconstrained_demand) 'UCD',dfu,sum(last_3months) 'L3M',
sum(last_6_months) 'L6M',sum(last_year_sales) 'L12M',pilot,month,year

from ELGi_SOP.dbo.tbl_collaboration_tool 
where 
-- Match pilot dynamically based on month
pilot = 4 + DATEDIFF(
            MONTH,
            DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1),
            DATEFROMPARTS([year],[month],1)
        )
and [month]=month(getdate()-1)+1  and [year]=year(getdate()-1)
--and PILOT = (SELECT MAX(PILOT) FROM ELGi_SOP.dbo.tbl_collaboration_tool) 
group by region,LTRIM(RTRIM(TPL_CODE)),dfu,pilot,month,year

) a WHERE ImportPartsCoverage.indiatpl=A.ITEM and ImportPartsCoverage.Region=a.region


-----------UCD CUrrentMonth+2


update ImportPartsCoverage set UCD_NextMonth2 =a.ucd from (

select  region,LTRIM(RTRIM(TPL_CODE)) 'Item',sum(unconstrained_demand) 'UCD',dfu,sum(last_3months) 'L3M',
sum(last_6_months) 'L6M',sum(last_year_sales) 'L12M',pilot,month,year

from ELGi_SOP.dbo.tbl_collaboration_tool 
where 
-- Match pilot dynamically based on month
pilot = 4 + DATEDIFF(
            MONTH,
            DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1),
            DATEFROMPARTS([year],[month],1)
        )
and [month]=month(getdate()-1)+2  and [year]=year(getdate()-1)
--and PILOT = (SELECT MAX(PILOT) FROM ELGi_SOP.dbo.tbl_collaboration_tool) 
group by region,LTRIM(RTRIM(TPL_CODE)),dfu,pilot,month,year

) a WHERE ImportPartsCoverage.indiatpl=A.ITEM and ImportPartsCoverage.Region=a.region





--update ImportPartsCoverage set Maxdemand= a.maxvalue from (

--select region,itemcode,dfucode,(select max(v)  from (values (UCD),(L3M),(L6M),(L12M)) AS VALUE(v)) as MaxValue from ImportPartscoverage
--) a WHERE ImportPartsCoverage.Itemcode=a.itemcode and ImportPartsCoverage.Region=a.region




end

GO

