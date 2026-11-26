
CREATE VIEW [dbo].[vw_ats_prod_stk] as 
select item itemstk,
sum(case when CWAR = '157' then QHND else 0 end) as stk_157,
sum(case when CWAR = '657' then QHND else 0 end) as stk_657,
sum(case when CWAR = '157' then QALL else 0 end) as ao_157,
sum(case when CWAR = '657' then QALL else 0 end) as ao_657
from (select * from TWHWMD215ALL 
where company in (select company from ELGI_Companies_Master where CompanyGroup='ATS') 
and ltrim(rtrim(item)) in (select  ltrim(rtrim(tplcode)) from ats_production_master ) 
and CWAR in ('657','157')
)a
group by item

GO

