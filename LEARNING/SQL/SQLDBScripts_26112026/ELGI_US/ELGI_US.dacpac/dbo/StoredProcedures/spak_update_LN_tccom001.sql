CREATE PROC [dbo].[spak_update_LN_tccom001] @dl_id [nvarchar](50),@json [nvarchar](MAX) AS  
begin  
  
CREATE TABLE #temp_usln_tccom001(
	[compnr] [numeric](10, 0) NULL,
	[emno] [varchar](254) NULL,
	[nama] [varchar](254) NULL,
	[namb] [varchar](254) NULL,
	[namc] [varchar](254) NULL,
	[namd] [varchar](254) NULL,
	[deleted] [varchar](254) NULL,
	[username] [varchar](254) NULL,
	[timestamp] [datetime] NULL,
	[sequen] [numeric](10, 0) NULL
)  
  
insert into #temp_usln_tccom001(compnr,emno,nama,namb,namc,namd,deleted,username,[timestamp],sequen) SELECT * FROM OPENJSON (@json) WITH(  
    compnr nvarchar(50) '$.compnr',emno nvarchar(50) '$.emno',nama nvarchar(50) '$.nama.it_IT',  
 namb nvarchar(50) '$.namb.it_IT',namc nvarchar(50) '$.namc.it_IT',namd nvarchar(50) '$.namd.it_IT',deleted nvarchar(50) '$.deleted'
 ,username nvarchar(50) '$.username',[timestamp] nvarchar(50) '$.timestamp',sequen nvarchar(50) '$.sequencenumber')  
  
delete usln_tccom001 from usln_tccom001 INNER JOIN #temp_usln_tccom001 ON usln_tccom001.compnr= #temp_usln_tccom001.compnr and   
usln_tccom001.emno= #temp_usln_tccom001.emno 
  
INSERT INTO usln_tccom001 select * from #temp_usln_tccom001;  
  
update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dl_id;  
  

  drop table #temp_usln_tccom001;
  
end

GO

