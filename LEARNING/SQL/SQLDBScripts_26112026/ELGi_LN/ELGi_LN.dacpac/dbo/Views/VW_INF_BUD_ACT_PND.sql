CREATE  VIEW [dbo].[VW_INF_BUD_ACT_PND]
AS

select Organ,Vertical1,zone,company,trantype,warehouse,OrderNum,PositionNum,
ltrim(Rtrim(ItemCode))as Item,Item_desc,custcode,custname,dpst,dpstname,areacode,areaname,ordertype,
sum(qty) as Ord_Qty,0 as Delqty,0 as Pendqty,
SUM(CASE WHEN CONVERT(DATE,OrderDate)= convert(date,getdate()-1) THEN SALES ELSE 0 END) AS FTD_INFLOW,

SUM(CASE WHEN CONVERT(DATE,OrderDate) BETWEEN (dateadd(d,-day(getdate()-1),convert(date,getdate()))) AND (DATEADD(M,+1,dateadd(d,-day(getdate()),convert(date,getdate()))))THEN SALES ELSE 0 END) AS MTD_INFLOW,

SUM(CASE WHEN CONVERT(DATE,OrderDate)  BETWEEN '04/01/' + convert(varchar,(case when month(getdate()-1) <4 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND getdate()-1  THEN sales ELSE 0 END) AS YTD_INFLOW ,

0 as FTD_SALES,0 as MTD_SALES,0 as YTD_SALES,0 as Pending  From Sales_Inflow 	--where Organ ='india'
where organ in ('SAAME','ISAAME','ID','Subsidiary','COSEA','India')
group by  Organ,Vertical1,zone,company,trantype,warehouse,OrderNum,PositionNum,
ltrim(Rtrim(ItemCode)),Item_desc,custcode,custname,dpst,
dpstname,areacode,areaname,ordertype




union all

select Organ,Vertical1,zone,company,trantype,warehouse,OrderNo,PositionNo,
ltrim(Rtrim(item))as Item,Item_desc,custcode,custname,dpst,dpstname,areacode,areaname,SaleOrderType,
0 as Ord_Qty,sum(DeliveryQty) as Delqty,0 as Pendqty,0,0,0,

SUM(CASE WHEN CONVERT(DATE,Invoice_Date)= convert(date,getdate()-1) THEN Sales_amount  ELSE 0 END) AS FTD_SALES,

SUM(CASE WHEN CONVERT(DATE,Invoice_Date) BETWEEN (dateadd(d,-day(getdate()-1),convert(date,getdate())))AND(DATEADD(M,+1,dateadd(d,-day(getdate()),convert(date,getdate()))))
THEN Sales_amount ELSE 0 END) AS MTD_SALES,

SUM(CASE WHEN CONVERT(DATE,Invoice_Date)  BETWEEN '04/01/' + convert(varchar,(case when month(getdate()-1) <4 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND getdate()-1  THEN Sales_amount ELSE 0 END) AS YTD_SALES ,

0 as Pending From ELGi_Sales_Details 
where organ in('SAAME','ISAAME','ID','Subsidiary','COSEA','India')
and convert(date,invoice_date)>='2017-04-01'
group by Organ,Vertical1,zone,company,trantype,warehouse,OrderNo,PositionNo,
ltrim(Rtrim(item)),Item_desc,custcode,custname,dpst,dpstname,areacode,areaname,SaleOrderType

GO

