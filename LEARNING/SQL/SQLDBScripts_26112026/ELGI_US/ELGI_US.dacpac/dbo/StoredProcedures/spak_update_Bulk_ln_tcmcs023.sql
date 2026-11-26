CREATE PROC [dbo].[spak_update_Bulk_ln_tcmcs023] @dl_id [nvarchar](50),@json [nvarchar](MAX) AS
begin

--delete from ln_tccom100 where bpid = @bpid;

CREATE TABLE #temp_usln_tcmcs023(
	[compnr] [numeric](10, 0) NULL,
	[citg] [varchar](254) NULL,
	[dsca] [varchar](254) NULL,
	[deleted] [varchar](254) NULL,
	[username] [varchar](254) NULL,
	[timestamp] [datetime] NULL,
	[sequen] [numeric](10, 0) NULL
)


INSERT INTO #temp_usln_tcmcs023 ([compnr],[citg],[dsca],[deleted],[username],[timestamp],[sequen]) SELECT * FROM OPENJSON (@json)
WITH(
    compnr nvarchar(50) '$.compnr',citg nvarchar(50) '$.citg',dsca nvarchar(50) '$.dsca.it_IT',deleted nvarchar(100) '$.deleted',
    username nvarchar(max) '$.username',[timestamp] nvarchar(50) '$.timestamp',sequen nvarchar(50) '$.sequencenumber')


	DELETE usln_tcmcs023 FROM usln_tcmcs023 INNER JOIN #temp_usln_tcmcs023 ON usln_tcmcs023.compnr = #temp_usln_tcmcs023.compnr 
	and usln_tcmcs023.citg = #temp_usln_tcmcs023.citg and usln_tcmcs023.dsca = #temp_usln_tcmcs023.dsca;


	INSERT INTO usln_tcmcs023 SELECT * FROM #temp_usln_tcmcs023;


	update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dl_id;


	drop table #temp_usln_tcmcs023;

end

GO

