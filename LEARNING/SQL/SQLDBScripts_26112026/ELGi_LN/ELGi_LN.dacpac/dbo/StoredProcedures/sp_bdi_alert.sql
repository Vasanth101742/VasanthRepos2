CREATE procedure [dbo].[sp_bdi_alert]
As
BEGIN


Truncate table bdi_alert

Insert into bdi_alert


Select Supplier,ItemCode, Item_desc,buyer,sum(ord_qty)'Ord_qty', sum(penqty)'Pend_qty', NULL as Supplier_code,ItemType from (

select *,case when Division='Subsidiaries' then 4
when  Division='Industrial' then 1
when  Division='OFSAC' then 2
when  Division='Portable' then 3
when  Division='Direct Export' then 6
when  Division='Subsidiaries - BTB' then 5
end 'OrderLine',

case when Ship_Status in ('Waiting For Invoice') then 'Commercial'
when Ship_Status in ('In Packing','Stock Available','In-Packing / Billing','Kits-WIP') then 'Stores'
when Ship_Status in ('Fully Advised','Stock Not Available - HO Manf Parts','Stock Not Available - ACP Manf Parts') then 'Planing'

when Ship_Status in ('Order Not released') then 'Order Not released'
when Ship_Status in ('Partially Available','Stock Not Available') then 'Materials'
when Ship_Status in ('Partialy Advised') and (STOCK_490_onhand+qtyblock)>=(penqty-Allocation) then 'Stores'
when Ship_Status in ('Partialy Advised') and (STOCK_490_onhand+qtyblock)<(penqty-Allocation) then 'Materials'
end department,(case when isnull(b.LItem,c.NLItem) is null then 'No' else 'Yes' end)'TriggerItemYesNO',
isnull(b.LDueDate,c.NLDueDate)'TrigDueDate', DATEDIFF(day,isnull(b.LDueDate,c.NLDueDate),GETDATE())'TrigAgeing'
, case when (a.dpst+ordertype) in ('70016274',
'70028274',
'70056274',
'70065274',
'70085274',
'70096274',
'70045274',
'70016E74',
'70028E74',
'70056E74',
'70065E74',
'70085E74',
'70096E74',
'70045E74',
'90213270',
'90257270',
'90231270',
'90213E70',
'90257E70',
'90231E70',
'90013242',
'90031242',
'90063242',
'90082242',
'90083242',
'90028242',
'90075242',
'90076242',
'90077242',
'90013342',
'90031342',
'90063342',
'90082342',
'90083342',
'90028342',
'90075342',
'90076342',
'90077342',
'90013246',
'90031246',
'90063246',
'90082246',
'90083246',
'90028246',
'90075246',
'90076246',
'90077246',
'90013346',
'90031346',
'90063346',
'90082346',
'90083346',
'90028346',
'90075346',
'90076346',
'90077346',
'90013FCA',
'90031FCA',
'90063FCA',
'90082FCA',
'90083FCA',
'90028FCA',
'90075FCA',
'90076FCA',
'90077FCA') then 'TRUE BDI' else 'NON BDI'end 'BDI_TYPE'
  from (

select *,round((case when  sales_gstn_no='EXPORT' then value else t_oamt end),2)'FinalPrice'
,round((case when  sales_gstn_no='EXPORT' then value/1000000 else t_oamt/1000000 end),2)'Amount',

case when [Over Due Days]>0 and isnull(wh_orderdate,'1900-01-01')>'2000-01-01' then 'Overdue'
when  [Over Due Days]<=0 and Concat(Year(Getdate()),' - ',Month(Getdate())) = Concat(Year(PlannedDelDate),' - ',Month(PlannedDelDate))  then 'Within Due1'
when  [Over Due Days]<=0   then 'Within Due'
when  [Over Due Days]>0 and isnull(wh_orderdate,'1900-01-01')<='2000-01-01'  then 'Not Released'
end'Order_status_New',

case when [Over Due Days]>0 and isnull(wh_orderdate,'1900-01-01')>'2000-01-01' then 'Overdue'
when  [Over Due Days]<=0   then 'Within Due'
when  [Over Due Days]>0 and isnull(wh_orderdate,'1900-01-01')<='2000-01-01'  then 'Not Released'
end'Order_status'

,case 
when [Over Due Days] between 1 and 10 then '0-10 Days' 
when [Over Due Days] between 11 and 20 then '11-20 Days'
when [Over Due Days] between 21 and 30 then '21-30 Days'
when [Over Due Days] between 31 and 60 then '31-60 Days'
when [Over Due Days] between 61 and 90 then '61-90 Days'
when [Over Due Days] between 91 and 150 then '91-150 Days'
when [Over Due Days] >150 then 'Greater 150 Days' 
when [Over Due Days]<=0 and abs([Over Due Days]) between 0 and 7  then 'Week 1'
when [Over Due Days]<0 and abs([Over Due Days]) between 8 and 14  then 'Week 2' 
when [Over Due Days]<0 and abs([Over Due Days]) between 15 and 21  then 'Week 3' 
when [Over Due Days]<0 and abs([Over Due Days]) between 22 and 28  then 'Week 4' 
when [Over Due Days]<0 and abs([Over Due Days]) between 29 and 35  then 'Week 5' 
when [Over Due Days]<0 and abs([Over Due Days]) between 36 and 42  then 'Week 6' 
when [Over Due Days]<0 and abs([Over Due Days]) between 43 and 49  then 'Week 7' 
when [Over Due Days]<0 and abs([Over Due Days]) between 49 and 56  then 'Week 8' 
when [Over Due Days]<0 and abs([Over Due Days]) >=57  then 'Week 8<' 
end 'OD Com',

case when g.Dpst in (70016,70028,70045,70056,70065,70085,70096) and g.Custname like'elgi%' then 'Subsidiaries'  
when g.Dpst in (70016,70028,70045,70056,70065,70085,70096) and g.Custname like'Rotair%' then 'Subsidiaries'  
when g.Dpst in (70028,70085) and g.Custname not like'elgi%' then 'Subsidiaries - BTB'  
when g.Dpst in (90001, 90013,90028,90031,90063,90075,90008,90010,90016,90020,90021,90022,90030,90033,90035,90037,90038,90094) then 'Industrial'
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
a.dpst in (70016,70028,70045,70056,70065,70085,70096,90001,90013,90028,90031,90063,
				90075,90076,90077,90082,90083,90084,90213,90231,90256,90257,90267
				,90008,90010,90016,90020,90021,90022,90030,90033,90035,90037,90038,90094) 
				and 
convert(date,a.OrderDate)>'20220331'-- and  isnull(wh_orderdate,'1900-01-01')>'1900-01-01'


and a.OrderNum NOT IN ('236066432','236066426','236066427','236066428','236066297','236066429','236066430','236066431','236066580'   ---Modified BY Raviprasath
,'292156069','490004475','490014640','294007862','294007860','294007861','294007394','236068223','236068149') -- Removed as per ticket no : #INC-1195621 on 12/01/2026 , #1349539
and ShipmentNO NOT IN ('SHO584288','SHO584075','SHO584069','SHO584061','SHO584027','SHO583900','SHO583750')

and
 (replace(a.OrderNum,' ','') +(replace(a.ItemCode,' ',''))) not in ('292051258013436408','293008210A970012',
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


 ) a
 
left join (SELECT replace(item,' ','')'LItem',min([Dudt])'LDueDate'
FROM TZZPUR014ALL WHERE STAT = 'M'and Company='490' group by replace(item,' ','')) b on b.LItem=replace(a.ItemCode,' ','')

left join (select replace(item,' ','')'NLItem',min(DUDT)'NLDueDate' from TZZPUR302ALL
where STAT='S' and COMPANY='490' group by replace(item,' ','')) c on c.NLItem=replace(a.ItemCode,' ','')

left join (Select replace(itemCode,' ','')'R1Item',Parts,Lean from  vw_HealthReport_ItemMaster) R1 on ltrim(rtrim(R1.R1Item))=a.ItemCode

--order by a.[Over Due Days] desc

)a

Where BDI_TYPE = 'TRUE BDI' and Ship_Status IN 
('Stock Not Available - ACP Manf Parts',
'Stock Not Available')

Group BY Supplier,ItemCode, Item_desc,buyer,ItemType


--Alter table bdi_alert add Supplier_code nvarchar(30)

UPDATE a
SET a.Supplier_code = b.OTBP
FROM bdi_alert a
INNER JOIN (
    SELECT DISTINCT 
        LTRIM(RTRIM(ITEM)) AS ITEM1,
        OTBP
    FROM TTDIPU001ALL
    WHERE COMPANY = 490
) b
ON LTRIM(RTRIM(a.ItemCode)) = b.ITEM1


Update bdi_alert
Set Supplier = 'ELGI EQUIPMENTS GSC' Where Itemtype = 'M' and Supplier IS NULL

--Update bdi_alert
--Set Supplier = 'VIJAYAMANIKANDAN' Where Itemtype = 'P' and Supplier IS NULL


Update bdi_alert
Set buyer = 'MAGHARADEEPAN' Where Itemtype = 'M' and buyer IS NULL

Update bdi_alert
Set buyer = 'VIJAYAMANIKANDAN' Where Itemtype = 'P' and buyer IS NULL


End



--Select * from bdi_alert

GO

