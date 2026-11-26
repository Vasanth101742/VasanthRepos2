CREATE PROC [dbo].[spak_update_bulk_ln_tcmcs061] @dlid [nvarchar](50),@json [nvarchar](max) AS      
begin      
  
CREATE TABLE #temp_usln_tcmcs061(
	[compnr] [varchar](254) NOT NULL,
	[cpln] [varchar](254) NULL,
	[dscait_it] [varchar](254) NULL,
	[deleted] [varchar](254) NULL,
	[username] [varchar](254) NULL,
	[timestamp] [varchar](254) NULL,
	[sequencenumber] [varchar](254) NULL
)  
      
--delete from ln_cisli305 where compnr = @compnr and orno = @orno and stbp=@stbp and sotp = @sotp and pfbp=@pfbp and pfad = @pfad;      
      
INSERT INTO #temp_usln_tcmcs061 
           (compnr,
cpln,
dscait_it,
deleted,
username,
timestamp,
sequencenumber)  
     SELECT * FROM OPENJSON (@json)  
  WITH(compnr varchar(50)  '$.compnr',
cpln varchar(50)  '$.cpln',
dscait_it varchar(50)  '$.dsca.it_IT',
deleted varchar(50)  '$.deleted',
username varchar(20)  '$.username',
timestamp varchar(20)  '$.timestamp',
sequencenumber varchar(50)  '$.sequencenumber')  
                          
  
  
    DELETE usln_tcmcs061 FROM usln_tcmcs061 INNER JOIN #temp_usln_tcmcs061 ON usln_tcmcs061.compnr = #temp_usln_tcmcs061.compnr and  
  usln_tcmcs061.cpln = #temp_usln_tcmcs061.cpln and usln_tcmcs061.dscait_it = #temp_usln_tcmcs061.dscait_it;
  
  
 INSERT INTO usln_tcmcs061 SELECT * FROM #temp_usln_tcmcs061;  
  
  
 update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dlid;  


 drop table #temp_usln_tcmcs061;
      
end

GO

