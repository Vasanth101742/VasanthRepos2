
CREATE proc [dbo].[sp_Hourly_Packing]
as
begin

declare @date date
set @date =convert(date,getdate())

truncate table HOURLY_PACKING
insert into HOURLY_PACKING ([T$SHPM]
      ,[T$REMK]
      ,[T$LOGN]
      ,[item]
      ,[ITEM_DESC]
      ,[ordqty]
      ,[Compqty]
      ,[PackDate]
      ,[cnt]
      ,[Value]
	  ,[cwar]
      ,[Tme]
      ,[CUSTCODE]
      ,[DPST]
      ,[ORDERNO]
      ,[CUST_ORD_TYPE]
      ,[DPSTNAME]
      ,[CUSTNAME]
      ,[Ordr]) 
	  
	 -- Alter table HOURLY_PACKING add cwar varchar(10)

select A.*,B.CUSTCODE,B.DPST,B.ORDERNO,B.CUST_ORD_TYPE
,'                                          ' AS DPSTNAME,'                                       ' AS CUSTNAME ,
case when tme ='7-8' then 1 when tme ='8-9' then 2  when tme ='9-10' then 3  when tme ='10-11' then 4  when tme ='11-12' then 5 
 when tme ='12-13' then 6  when tme ='13-14' then 7  when tme ='14-15' then 8  when tme ='15-16' then 9  when tme ='16-17' then 10 else 11
 end as Ordr from(
select *,
case 
when PackDate between convert(datetime,CONCAT(CONVERT(DATE,@date),' 01:00:00.000')) AND 
convert(datetime,CONCAT(CONVERT(DATE,@date),' 07:59:59.000')) then '7-8' 
when PackDate between convert(datetime,CONCAT(CONVERT(DATE,@date),' 08:00:00.000')) AND 
convert(datetime,CONCAT(CONVERT(DATE,@date),' 08:59:59.000')) then '8-9' 
when PackDate between convert(datetime,CONCAT(CONVERT(DATE,@date),' 09:00:00.000')) AND 
convert(datetime,CONCAT(CONVERT(DATE,@date),' 09:59:59.000')) then '9-10' 
when PackDate between convert(datetime,CONCAT(CONVERT(DATE,@date),' 10:00:00.000')) AND 
convert(datetime,CONCAT(CONVERT(DATE,@date),' 10:59:59.000')) then '10-11' 
when PackDate between convert(datetime,CONCAT(CONVERT(DATE,@date),' 11:00:00.000')) AND 
convert(datetime,CONCAT(CONVERT(DATE,@date),' 11:59:59.000')) then '11-12' 
when PackDate between convert(datetime,CONCAT(CONVERT(DATE,@date),' 12:00:00.000')) AND 
convert(datetime,CONCAT(CONVERT(DATE,@date),' 12:59:59.000')) then '12-13' 
when PackDate between convert(datetime,CONCAT(CONVERT(DATE,@date),' 13:00:00.000')) AND 
convert(datetime,CONCAT(CONVERT(DATE,@date),' 13:59:59.000')) then '13-14' 
when PackDate between convert(datetime,CONCAT(CONVERT(DATE,@date),' 14:00:00.000')) AND 
convert(datetime,CONCAT(CONVERT(DATE,@date),' 14:59:59.000')) then '14-15' 
when PackDate between convert(datetime,CONCAT(CONVERT(DATE,@date),' 15:00:00.000')) AND 
convert(datetime,CONCAT(CONVERT(DATE,@date),' 15:59:59.000')) then '15-16' 
when PackDate between convert(datetime,CONCAT(CONVERT(DATE,@date),' 16:00:00.000')) AND 
convert(datetime,CONCAT(CONVERT(DATE,@date),' 16:59:59.000')) then '16-17' 
when PackDate between convert(datetime,CONCAT(CONVERT(DATE,@date),' 17:00:00.000')) AND 
convert(datetime,CONCAT(CONVERT(DATE,@date),' 23:59:59.000')) then '>17' 
end as Tme


 from(
select a.*,isnull(b.VAL,0)as Value,b.cwar  From (
select SHPM,REMK,LOGN,item,T$DESC AS ITEM_DESC,SQTY as ordqty,quan as Compqty,T$PKDT as PackDate,1 as cnt    From (
select a.*,b.QUAN,b.T$PKDT From (SELECT SHPM,REMK,LOGN,ltrim(rtrim(ITEM))as Item,SUBSTRING([DESC],1,15)T$DESC,SQTY fROM TZZSLS602490 WHERE REMK ='Packing Completed')a
left join (select SHPM,ltrim(rtrim(ITEM))as Item,QUAN,dateadd(MINUTE,30,dateadd(hh,5,PKDT))as T$PKDT From TZZSLS603490 where 
convert(date,PKDT)=convert(date,@date))b
on a.SHPM =b.SHPM 
and a.Item =b.Item
union all
select SHPM,'Packing Completed','WCS',ltrim(rtrim(ITEM)),c.t_dsca,(b.QTY),(b.QTY),dateadd(MINUTE,30,dateadd(hh,5,EDITDATE)) from wms_order_status a
left join wmwhse1_PICKDETAIL b on b.orderkey=a.WMS_ORDERNO and ltrim(rtrim(b.SKU))=ltrim(rtrim(a.ITEM))
left join ELGi_LN..TTCIBD001400 c on ltrim(rtrim(c.t_item))=ltrim(rtrim(ITEM))
where cwar='103' and stat_desc='Pack Complete'
and convert(date,dateadd(MINUTE,30,dateadd(hh,5,EDITDATE)))=convert(date,@date)


)a 
where T$PKDT is not null
--and t$shpm='SHO069979' group by T$SHPM,T$REMK,T$LOGN,item
)a
left join (SELECT LTRIM(RTRIM(SHPM))AS SHIPMENT,LTRIM(RTRIM(ITEM))AS ITEM ,SUM(price*Qty)AS VAL,cwar FROM wms_order_status 	GROUP BY SHPM,ITEM,cwar)b
on a.SHPM =b.SHIPMENT 
and a.Item =b.ITEM )a

)a
LEFT JOIN (select SHPM,SOFF as DPST,ITBP AS CUSTCODE,ORNO AS ORDERNO,COTP AS CUST_ORD_TYPE From TZZSLS601490 )B
ON A.SHPM =B.SHPM 

UPDATE HOURLY_PACKING SET DPSTNAME=SUBSTRING(A.DPSTName,1,15)  FROM (SELECT DISTINCT DPSTcode,DPSTName FROM [ELGi_LN].DBO.VW_DPST_MASTER)A
WHERE HOURLY_PACKING.DPST=A.DPSTcode 


UPDATE HOURLY_PACKING SET CUSTNAME=SUBSTRING(A.custname1,1,15) FROM (SELECT DISTINCT custcode ,custname1  FROM [ELGi_LN].DBO.vw_Business_Partner )A
WHERE HOURLY_PACKING.CUSTCODE=A.custcode

--create table HOURLY_PACKING_BASE (TME varchar(100),ORDR INT)
truncate table HOURLY_PACKING_BASE
insert into HOURLY_PACKING_BASE  values('7-8',1),('8-9',2),('9-10',3),('10-11',4),('11-12',5),('12-13',6),('13-14',7),('14-15',8),('15-16',9),('16-17',10),('>17',11)

--select * From HOURLY_PACKING_BASE



end

GO

