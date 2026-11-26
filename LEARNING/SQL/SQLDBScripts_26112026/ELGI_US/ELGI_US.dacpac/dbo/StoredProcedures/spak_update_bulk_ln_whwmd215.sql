CREATE PROC [dbo].[spak_update_bulk_ln_whwmd215] @dlid [nvarchar](50),@json [nvarchar](max) AS        
begin        
    
CREATE TABLE #temp_usln_whwmd215(
	compnr varchar(50),
cwar varchar(50),
item varchar(50),
qhnd numeric(18,4),
qchd numeric(18,4),
qnhd varchar(50),
qblk numeric(18,4),
qbpl numeric(18,4),
qord numeric(18,4),
qoor varchar(50),
qcor numeric(18,4),
qnor varchar(50),
qgit varchar(50),
qint numeric(18,4),
qcit varchar(50),
qnit varchar(50),
qall numeric(18,4),
qoal varchar(50),
qcal numeric(18,4),
qnal varchar(50),
qnbl varchar(50),
qnbp varchar(50),
qcom numeric(18,4),
qlal numeric(18,4),
qcpr numeric(18,4),
qhrj varchar(50),
qcrj varchar(50),
qnrj varchar(50),
ltdt datetime2(0),
hstd datetime2(0),
lsid datetime2(0),
qcis numeric(18,4),
qhib numeric(18,4),
deleted varchar(50),
username varchar(50),
timestamp datetime2(0),
sequencenumber varchar(50)
)    
        
--delete from ln_cisli305 where compnr = @compnr and orno = @orno and stbp=@stbp and sotp = @sotp and pfbp=@pfbp and pfad = @pfad;        
        
INSERT INTO #temp_usln_whwmd215    
           (compnr,
cwar,
item,
qhnd,
qchd,
qnhd,
qblk,
qbpl,
qord,
qoor,
qcor,
qnor,
qgit,
qint,
qcit,
qnit,
qall,
qoal,
qcal,
qnal,
qnbl,
qnbp,
qcom,
qlal,
qcpr,
qhrj,
qcrj,
qnrj,
ltdt,
hstd,
lsid,
qcis,
qhib,
deleted,
username,
timestamp,
sequencenumber)    
     SELECT * FROM OPENJSON (@json)    
  WITH(compnr varchar(50) '$.compnr',
cwar varchar(50) '$.cwar',
item varchar(50) '$.item',
qhnd numeric(18,4) '$.qhnd',
qchd numeric(18,4) '$.qchd',
qnhd varchar(50) '$.qnhd',
qblk numeric(18,4) '$.qblk',
qbpl numeric(18,4) '$.qbpl',
qord numeric(18,4) '$.qord',
qoor varchar(50) '$.qoor',
qcor numeric(18,4) '$.qcor',
qnor varchar(50) '$.qnor',
qgit varchar(50) '$.qgit',
qint numeric(18,4) '$.qint',
qcit varchar(50) '$.qcit',
qnit varchar(50) '$.qnit',
qall numeric(18,4) '$.qall',
qoal varchar(50) '$.qoal',
qcal numeric(18,4) '$.qcal',
qnal varchar(50) '$.qnal',
qnbl varchar(50) '$.qnbl',
qnbp varchar(50) '$.qnbp',
qcom numeric(18,4) '$.qcom',
qlal numeric(18,4) '$.qlal',
qcpr numeric(18,4) '$.qcpr',
qhrj varchar(50) '$.qhrj',
qcrj varchar(50) '$.qcrj',
qnrj varchar(50) '$.qnrj',
ltdt datetime2(0) '$.ltdt',
hstd datetime2(0) '$.hstd',
lsid datetime2(0) '$.lsid',
qcis numeric(18,4) '$.qcis',
qhib numeric(18,4) '$.qhib',
deleted varchar(50) '$.deleted',
username varchar(50) '$.username',
timestamp datetime2(0) '$.timestamp',
sequencenumber varchar(50) '$.sequencenumber')    
                            
    
    
    DELETE usln_whwmd215 FROM usln_whwmd215 INNER JOIN #temp_usln_whwmd215 ON usln_whwmd215.compnr = #temp_usln_whwmd215.compnr and    
  usln_whwmd215.cwar = #temp_usln_whwmd215.cwar and usln_whwmd215.item = #temp_usln_whwmd215.item and usln_whwmd215.qhnd = #temp_usln_whwmd215.qhnd 
  and usln_whwmd215.qchd = #temp_usln_whwmd215.qchd and usln_whwmd215.qnhd = #temp_usln_whwmd215.qnhd;    
    
    
 INSERT INTO usln_whwmd215 SELECT * FROM #temp_usln_whwmd215;    
    
 update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dlid;    

 drop table #temp_usln_whwmd215;
        
end

GO

