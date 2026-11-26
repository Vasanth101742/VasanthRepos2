CREATE view [dbo].[vw_Sales_Inflow]
as
select 
h.Dpst,case when h.area is null or h.area=' ' then v.CustAreaCode else h.Area end as AreaCode,H.ordertype,h.RefA as Indent,
h.SlsPriceLst,l.DiscPerc1,l.DiscPerc2,l.DiscPerc3,
 L.Company,L.Trantype,L.invnum,L.OrderNum,convert(date,L.OrderDate) OrderDate,L.PositionNum,L.CustCode,L.ItemCode,
L.DeliveryDate,L.WareHouse,l.Price,
l.t_qoor  as qty,
--case when len(l.invnum)<2 then l.t_qoor  else l.t_qidl end as qty,
l.t_amld as discount,
(l.t_oamt* (case when h.t_rats_1=0 or h.t_rats_1 is null then 1 else h.t_rats_1 end)) as sales,
--h.t_oref as Segment,
--c.CHNL as Segment,
null as Segment, 
h.SalesRep as SalesRepCode,b.NAMA as SalesRep,h.LineOfBusiness as LOBCode,a.DSCA as LineOfBusiness,
h.DeliveryTerms,
null as Sales_USD,
l.t_oamt as Foreign_currency_amount,
h.Currency,
h.ForwardAgent,
h.PaymentTerm,
h.t_rats_1 as CurrRate
from (select * From Sales_Header where company in (select Company from ELGI_Companies_Master where CompanyGroup='ELGI')) h
inner join Sales_Lines L
on h.Company =l.Company 
and ltrim(rtrim(h.OrderNum))=ltrim(rtrim(L.OrderNum))
left outer join vw_Business_Partner v
on ltrim(rtrim(l.CustCode))=ltrim(rtrim(v.custcode))
left outer join (select * from TTCMCS031ALL where company=400) a 
on h.LineOfBusiness=a.CBRN
left outer join (select distinct EMNO,COMPANY ,NAMA from TTCCOM001ALL) b
on h.SalesRep=b.EMNO 
and h.Company =b.COMPANY
--left outer join TZZSLS326ALL c  --Not Used for Segment Classification
--on h.LineOfBusiness=c.CBRN

where LTRIM(RTRIM(L.ItemCode)) not in ('FRT' ,'EXPORT-FREIGHT','M000037703')
and t_sqnb =0
and h.t_clyn<>1
and l.t_clyn<>1

union

select 
h.Dpst,case when h.area is null or h.area=' ' then v.CustAreaCode else h.Area end as AreaCode,H.ordertype,h.RefA as Indent,
h.SlsPriceLst,l.DiscPerc1,l.DiscPerc2,l.DiscPerc3,
 L.Company,L.Trantype,L.invnum,L.OrderNum,convert(date,L.OrderDate) OrderDate,L.PositionNum,L.CustCode,L.ItemCode,
L.DeliveryDate,L.WareHouse,l.Price,
l.t_qoor  as qty,
--case when len(l.invnum)<2 then l.t_qoor  else l.t_qidl end as qty,
l.t_amld as discount,
(l.t_oamt* (case when h.t_rats_1=0 or h.t_rats_1 is null then 1 else h.t_rats_1 end)) as sales,
--h.t_oref as Segment,
--c.CHNL as Segment,
null as Segment, 
h.SalesRep as SalesRepCode,b.NAMA as SalesRep,h.LineOfBusiness as LOBCode,a.DSCA as LineOfBusiness,
h.DeliveryTerms,
null as Sales_USD,
l.t_oamt as Foreign_currency_amount,
h.Currency,
h.ForwardAgent,
h.PaymentTerm,
h.t_rats_1 as CurrRate
from (select * From Sales_Header where company in (select Company from ELGI_Companies_Master where CompanyGroup='ATS')) h
inner join Sales_Lines L
on h.Company =l.Company 
and ltrim(rtrim(h.OrderNum))=ltrim(rtrim(L.OrderNum))
left outer join vw_Business_Partner v
on ltrim(rtrim(l.CustCode))=ltrim(rtrim(v.custcode))
left outer join (select * from TTCMCS031ALL where company=400) a 
on h.LineOfBusiness=a.CBRN
left outer join (select distinct EMNO,COMPANY ,NAMA from TTCCOM001ALL) b
on h.SalesRep=b.EMNO 
and h.Company =b.COMPANY
--left outer join TZZSLS326ALL c  --Not Used for Segment Classification
--on h.LineOfBusiness=c.CBRN

--where LTRIM(RTRIM(L.ItemCode)) not in ('FRT' ,'EXPORT-FREIGHT','M000037703')
where t_sqnb =0
and h.t_clyn<>1
and l.t_clyn<>1

GO

