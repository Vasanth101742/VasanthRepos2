CREATE PROC [dbo].[spak_update_bulk_ln_tcmcs015] @dlid [nvarchar](50),@json [nvarchar](max) AS      
begin      
  
CREATE TABLE #temp_usln_tcmcs015(
	[compnr] [varchar](254) NOT NULL,
	[ctyp] [varchar](254) NULL,
	[dscait_it] [varchar](254) NULL,
	[deleted] [varchar](254) NULL,
	[username] [varchar](254) NULL,
	[timestamp] [varchar](254) NULL,
	[sequencenumber] [varchar](254) NULL
)  
      
--delete from ln_cisli305 where compnr = @compnr and orno = @orno and stbp=@stbp and sotp = @sotp and pfbp=@pfbp and pfad = @pfad;      
      
INSERT INTO #temp_usln_tcmcs015 
           (compnr,
ctyp,
dscait_it,
deleted,
username,
timestamp,
sequencenumber)  
     SELECT * FROM OPENJSON (@json)  
  WITH(compnr varchar(50)  '$.compnr',
ctyp varchar(50)  '$.ctyp',
dscait_it varchar(50)  '$.dsca.it_IT',
deleted varchar(5)  '$.deleted',
username varchar(20)  '$.username',
timestamp varchar(20)  '$.timestamp',
sequencenumber varchar(50)  '$.sequencenumber')  
                          
  
  
    DELETE usln_tcmcs015 FROM usln_tcmcs015 INNER JOIN #temp_usln_tcmcs015 ON usln_tcmcs015.compnr = #temp_usln_tcmcs015.compnr and  
  usln_tcmcs015.ctyp = #temp_usln_tcmcs015.ctyp and usln_tcmcs015.dscait_it = #temp_usln_tcmcs015.dscait_it;
  
  
 INSERT INTO usln_tcmcs015 SELECT * FROM #temp_usln_tcmcs015;  
  
  
 update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dlid;  


 drop table #temp_usln_tcmcs015;
      
end

GO

