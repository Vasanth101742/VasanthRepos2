CREATE PROC [dbo].[SP_GR_GSC_OVERDUE] AS
begin

select *,round((case when  sales_gstn_no='EXPORT' then value else t_oamt end),2)'FinalPrice'
,round((case when  sales_gstn_no='EXPORT' then value/1000000 else t_oamt/1000000 end),2)'Amount',

case when [Over Due Days]>0 and isnull(wh_orderdate,'1900-01-01')>'2000-01-01' then 'Overdue'
when  [Over Due Days]<=0   then 'Within Due'
when  [Over Due Days]>0 and isnull(wh_orderdate,'1900-01-01')<='2000-01-01'  then 'Not Released'
end'Order_status'

,case 
when [Over Due Days] between 1 and 10 then '0-10Days' 
when [Over Due Days] between 11 and 20 then '11-20Days'
when [Over Due Days] between 21 and 30 then '21-30Days'
when [Over Due Days] between 31 and 60 then '31-60Days'
when [Over Due Days] between 61 and 90 then '61-90Days'
when [Over Due Days] between 91 and 150 then '91-150Days'
when [Over Due Days] >150 then '150 GreatDays'
when [Over Due Days]<=0 and abs([Over Due Days]) between 0 and 7  then 'Up Week 1'
when [Over Due Days]<0 and abs([Over Due Days]) between 8 and 14  then 'Up Week 2' 
when [Over Due Days]<0 and abs([Over Due Days]) between 15 and 21  then 'Up Week 3' 
when [Over Due Days]<0 and abs([Over Due Days]) between 22 and 28  then 'Up Week 4' 
when [Over Due Days]<0 and abs([Over Due Days]) between 29 and 35  then 'Up Week 5' 
when [Over Due Days]<0 and abs([Over Due Days]) between 36 and 42  then 'Up Week 6' 
when [Over Due Days]<0 and abs([Over Due Days]) between 43 and 49  then 'Up Week 7' 
when [Over Due Days]<0 and abs([Over Due Days]) between 49 and 56  then 'Up Week 8' 
when [Over Due Days]<0 and abs([Over Due Days]) >=57  then 'Great than 8' 
end 'OD Com',

case when g.Dpst in (70016,70028,70056,70065,70085,70096) then 'Subsidiaries'  
when g.Dpst in (90001, 90013,90028,90031,90063,90075) then 'Industrial'
when g.Dpst in (90082 , 90083 , 90084) then 'OFSAC'
when g.Dpst in (90076 , 90077) then 'Portable'
when g.Dpst in(90213,90231,90256,90257,90267) then 'Direct Export'
else 'Others'
end 'Division'

  from 

(

select *,((DATEDIFF(dd, c.PlannedDelDate,c.CurrentDate) + 1)
    -(DATEDIFF(wk,  c.PlannedDelDate,c.CurrentDate) * 2)
    -(CASE WHEN DATEPART(dw, c.OrderDate) = 1 THEN 1 ELSE 0 END)
    -(CASE WHEN DATEPART(dw, c.CurrentDate) = 7 THEN 1 ELSE 0 END))-1 as 'Over Due Days'
 from 

(
select a.*,convert(date,getdate()) as 'CurrentDate',case when a.STOCK_490_onhand=0 then 'No' else 'Yes' end 'OverdueStatus'
from gr_PendingOrders  a

where 
a.dpst in (70016,70028,70056,70065,70085,70096,90001,90013,90028,90031,90063,
				90075,90076,90077,90082,90083,90084,90213,90231,90256,90257,90267) 
				and 
convert(date,a.OrderDate)>'20220331'-- and  isnull(wh_orderdate,'1900-01-01')>'1900-01-01'

and
 (replace(a.OrderNum,' ','') +(replace(a.ItemCode,' ',''))) not in ('292051258013436408',
'292050433M008906415',
'292051258012374519',
'430000013000998065',
'430000013B676103',
'292052298B009400010129',
'292052298X0180912',
'292055109A990921',
'292054810B015400780001',
'292054759Z012550',
'292054764Z012555',
'292055039972300030',
'292054758Z012555',
'292055186972300030',
'292057118000960087',
'292057118090445790',
'292058877B006700770023',
'292060311411400301',
'243003484A410614',
'251011905B011600960153',
'292061457B011106740001',
'292064082022459499',
'292063744022459499',
'243003491412400907',
'34300958600021002B',
'34300946700021002B',
'242024582B004700770022',
'292063765B005706740002',
'292063532B014606410052',
'343009627105411BSC',
'292065524015401697',
'251012603A990288',
'242026082012485146',
'292065030012473189',
'292065524972300060',
'242026072012485146',
'242025793012485146',
'292064430B014606410052')
)c

) g


order by g.[Over Due Days] desc 


end

GO

