CREATE PROC [dbo].[spak_update_bulk_ln_whinh310] @dlid [nvarchar](50),@json [nvarchar](max) AS        
begin        
    
CREATE TABLE #temp_usln_whinh310(
	compnr int,
rcno varchar(30),
fval bit,
curr varchar(50),
dinoit_it varchar(50),
port varchar(50),
stat int,
stat_kw varchar(50),
deleted bit,
username varchar(20),
timestamp datetime2(0),
sequencenumber int
)    
        
--delete from ln_cisli305 where compnr = @compnr and orno = @orno and stbp=@stbp and sotp = @sotp and pfbp=@pfbp and pfad = @pfad;        
        
INSERT INTO #temp_usln_whinh310    
           (compnr,
rcno,
fval,
curr,
dinoit_it,
port,
stat,
stat_kw,
deleted,
username,
timestamp,
sequencenumber)    
     SELECT * FROM OPENJSON (@json)    
  WITH(compnr int '$.compnr',
rcno varchar(30) '$.rcno',
fval bit '$.fval',
curr varchar(50) '$.curr',
dinoit_it varchar(50) '$.dinoit_it',
port varchar(50) '$.port',
stat int '$.stat',
stat_kw varchar(50) '$.stat_kw',
deleted bit '$.deleted',
username varchar(20) '$.username',
timestamp datetime2(0) '$.timestamp',
sequencenumber int '$.sequencenumber')    
                            
    
    
    DELETE usln_whinh310 FROM usln_whinh310 INNER JOIN #temp_usln_whinh310 ON usln_whinh310.compnr = #temp_usln_whinh310.compnr and    
  usln_whinh310.rcno = #temp_usln_whinh310.rcno and usln_whinh310.fval = #temp_usln_whinh310.fval and usln_whinh310.curr = #temp_usln_whinh310.curr 
  and usln_whinh310.port = #temp_usln_whinh310.port;    
    
    
 INSERT INTO usln_whinh310 SELECT * FROM #temp_usln_whinh310;    
    
 update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dlid;    

 drop table #temp_usln_whinh310;
        
end

GO

