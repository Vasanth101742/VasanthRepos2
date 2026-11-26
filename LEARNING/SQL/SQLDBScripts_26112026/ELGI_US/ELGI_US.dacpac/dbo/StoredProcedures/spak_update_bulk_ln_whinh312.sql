CREATE PROC [dbo].[spak_update_bulk_ln_whinh312] @dlid [nvarchar](50),@json [nvarchar](max) AS        
begin        
    
CREATE TABLE #temp_usln_whinh312(
	compnr int,
rcno varchar(50),
rcln int,
oorg int,
oorg_kw varchar(50),
orno varchar(50),
ardt datetime2(0),
oset int,
pono int,
seqn int,
sfbp varchar(50),
item varchar(50),
psnoit_it varchar(50),
cwar varchar(50),
actiit_it varchar(50),
lsta int,
lsta_kw varchar(50),
cmpl int,
cmpl_kw varchar(50),
conf int,
conf_kw varchar(50),
insp int,
insp_kw varchar(50),
blck int,
blck_kw varchar(50),
logn varchar(50),
deleted bit,
username varchar(20),
timestamp datetime2(0),
sequencenumber int
)    
        
--delete from ln_cisli305 where compnr = @compnr and orno = @orno and stbp=@stbp and sotp = @sotp and pfbp=@pfbp and pfad = @pfad;        
        
INSERT INTO #temp_usln_whinh312    
           (compnr,
rcno,
rcln,
oorg,
oorg_kw,
orno,
ardt,
oset,
pono,
seqn,
sfbp,
item,
psnoit_it,
cwar,
actiit_it,
lsta,
lsta_kw,
cmpl,
cmpl_kw,
conf,
conf_kw,
insp,
insp_kw,
blck,
blck_kw,
logn,
deleted,
username,
timestamp,
sequencenumber)    
     SELECT * FROM OPENJSON (@json)    
  WITH(compnr int '$.compnr',
rcno varchar(50) '$.rcno',
rcln int '$.rcln',
oorg int '$.oorg',
oorg_kw varchar(50) '$.oorg_kw',
orno varchar(50) '$.orno',
ardt datetime2(0) '$.ardt',
oset int '$.oset',
pono int '$.pono',
seqn int '$.seqn',
sfbp varchar(50) '$.sfbp',
item varchar(50) '$.item',
psnoit_it varchar(50) '$.psnoit_it',
cwar varchar(50) '$.cwar',
actiit_it varchar(50) '$.actiit_it',
lsta int '$.lsta',
lsta_kw varchar(50) '$.lsta_kw',
cmpl int '$.cmpl',
cmpl_kw varchar(50) '$.cmpl_kw',
conf int '$.conf',
conf_kw varchar(50) '$.conf_kw',
insp int '$.insp',
insp_kw varchar(50) '$.insp_kw',
blck int '$.blck',
blck_kw varchar(50) '$.blck_kw',
logn varchar(50) '$.logn',
deleted bit '$.deleted',
username varchar(20) '$.username',
timestamp datetime2(0) '$.timestamp',
sequencenumber int '$.sequencenumber')    
                            
    
    
    DELETE usln_whinh312 FROM usln_whinh312 INNER JOIN #temp_usln_whinh312 ON usln_whinh312.compnr = #temp_usln_whinh312.compnr and    
  usln_whinh312.rcno = #temp_usln_whinh312.rcno and usln_whinh312.rcln = #temp_usln_whinh312.rcln and usln_whinh312.oorg = #temp_usln_whinh312.oorg 
  and usln_whinh312.orno = #temp_usln_whinh312.orno and usln_whinh312.pono = #temp_usln_whinh312.pono;    
    
    
 INSERT INTO usln_whinh312 SELECT * FROM #temp_usln_whinh312;    
    
 update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dlid;    

 drop table #temp_usln_whinh312;
        
end

GO

