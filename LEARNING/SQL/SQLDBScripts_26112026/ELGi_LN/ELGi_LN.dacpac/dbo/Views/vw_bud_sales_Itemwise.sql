



CREATE view [dbo].[vw_bud_sales_Itemwise] as


select Organ,DPSTCode,DPSTName,AreaCode,AreaName,DealerCode,DealerName,
--line,
Category,ProductLine,
company,warehouse,ItemCode,
Cal_month,Cal_year,Fin_month,Fin_year,
sum(Budget) as Budget,
sum(Sales_amount) as Sales_amount,sum(Inflow_amount) as Inflow_amount
from (

select isnull(Budget.Organ,Sales.Organ) as Organ,
isnull(Budget.DPSTCode,Sales.DPSTcode) as DPSTCode,
isnull(Budget.DPSTName,Sales.DPSTName) as DPSTName,
isnull(Budget.Area,Sales.Areacode) as AreaCode,
isnull(Budget.areaname,Sales.Areaname) as AreaName,
dlr.DealerCode,dlr.DealerName,
--Assyline.line,
isnull(prd.Category,prd2.category) as Category, 
isnull(prd.ProductLine,prd2.productline) as ProductLine,
sales.company,sales.warehouse,
isnull(Budget.item_code,sales.item) as ItemCode,
isnull(Budget.CalMonth,sales.cal_Month) as Cal_month,
isnull(Budget.CalYear,Sales.cal_year) as Cal_year,
isnull(Budget.Fin_month,sales.Fin_month) as Fin_month,
isnull(Budget.Fin_year,sales.Fin_year) as Fin_year,
Budget.Budget,
Sales.Sales_amount,
Sales.Inflow_amount

from

(select 
ltrim(rtrim(b.Global)) as Global,
ltrim(rtrim(c.Organ)) as Organ,
ltrim(rtrim(c.region)) as region,
ltrim(rtrim(c.Zone)) as Zone,
ltrim(rtrim(c.user_names)) as user_names,
ltrim(rtrim(c.Division)) as Division,
ltrim(rtrim(c.Vertical1)) as Vertical1,
a.Area,ltrim(rtrim(c.areaname)) as areaname,
c.DPSTCode,c.DPSTName,
ltrim(rtrim(a.item_code)) as item_code,
month(a.date) as CalMonth,
year(a.date) as CalYear,
case when month(a.date) < 4 then month(a.date)+9 else month(a.date)-3 end Fin_month,
case when month(a.date) < 4 then year(a.date)-1 else year(a.date) end Fin_year,
sum(target) as Budget 

FROM	--Sales_Budget a
Itemwise_Budget a
	INNER JOIN vw_AREA_MASTER b
		ON ltrim(rtrim(b.AreaCode)) = ltrim(rtrim(a.Area))
	INNER JOIN vw_SALESMAPPING_MASTER c
		ON ltrim(rtrim(b.Areacode))=ltrim(rtrim(c.Areacode))    
		and ltrim(rtrim(a.Dpst)) = ltrim(rtrim(c.DPSTCode))

--where organ='COSEA'
GROUP BY ltrim(rtrim(b.Global)),ltrim(rtrim(c.Organ)),ltrim(rtrim(c.region)),ltrim(rtrim(c.Zone)),
ltrim(rtrim(c.user_names)),ltrim(rtrim(c.Division)),ltrim(rtrim(c.Vertical1)),
a.Area,ltrim(rtrim(c.areaname)),c.DPSTCode,c.DPSTName,a.item_code,month(a.date),year(a.date)
)Budget


full outer join 

(
select b.global,c.organ,c.region,c.Zone, c.user_names,c.Division,c.Vertical1,
a.custcode,b.Areacode,b.AreaName,d.Dpstcode,d.dpstname,d.Description,
a.company,a.warehouse,ltrim(rtrim(a.Item)) as Item ,a.Item_desc,a.cal_Month,a.cal_year,
a.Fin_month,a.Fin_year,sum(Sales_amount) as Sales_amount,
sum(inf.sales) as inflow_amount

FROM 	
ELGi_Sales_Details a 
	left outer JOIN vw_AREA_MASTER b ON ltrim(rtrim(b.AreaCode)) = ltrim(rtrim(a.areacode))
	left outer JOIN vw_SALESMAPPING_MASTER c
	ON 	ltrim(rtrim(b.Areacode))=ltrim(rtrim(c.Areacode)) 
	AND ltrim(rtrim(a.Dpst)) = ltrim(rtrim(c.DPSTCode))
	left outer join vw_DPST_MASTER d
	on ltrim(rtrim(d.DpstCode))=ltrim(rtrim(c.DPSTCode))

	full outer join Sales_Inflow inf
 on  a.company=inf.Company
 and a.OrderNo=inf.OrderNum
	AND A.PositionNo=inf.PositionNum
	and a.dpst=inf.Dpst
	and a.areacode=inf.AreaCode
	and month(a.Invoice_Date)=month(inf.OrderDate)
	and year(a.Invoice_Date)=year(inf.OrderDate)
	and ltrim(rtrim(a.custcode))=ltrim(rtrim(inf.CustCode))


WHERE	(a.Invoice_Date BETWEEN '04/01/2016' AND GETDATE()) 

AND a.SaleOrderType in (
select SaleOrderType from SaleType_Master where Sales_Category in (0,2,5,6)
union all
select '' as SaleOrderType from SaleType_Master
)
and a.sales_category not in (1)
AND (a.areacode IS NOT NULL) 
--and c.Organ='COSEA'
GROUP BY b.global,c.organ,c.region,c.Zone, c.user_names,c.Division,c.Vertical1,
a.custcode,b.Areacode,b.AreaName,d.Dpstcode,d.dpstname,d.Description,
a.company,a.warehouse,a.Item,a.Item_desc,
a.cal_Month,a.cal_year,a.Fin_month,a.Fin_year

)Sales

on isnull(budget.organ,'0')=isnull(Sales.organ,'0')
and isnull(Budget.DPSTCode,'0')=isnull(Sales.DPSTcode,'0')
and isnull(Budget.area,'0')=isnull(Sales.areacode,'0')
and isnull(Budget.item_code,'0')=isnull(Sales.item,'0')
and isnull(budget.fin_month,0)=isnull(Sales.Fin_month,0)
and isnull(budget.Fin_year,0)=isnull(Sales.Fin_year,0)

--left outer join vw_Sales_Inflow inf
--on  sales.company=inf.Company
--and ltrim(rtrim(isnull(Budget.item_code,Sales.Item)))=ltrim(rtrim(inf.ItemCode))
--and ltrim(rtrim(isnull(Budget.dpstcode,Sales.DPSTcode)))=ltrim(rtrim(inf.Dpst))
--and ltrim(rtrim(isnull(Budget.area,Sales.Areacode)))=ltrim(rtrim(inf.AreaCode))


--and ltrim(rtrim(isnull(Budget.item_code,Sales.Item)))=ltrim(rtrim(inf.ItemCode))
--and ltrim(rtrim(isnull(Budget.dpstcode,Sales.DPSTcode)))=ltrim(rtrim(inf.Dpst))
--and ltrim(rtrim(isnull(Budget.area,Sales.Areacode)))=ltrim(rtrim(inf.AreaCode))




--Method1 : Fetching Productgroup data from INTRANET 
--full outer join
--(select e.icode,e.line as linecode,f.line from (
--select *,case when Market='India and India Like' then 1
--when Market='Subsidiary' then 2 end as MarketID from
--(select *,case when itype=4 then 'Subsidiary' else 'India and India Like' end as Market from [ELGI-DW].dbo.TESFC087)temp) e
--left outer join (select distinct line,linevalue from [ELGI-DW].dbo.ALC_Line) f
--on ltrim(rtrim(f.linevalue))=ltrim(rtrim(e.line))
--)Assyline

--on ltrim(rtrim(isnull(Budget.item_code,Sales.Item)))=ltrim(rtrim(Assyline.icode))


--Method2 : Fetching Productgroup data from Onetime Manual File Load Table

full outer join ItemMaster_COSEA prd
on ltrim(rtrim(isnull(Budget.item_code,Sales.Item)))=ltrim(rtrim(prd.ItemCode))
and Sales.company=prd.Company

full outer join  Dealer_Master_COSEA dlr
on ltrim(rtrim(substring(sales.custcode,4,9)))=ltrim(rtrim(substring(dlr.DealerCode,4,9)))
and Sales.Areacode=dlr.CountryCode

left  outer join (select distinct ItemCode,category,productline from ItemMaster_COSEA) prd2
on ltrim(rtrim(Budget.item_code))=ltrim(rtrim(prd2.ItemCode))



)a

--For Testing Purpose
--where organ='COSEA' 
--and ltrim(rtrim(itemcode))='00021010D'
--and fin_year=2017
--and fin_month=5 
--and areacode='622' and dpstcode='90257'


group by Organ,DPSTCode,DPSTName,AreaCode,AreaName,DealerCode,DealerName,
--line,
Category,ProductLine,
company,warehouse,ItemCode,Cal_month,cal_year,Fin_month,Fin_year

GO

