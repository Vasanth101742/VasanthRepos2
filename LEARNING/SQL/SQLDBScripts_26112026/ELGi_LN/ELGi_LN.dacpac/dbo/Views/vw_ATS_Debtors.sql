
CREATE VIEW [dbo].[vw_ATS_Debtors] as
select sum(InvAmntInHomeCur) as InvAmntInHomeCur,sum(RecAmntHomeCur)as RecAmntHomeCur,
sum(BalAmntHomeCur)/1000000 as BalAmntHomeCur, sum(DueAmt)/1000000 as DueAmt,sum(UnDueAmt)/1000000 as UnDueAmt, sum(Due_30)/1000000 as DueAmtHC30,
sum(Due_31_60)/1000000  as DueAmtHC31_60, sum(Due_61_90)/1000000 as DueAmtHC61_90,sum(Due_91_120)/1000000 as DueAmtHC91_120,
sum(Due_121_150)/1000000 as DueAmtHC121_150,sum(Due_151_180)/1000000 as DueAmtHC151_180,sum(Due_181_365)/1000000 as DueAmtHC181_365,
sum(Due_366_730)/1000000 as DueAmtHC366_730,sum(Due_731_1095)/1000000 as DueAmtHC731_1095,sum(Due_gt1095)/1000000 as DueAmtgt_1095,productgrp,
case when productgrp in (90041,90051) and trantyp not like '6c%'and trantyp not like '6d%'  then 'Spares'
when productgrp in (90045,90048) and trantyp not like '6c%'and trantyp not like '6d%' then 'Service'
when productgrp in (90240,90241,90244,90250,90251) and trantyp not like '6c%'and trantyp not like '6d%' then 'International'
when productgrp in (90040,90042,90043,90044,90050,90052) and trantyp not like '6c%'and trantyp not like '6d%' then 'Domestic'
when trantyp like '6c%' then 'Demo/ Trial Units'
when trantyp like '6d%' then '6DS Invoices'
else 'Others' end as description1,

case when productgrp in (90041,90051) and trantyp not like '6c%'and trantyp not like '6d%'  then 2
when productgrp in (90045,90048) and trantyp not like '6c%'and trantyp not like '6d%' then 3
when productgrp in (90240,90241,90244,90250,90251) and trantyp not like '6c%'and trantyp not like '6d%' then 4
when productgrp in (90040,90042,90043,90044,90050,90052) and trantyp not like '6c%'and trantyp not like '6d%' then 1
when trantyp like '6c%' then 6 
when trantyp like '6d%' then 7
else 5 end as  ordering1

from
(	
select * from 
(select * ,
case when datediff(dd,duedt,(select convert(datetime,convert(varchar,max(last_run_date),101)) from last_run_Date)) between 0 and 30 then dueamt else 0 end as due_30,
case when datediff(dd,duedt,(select convert(datetime,convert(varchar,max(last_run_date),101)) from last_run_Date)) between 31 and 60 then dueamt else 0 end as due_31_60,
case when datediff(dd,duedt,(select convert(datetime,convert(varchar,max(last_run_date),101)) from last_run_Date)) between 61 and 90 then dueamt else 0 end as due_61_90,
case when datediff(dd,duedt,(select convert(datetime,convert(varchar,max(last_run_date),101)) from last_run_Date)) between 91 and 120 then dueamt else 0 end as due_91_120,
case when datediff(dd,duedt,(select convert(datetime,convert(varchar,max(last_run_date),101)) from last_run_Date)) between 121 and 150 then dueamt else 0 end as due_121_150,
case when datediff(dd,duedt,(select convert(datetime,convert(varchar,max(last_run_date),101)) from last_run_Date)) between 151 and 180 then dueamt else 0 end as due_151_180,
case when datediff(dd,duedt,(select convert(datetime,convert(varchar,max(last_run_date),101)) from last_run_Date)) between 181 and 365 then dueamt else 0 end as due_181_365,
case when datediff(dd,duedt,(select convert(datetime,convert(varchar,max(last_run_date),101)) from last_run_Date)) between 366 and 730 then dueamt else 0 end as due_366_730,
case when datediff(dd,duedt,(select convert(datetime,convert(varchar,max(last_run_date),101)) from last_run_Date)) between 731 and 1095 then dueamt else 0 end as due_731_1095,
case when datediff(dd,duedt,(select convert(datetime,convert(varchar,max(last_run_date),101)) from last_run_Date)) > 1095 then dueamt else 0 end as due_gt1095
from  (SELECT     company, Trantyp, InvNo, CustNo, ProductGrp, Area, DocDt, InvAmntInHomeCur, RecAmntHomeCur, BalAmntHomeCur, DueAmt, UnDueAmt, 
DueAmtHC30, DueAmtHC31_60, DueAmtHC61_90, DueAmtHC91_180, DueAmtHCGT180, DueDt, Refrence
FROM  ACR
 where company = 101 and productgrp <> '111'
 and balamnthomecur >= 1)test)vw_artest
) acc_cumm
group by productgrp,trantyp

GO

