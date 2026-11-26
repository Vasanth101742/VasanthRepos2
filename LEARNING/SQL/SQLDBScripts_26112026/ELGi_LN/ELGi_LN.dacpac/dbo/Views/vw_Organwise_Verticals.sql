CREATE view [dbo].[vw_Organwise_Verticals]
as 
select * From (
select *,
case 
when organ='India' and vertical1 ='AFTERSALES' and DPSTCode  in (90001,90013,90015,90028,90031,90034,90038,90039,90075,90082,90083,90084) then 'After Sales Industrials'
when organ='India' and vertical1 ='AFTERSALES' and DPSTCode  in (90029) then 'After Sales-Industrials AMC'
when organ='India' and vertical1 ='AFTERSALES' and DPSTCode  in (90026) then 'After Sales-Oil Royalty'
when organ='India' and vertical1 ='AFTERSALES' and DPSTCode  in (90076,90077,90078,90302,90032) then 'After Sales-Portables'


when organ='India' and vertical1 ='C&M' and DPSTCode  in (90033) then 'Construction'
when organ='India' and vertical1 ='C&M' and DPSTCode  in (90036) then 'After Sales Portables Service Income'
when organ='India' and vertical1 ='C&M' and DPSTCode  in (90037) then 'Mining'

when organ='India' and vertical1 ='Channel' and DPSTCode  in (90000,90010,90014,90016,90020,90072,90074) then 'Channel'
when organ='India' and vertical1 ='Direct' and DPSTCode  in (90009,90022,90023,90030,90093,90094) then 'Direct'
when organ='India' and vertical1 ='Direct' and DPSTCode  in (90008) then 'SEPSAC Stream-I'

when organ='India' and vertical1 ='RAILWAY' and DPSTCode  in (90073) then 'Railway AMC'
when organ='India' and vertical1 ='RAILWAY' and DPSTCode  in (90092) then 'Railway Spares'
when organ='India' and vertical1 ='RAILWAY' and DPSTCode  in (90091) then 'Railway Units'

when organ='India' and vertical1 ='WW' and DPSTCode  in (90021) then 'WW'
when organ='India' and vertical1 ='WW' and DPSTCode  in (90035) then 'WW-OE' 
else vertical1 end as vertical2

 from (
select dpstcode,
case when organ='India'then '000' else Areacode end as Areacode,Organ,
case 
when organ='India' then Vertical1
when organ in ('SAAME','ID') then User_names 
when organ in ('COSEA','Subsidiary') then Division end as vertical1
From vw_SALESMAPPING_MASTER where organ in ('India','SAAME','Subsidiary','COSEA','ID'))a
where vertical1 is not null
and vertical1 not like '%to cust%'
)a

GO

