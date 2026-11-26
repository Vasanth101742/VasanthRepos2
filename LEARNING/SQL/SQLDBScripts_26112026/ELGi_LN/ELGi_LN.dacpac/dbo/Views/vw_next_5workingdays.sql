CREATE view [dbo].[vw_next_5workingdays] as
select distinct top 5 convert(date,DATE) as DATE1 ,dense_rank() over (order by DATE ) as daterank from TTCCCP020400
where datepart(dw,date) not in(1,7) 
and DFCA<>'4'
and DATE>=getdate()-1

GO

