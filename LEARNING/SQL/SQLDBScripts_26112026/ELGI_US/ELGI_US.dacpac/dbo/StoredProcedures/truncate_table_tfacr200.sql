create PROC [dbo].[truncate_table_tfacr200] AS
BEGIN
   
truncate table ln_tfacr200

delete from mastertable where dl_doc = 'LN_tfacr200'


END

GO

