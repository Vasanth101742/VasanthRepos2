
CREATE view [dbo].[vw_DPST_MASTER]
AS 
select * from (
SELECT * FROM DPST_Master_Domestic 
UNION  
SELECT * FROM DPST_Master_Global where DPSTcode not like 's%' and DPSTcode<>'999999' 
--UNION  
--SELECT * FROM DPST_Master_ATS --Due to Same DPST in ELGi and ATS , this is removed since 23-Aug-2021
)a

GO

