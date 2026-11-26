CREATE PROC [dbo].[spak_update_ln_tccom130] @dl_id [nvarchar](50),@json [nvarchar](MAX) AS  
begin  
  
CREATE TABLE #temp_usln_tccom130(
   compnr         INTEGER NULL 
  ,cadr           VARCHAR(50) NULL
  ,namcit_IT      VARCHAR(50) NULL
  ,pstcit_IT      VARCHAR(50) NULL
  ,telp           VARCHAR(50)
  ,telx           VARCHAR(50)
  ,ccit           VARCHAR(50) NULL
  ,ccty           VARCHAR(50) NULL
  ,cste           VARCHAR(50) NULL
  ,bldgit_IT      VARCHAR(50)
  ,blflit_IT      VARCHAR(50)
  ,blunit_IT      VARCHAR(50)
  ,seakit_IT      VARCHAR(50) NULL
  ,geoc           VARCHAR(50) NULL
  ,cntyit_IT      VARCHAR(50)
  ,tzid           VARCHAR(50)  NULL
  ,foid           VARCHAR(50)  NULL
  ,[user]         VARCHAR(50) NULL
  ,vatl           VARCHAR(50)
  ,glat           nvarchar(250) NULL
  ,glon           nvarchar(250) NULL
  ,valr           BIT  NULL
  ,valr_kw        VARCHAR(50) NULL
  ,ln02it_IT      VARCHAR(50) NULL
  ,deleted        VARCHAR(50) NULL
  ,username       VARCHAR(50) NULL
  ,timestamp      VARCHAR(50) NULL
  ,sequencenumber INTEGER  NULL
);  
  
insert into #temp_usln_tccom130(compnr,
cadr,
namcit_IT,
pstcit_IT,
telp,
telx,
ccit,
ccty,
cste,
bldgit_IT,
blflit_IT,
blunit_IT,
seakit_IT,
geoc,
cntyit_IT,
tzid,
foid,
[user],
vatl,
glat,
glon,
valr,
valr_kw,
ln02it_IT,
deleted,
username,
timestamp,
sequencenumber) SELECT * FROM OPENJSON (@json) WITH(  
    compnr INTEGER '$.compnr',
cadr VARCHAR(50) '$.cadr',
namcit_IT VARCHAR(50) '$.namc.it_IT',
pstcit_IT VARCHAR(50) '$.pstc.it_IT',
telp VARCHAR(50) '$.telp',
telx VARCHAR(50) '$.telx',
ccit VARCHAR(50) '$.ccit',
ccty VARCHAR(50) '$.ccty',
cste VARCHAR(50) '$.cste',
bldgit_IT VARCHAR(50) '$.bldg.it_IT',
blflit_IT VARCHAR(50) '$.blfl.it_IT',
blunit_IT VARCHAR(50) '$.blun.it_IT',
seakit_IT VARCHAR(50) '$.seak.it_IT',
geoc VARCHAR(50) '$.geoc',
cntyit_IT VARCHAR(50) '$.cnty.it_IT',
tzid VARCHAR(50) '$.tzid',
foid VARCHAR(50) '$.foid',
[user] VARCHAR(50) '$.user',
vatl VARCHAR(50) '$.vatl',
glat nvarchar(250) '$.glat',
glon nvarchar(250) '$.glon',
valr BIT '$.valr',
valr_kw VARCHAR(50) '$.valr_kw',
ln02it_IT VARCHAR(50) '$.ln02.it_IT',
deleted VARCHAR(50) '$.deleted',
username VARCHAR(50) '$.username',
timestamp VARCHAR(50) '$.timestamp',
sequencenumber INTEGER '$.sequencenumber')  
  
delete usln_tccom130 from usln_tccom130 INNER JOIN #temp_usln_tccom130 ON usln_tccom130.compnr= #temp_usln_tccom130.compnr and   
usln_tccom130.ccty= #temp_usln_tccom130.ccty and usln_tccom130.cste= #temp_usln_tccom130.cste  
  
INSERT INTO usln_tccom130 select * from #temp_usln_tccom130;  
  
update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dl_id;  
  
drop table #temp_usln_tccom130;
  
end

GO

