CREATE VIEW [dbo].[vw_ACR_Report] as     
select *,case when delays between 0 and 30 then balance else 0 end del_00_30,        
case when delays between 31 and 40 then balance else 0 end del_31_40,        
case when delays between 41 and 45 then balance else 0 end del_41_45,        
case when delays between 46 and 50 then balance else 0 end del_46_50,        
case when delays between 51 and 90 then balance else 0 end del_51_90,        
case when delays between 91 and 999 then balance else 0 end del_91_999,        
case when delays > 999 then balance else 0 end del_gt_999,        
case when delays between 31 and 60 then balance else 0 end del_31_60,        
case when delays between 61 and 90 then balance else 0 end del_61_90,        
case when delays between 91 and 120 then balance else 0 end del_91_120,        
case when delays between 121 and 180 then balance else 0 end del_121_180,        
case when delays > 180 then balance else 0 end del_gt_180 from      
(select a.*,cust.t_nama custname1,a.Area as custarea,vw_Area_Master.areaname,vw_Area_Master.region,
b.areaname as custareaname,b.Region as custregion,
case 
when organ is null and a.company in (150,401) then 'ISAAME' 
when organ is null and a.company in (180,403) then 'AMEROPA' 
when organ is null and a.company in (170,402) then 'COSEA' else organ end as organ,
invamntininvcur as inv_value ,
(recamntinvcur+curdiffamnt) as coll_value,
balamntinvcur as balance,
datediff(dd,docdt,getdate()) as delays,
balamnthomecur as balancehmcur 
from ACR a      
inner join (select Company,t_idoc as invnum,t_tran ttyp from tcisli310all)Ttesls598baan 
on ttyp=trantyp and invno=invnum      
inner join TTCCOM100400 cust      
on t_bpid=custno      
inner join vw_Area_Master      
on a.area=areacode       
left outer join      
(select distinct areacode,organ from vw_SALESMAPPING_MASTER where organ is not null ) map      
on a.area=map.areacode     
inner join VW_AREA_MASTER b  
on a.area=b.areacode   
)a

GO

