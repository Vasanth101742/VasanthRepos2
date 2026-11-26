CREATE VIEW [dbo].[vw_collection_GL_receipts] as 

select company,trantyp,invno,custno,abs(amnthome)as gl_receipt,docdt,90150 as dpst,'051' as area,
ctrantyp,cdocno,anptrantyp,anpdocno,doctyp
from Collection_Stage2 
where --year(docdt) = 2009 and 
trantyp = 'BCD'
and convert(datetime,docdt) >= '04/01/2008'  
and convert(datetime,docdt) >= dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate())) 
--and ctrantyp not in ('ICC','R18','R23','R28','R40','R44','R45')
and clineno = 1
--and custdirdeb <> ''

GO

