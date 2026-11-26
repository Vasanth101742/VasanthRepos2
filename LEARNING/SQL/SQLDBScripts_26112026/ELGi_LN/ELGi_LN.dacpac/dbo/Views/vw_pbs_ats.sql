CREATE view vw_pbs_ats as
select * from (
select OTBP,ITEM,BAPR,MIQT,EFDT,
exdt,row_number() over(partition by OTBP,ITEM,MIQT order by efdt desc) as ExpRank
from (select OTBP,ITEM,BAPR,EFDT,MIQT,max(EXDT) EXDT from TTDPCG031ALL
where company in (select company from ELGI_Companies_Master where CompanyGroup='ATS')
and len(OTBP)>2 
group by OTBP,ITEM,BAPR,EFDT,MIQT
having max(EXDT)>getdate()-1
)a
--For Testing Purpose
--where item='         M000003054'
)b
where ExpRank=1
--order by OTBP,ITEM,ExpRank

GO

