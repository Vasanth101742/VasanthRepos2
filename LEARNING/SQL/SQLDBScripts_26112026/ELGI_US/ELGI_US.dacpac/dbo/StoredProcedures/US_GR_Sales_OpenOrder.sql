CREATE proc [dbo].[US_GR_Sales_OpenOrder]
as
begin 

truncate table [dbo].[US_OpenOrder]

--alter table [US_OpenOrder]
--add EngName nvarchar(50)

update LN_tdsls400 set odat2= CONVERT(datetime,SWITCHOFFSET(CONVERT(datetimeoffset,odat),DATENAME(TzOffset, SYSDATETIMEOFFSET()))) where YEAR(odat2) is null
update LN_tdsls401 set ddta2= CONVERT(datetime,SWITCHOFFSET(CONVERT(datetimeoffset,ddta),DATENAME(TzOffset, SYSDATETIMEOFFSET()))) where YEAR(ddta2) is null


insert into [US_OpenOrder]

select *  from (
select  a.compnr,
 (convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time' as odat

,replace(a.item,' ','')"ItemCode",b.dsca,a.orno,pono,sqnb,a.cwar,a.clyn,c.refa,c.sotp,c.refb ,
case when c.refa like '%SO#%' then 'Take StockOrder' else 'LN Order' end "Type"
,a.pric,pror_KW,chrq_kw ,a.oamt
, convert(date,(convert(datetime,a.ddta2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time') as DelDate
,YEAR ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')'CalYear'
,MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')'CalMonth'
,c.hdst_kw,
case when YEAR ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time') <4 
     then YEAR ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')-1 
     else YEAR ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time') end 'FinYear',
case when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=1 then 10
	 when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=2 then 11
	when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=3 then 12
	when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=4 then 1
	 when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=5 then 2
	when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=6 then 3
	when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=7 then 4
	 when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=8 then 5
	when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=9 then 6
	when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=10 then 7
	when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=11 then 8
	 when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=12 then 9
else 0 
end 'FinMonth',format(convert(datetime,c.odat),'MMM-yyyy') 'Month-Year',
qoor,qidl,qbbo,(a.qoor-a.qidl-qbbo)'openQty',(((a.qoor-a.qidl-qbbo)*a.pric)-amld)'OpenPrice',g.nama,b.cpln,amld,'' 'productType',''as 'Eng'
from LN_tdsls401 a 
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='3100' and b.deleted='N'
left join LN_tdsls400 c on c.compnr=a.compnr and c.orno=a.orno and c.deleted='N' 
left join LN_TCCom100 g on g.bpid=c.ofbp  and g.deleted='N' and g.compnr='3100'

where a.compnr between 3110 and 3150
and a.deleted='N'   and a.qidl=0
and isnull(sotp,'-')<>'-' 
and a.clyn=2 and c.hdst_kw not in ('tdsls.hdst.cancelled','tdsls.hdst.closed') and isnull(YEAR(c.odat),'')<>''
and c.clyn=2  
--and convert(date,c.odat)<'2025-07-01'
and a.orno not like'CHA%'
and  CONCAT(a.compnr,a.orno,pono,a.sqnb) not in  (select concat(a.compnr,a.orno,pono,a.sqnb) from  LN_TDSLS406 a)
and CONCAT(a.compnr,a.orno,pono) in (select * from [dbo].[US_GR_OpenOrder])
) as G1



insert into [US_OpenOrder]
select * from (
select  a.compnr,
(convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time' as odat,replace(a.item,' ','')"ItemCode",b.dsca,a.orno,pono,sqnb,a.cwar,a.clyn,c.refa,c.sotp,c.refb ,
case when c.refa like '%SO#%' then 'Take StockOrder' else 'LN Order' end "Type"
,a.pric,pror_KW,chrq_kw ,a.oamt
,convert(date, (convert(datetime,a.ddta2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time' )as DelDate
,YEAR ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')'CalYear'
,MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')'CalMonth'
,c.hdst_kw,
case when YEAR ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time') <4 
     then YEAR ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')-1 
     else YEAR ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time') end 'FinYear',
case when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=1 then 10
	 when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=2 then 11
	when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=3 then 12
	when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=4 then 1
	 when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=5 then 2
	when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=6 then 3
	when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=7 then 4
	 when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=8 then 5
	when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=9 then 6
	when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=10 then 7
	when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=11 then 8
	 when MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time')=12 then 9
else 0 
end 'FinMonth',format(convert(datetime,c.odat),'MMM-yyyy') 'Month-Year',
qoor,qidl,qbbo,(a.qoor-a.qidl-qbbo)'openQty',(((a.qoor-a.qidl-qbbo)*a.pric)-amld)'OpenPrice',g.nama,b.cpln,amld,e1.dsca 'productType','' as 'Eng'
from LN_tdsls401 a 
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='3100' and b.deleted='N'
left join LN_tdsls400 c on c.compnr=a.compnr and c.orno=a.orno and c.deleted='N' 
left join LN_TCCom100 g on g.bpid=c.ofbp  and g.deleted='N' and g.compnr='3100'
left join ln_tcmcs015 e1 on e1.ctyp=b.ctyp and e1.compnr='3100' and e1.deleted='N'

where a.compnr between 3110 and 3150
and a.deleted='N'   and a.qidl=0
and isnull(sotp,'-')<>'-' 
and a.clyn=2 and c.hdst_kw not in ('tdsls.hdst.cancelled','tdsls.hdst.closed') and isnull(YEAR(c.odat),'')<>''
and c.clyn=2  
and convert(date,a.odat)>'2025-06-30'
and a.orno not like'CHA%'
and  CONCAT(a.compnr,a.orno,pono,a.sqnb) not in  (select concat(a.compnr,a.orno,pono,a.sqnb) from  LN_TDSLS406 a)) g2


update a set productType=e1.dsca from  [US_OpenOrder] a
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.ItemCode,' ','') and b.compnr='3100' and b.deleted='N'
left join ln_tcmcs015 e1 on e1.ctyp=b.ctyp and e1.compnr='3100' and e1.deleted='N'

end

GO

