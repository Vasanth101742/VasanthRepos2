CREATE PROC [dbo].[spak_update_ln_Ln_tcmcs065] @dl_id [nvarchar](50),@json [nvarchar](MAX) AS  
begin  
  
CREATE TABLE #temp_usln_tcmcs065(
	[compnr] [numeric](10, 0) NULL,
	[cwoc] [varchar](254) NULL,
	[dsca] [varchar](254) NULL,
	[deleted] [varchar](254) NULL,
	[username] [varchar](254) NULL,
	[timestamp] [datetime] NULL,
	[sequen] [numeric](10, 0) NULL
)  
  
insert into #temp_usln_tcmcs065(compnr,cwoc,dsca,deleted,username,[timestamp],sequen) SELECT * FROM OPENJSON (@json) WITH(  
    compnr nvarchar(50) '$.compnr',cwoc nvarchar(50) '$.cwoc',dsca nvarchar(50) '$.dsca.it_IT',  
 deleted nvarchar(50) '$.deleted',username nvarchar(50) '$.username',  
 [timestamp] nvarchar(50) '$.timestamp',sequen nvarchar(50) '$.sequencenumber')  
  
delete usln_tcmcs065 from usln_tcmcs065 INNER JOIN #temp_usln_tcmcs065 ON usln_tcmcs065.compnr= #temp_usln_tcmcs065.compnr and   
usln_tcmcs065.cwoc= #temp_usln_tcmcs065.cwoc --and ln_tcmcs045.cste= temp_ln_tcmcs045.cste and ln_tcmcs045.city= temp_ln_tcmcs045.city  
  
INSERT INTO usln_tcmcs065 select * from #temp_usln_tcmcs065;  
  
update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dl_id;  
 
drop table #temp_usln_tcmcs065;
 
end

GO

