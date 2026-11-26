CREATE PROC [dbo].[spak_update_Bulk_ln_tcibd001] @dl_id [nvarchar](50),@json [nvarchar](MAX) AS          
begin          
          
--delete from ln_tccom100 where bpid = @bpid;          
                  

CREATE TABLE #templn_tcibd001(
	[compnr] [numeric](10, 0) NULL,
	[item] [varchar](254) NULL,
	[dsca] [varchar](254) NULL,
	[kitm_kw] [varchar](254) NULL,
	[citg] [varchar](254) NULL,
	[cuni] [varchar](254) NULL,
	[cpcl] [varchar](254) NULL,
	[deleted] [varchar](254) NULL,
	[username] [varchar](254) NULL,
	[timestamp] [datetime] NULL,
	[sequen] [numeric](10, 0) NULL,
	[cpln] [nvarchar](254) NULL,
	[ctyp] [nvarchar](100) NULL
) 
          
          
INSERT INTO #templn_tcibd001 ([compnr],[item],[dsca],[kitm_kw],[citg],[cuni],[cpcl],[cpln],[deleted],[username],[timestamp],[sequen],ctyp) SELECT * FROM OPENJSON (@json)          
WITH(          
    compnr nvarchar(50) '$.compnr',item nvarchar(50) '$.item',dsca nvarchar(50) '$.dsca.it_IT',kitm_kw nvarchar(50) '$.kitm_kw',citg nvarchar(50) '$.citg',          
 cuni nvarchar(50) '$.cuni',cpcl nvarchar(50) '$.cpcl',cpln nvarchar(50) '$.cpln',deleted nvarchar(100) '$.deleted',          
    username nvarchar(max) '$.username',[timestamp] nvarchar(50) '$.timestamp',sequen nvarchar(50) '$.sequencenumber',ctyp nvarchar(50) '$.ctyp')          
          
          
 DELETE usln_tcibd001 FROM usln_tcibd001 INNER JOIN #templn_tcibd001 ON usln_tcibd001.compnr = #templn_tcibd001.compnr           
 and usln_tcibd001.item = #templn_tcibd001.item and usln_tcibd001.dsca = #templn_tcibd001.dsca and usln_tcibd001.citg = #templn_tcibd001.citg and usln_tcibd001.cuni = #templn_tcibd001.cuni 
 and usln_tcibd001.cpcl = #templn_tcibd001.cpcl and usln_tcibd001.cpln = #templn_tcibd001.cpln;          
          
          
 INSERT INTO usln_tcibd001 SELECT * FROM #templn_tcibd001;          
          
          
 update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dl_id;    
 
 drop table #templn_tcibd001;
          
end

GO

