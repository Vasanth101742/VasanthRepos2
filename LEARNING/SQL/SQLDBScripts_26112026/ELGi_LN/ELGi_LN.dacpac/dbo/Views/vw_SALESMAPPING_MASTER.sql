CREATE view [dbo].[vw_SALESMAPPING_MASTER]

AS

select * From SalesMapping_Domestic  
union 
select * From SalesMapping_Global

GO

