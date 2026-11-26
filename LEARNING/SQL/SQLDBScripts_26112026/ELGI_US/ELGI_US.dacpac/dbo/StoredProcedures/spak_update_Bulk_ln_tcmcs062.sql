CREATE PROC [dbo].[spak_update_Bulk_ln_tcmcs062] @dl_id [nvarchar](50),@json [nvarchar](MAX) AS
begin

--delete from ln_tccom100 where bpid = @bpid;

CREATE TABLE #temp_usln_tcmcs062(
	[compnr] [numeric](10, 0) NULL,
	[cpcl] [varchar](254) NULL,
	[dsca] [varchar](254) NULL,
	[deleted] [varchar](254) NULL,
	[username] [varchar](254) NULL,
	[timestamp] [datetime] NULL,
	[sequen] [numeric](10, 0) NULL
)


INSERT INTO #temp_usln_tcmcs062 ([compnr],[cpcl],[dsca],[deleted],[username],[timestamp],[sequen]) SELECT * FROM OPENJSON (@json)
WITH(
    compnr nvarchar(50) '$.compnr',cpcl nvarchar(50) '$.cpcl',dsca nvarchar(50) '$.dsca.it_it',deleted nvarchar(100) '$.deleted',
    username nvarchar(max) '$.username',[timestamp] nvarchar(50) '$.timestamp',sequen nvarchar(50) '$.sequencenumber')


	DELETE usln_tcncs062 FROM usln_tcmcs062 INNER JOIN #temp_usln_tcmcs062 ON usln_tcmcs062.compnr = #temp_usln_tcmcs062.compnr
	 and usln_tcmcs062.cpcl = #temp_usln_tcmcs062.cpcl and usln_tcmcs062.dsca = #temp_usln_tcmcs062.dsca;


	INSERT INTO usln_tcmcs062 SELECT * FROM #temp_usln_tcmcs062;


	update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dl_id;


	drop table #temp_usln_tcmcs062;

end

GO

