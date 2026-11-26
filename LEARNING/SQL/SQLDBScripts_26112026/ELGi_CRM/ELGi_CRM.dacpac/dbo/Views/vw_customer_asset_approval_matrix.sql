
CREATE view vw_customer_asset_approval_matrix as 

select a.fullname 'Concerned_service_engineer',a.systemuserid,b.fullname 'Manager_name',i.fullname 'ASM_name',c.fullname 'RSM_Name',d.fullname 'RM_Name',e.fullname 'VH_Name',
f.fullname 'MD_Name',g.fullname 'Director_name',h.fullname 'Quality_head'
from systemuser_CRM  a 
left join  (select fullname,systemuserid from systemuser_CRM) b on a.parentsystemuserid=b.systemuserid
left join (select fullname,systemuserid from systemuser_CRM) c on a.elgi_rsm=c.systemuserid
left join (select fullname,systemuserid from systemuser_CRM) d on a.elgi_rm=d.systemuserid
left join (select fullname,systemuserid from systemuser_CRM) e on a.elgi_vh=e.systemuserid
left join (select fullname,systemuserid from systemuser_CRM) f on a.elgi_md=f.systemuserid
left join (select fullname,systemuserid from systemuser_CRM) g on a.elgi_director=g.systemuserid
left join (select fullname,systemuserid from systemuser_CRM) h on a.elgi_qualityhead=h.systemuserid
left join (select fullname,systemuserid from systemuser_CRM) i on a.elgi_asm=i.systemuserid
 
--where a.fullname='Ajith Kumar'
 --where systemuserid='67097E19-1179-E811-A95F-000D3AF29E21'

GO

