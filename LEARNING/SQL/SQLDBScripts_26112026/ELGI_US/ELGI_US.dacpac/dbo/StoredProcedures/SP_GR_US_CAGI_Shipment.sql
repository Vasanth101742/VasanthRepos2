create Proc [SP_GR_US_CAGI_Shipment]
as 
begin

select
	cast(h.idat AS DATE) as "InvoiceDate",
	cast(h.idat AS DATE) as "ReqDate",
	l.crep as "Slsp",
	h.itbp as "CustNum",
	n.nama as "CustName",
	l.orno as "OrderNum",
	trim(l.item) as "ItemNum",
	l.amti as "ExtPrice",
	i.citg as "GlTbl",
	i.dscd as "VendItemNum",
	i.cdf_extd as "extdesc",
	l.dqua as "OrderQty",
	h.stoa as "ShiptoADD",
	a.ccty as "Country",
	a.nama  as "shiptoname",
	a.cste as "State",
	c.dsca as "City",
	a.pstc as "Zip",
	l.shpm as "Shipment",
	l.shln as "Shipline",
	hp.valu as "Horsepower",
	sc.valu AS "Speed Control"
from ln_cisli305 h
join ln_cisli310 l on	h.compnr = l.compnr	and h.sfcp = l.sfcp and h.idoc=l.idoc and h.[tran] =l.[tran] and l.deleted='N'
join ln_tcibd001 i on l.item=i.item AND l.stad_ref_compnr=i.citg_ref_compnr  and i.deleted='N'
join ln_tdsls400 o on l.orno=o.orno and o.deleted='N'
left join ln_tccom130 a on o.stad=a.cadr and a.deleted='N'
join ln_tccom100 n on h.itbp=n.bpid and n.deleted='N'
join ln_tccom139 c on c.cste=a.cste AND c.ccty=a.ccty AND a.ccit=c.city AND a.afal_ref_compnr=c.ccty_ref_compnr  and c.deleted='N'
left join(SELECT item,valu FROM ln_txibd006 WHERE attr='Horsepower' and deleted='N') AS hp ON hp.item=l.item
left join(SELECT item,valu FROM ln_txibd006 WHERE attr='Speed Control' and deleted='N') AS sc ON sc.item=l.item
where
	h.compnr = '3110' and i.citg LIKE '58%' and h.deleted='N'



end

GO

