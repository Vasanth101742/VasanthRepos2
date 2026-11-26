

CREATE proc [dbo].[SP_GR_OpenOrder] (@Customer nvarchar(30))
as
begin
select case when compnr='3110' then 'Industrial'
when compnr='3120' then 'Portables'
when compnr='3130' then 'Medical'
when compnr='3140' then 'Pattons'
when compnr='3150' then 'MAS'
end 'Compnr',CONVERT(date,orderdate)'OrderDate',ponum,OrderNum,PosNum,case when shipConstrt=4 then 'Yes' else 'No' end 'shipConstrt',
case when [Type]=5 then 'Yes' else 'No' end 'Typ',Item,[desc],CONVERT(date,RequestDate)'RequestDate',CONVERT(date,PlannedDate)'PlannedDate',orderedQty,UnitPrice,CustName
,pendQty,Extprice
from (SELECT
	l.ofbp as CustNum,
	(select bp.nama FROM ln_tccom100 bp WHERE l.ofbp=bp.bpid and bp.compnr='3100') as CustName,
	CAST(l.odat as DATE) AS OrderDate,
	l.corn AS PONum,
	l.orno AS OrderNum,
	l.pono AS PosNum,
	l.sqnb AS SeqNum,
	l.scon AS ShipConstrt,
	l.dltp AS Type,
	trim(l.item) AS Item,
	(select i.dsca from ln_tcibd001 i WHERE l.item=i.item AND i.compnr='3100') as "Desc",
	l.qoor AS OrderedQTY,
	CAST(l.ddtc as DATE) AS RequestDate,
	CAST(l.ddta as DATE) AS PlannedDate,
	l.pric AS UnitPrice,
	l.qoor-l.qidl AS PendQTY,
	l.pric*(l.qoor-l.qidl) AS ExtPrice
	,l.compnr
FROM
	ln_tdsls401 l
JOIN ln_tdsls400 h ON
	l.compnr = h.compnr
	AND l.orno = h.orno
WHERE
	l.clyn = 2
	AND l.compnr='3110'
	--AND l.ofbp=$P{CustNum}
	AND l.clyn = 2
	AND l.term = 2
	AND h.oamt > 0.01
	AND h.chrq > 1
	AND (h.hdst > 5	AND h.hdst < 30)
	AND l.dldt < '2000-01-01'
	AND h.odat > '2024-04-01') a 
where compnr='3110'  and CustNum=@Customer
order by compnr,CONVERT(date,orderdate)
end

GO

