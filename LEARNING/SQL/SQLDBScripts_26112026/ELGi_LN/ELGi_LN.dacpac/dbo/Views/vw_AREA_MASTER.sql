CREATE view [dbo].[vw_AREA_MASTER]
AS
select * From Area_Master_Domestic 
union 
select * From Area_Master_Global

GO

