CREATE PROC [dbo].[spak_update_bulk_ln_whinp100] @dlid [nvarchar](50),@json [nvarchar](max) AS        
begin        
    
CREATE TABLE #temp_usln_whinp100(
	compnr         INTEGER  NULL
  ,koor           INTEGER  NULL
  ,koor_kw        VARCHAR(200) NULL
  ,orno           VARCHAR(200) NULL
  ,kotr           BIT  NULL
  ,kotr_kw        VARCHAR(200) NULL
  ,pono           INTEGER  NULL
  ,ponb           BIT  NULL
  ,boml           BIT  NULL
  ,dlin           BIT  NULL
  ,effn           BIT  NULL
  ,item           VARCHAR(200) NULL
  ,atse           VARCHAR(200)
  ,cuni           VARCHAR(200) NULL
  ,plpl           INTEGER  NULL
  ,plpl_kw        VARCHAR(200) NULL
  ,pric numeric(18,4)  NULL
  ,ccur           VARCHAR(200) NULL
  ,chan           VARCHAR(200)
  ,qana           BIT  NULL
  ,qanp           BIT  NULL
  ,qorg           BIT  NULL
  ,qopu           BIT  NULL
  ,qinp           BIT  NULL
  ,qipp           BIT  NULL
  ,expl           BIT  NULL
  ,expp           BIT  NULL
  ,date           VARCHAR(200) NULL
  ,ordt           VARCHAR(200) NULL
  ,site           VARCHAR(200) NULL
  ,typw           BIT  NULL
  ,typw_kw        VARCHAR(200) NULL
  ,cwar           VARCHAR(200) NULL
  ,cwoc           VARCHAR(200)
  ,bpid           VARCHAR(200) NULL
  ,cprj           VARCHAR(200)
  ,cact           VARCHAR(200)
  ,ccco           VARCHAR(200)
  ,bfst           VARCHAR(200) NULL
  ,iscn           BIT  NULL
  ,prio           INTEGER  NULL
  ,blck           INTEGER  NULL
  ,blck_kw        VARCHAR(200) NULL
  ,oprs           INTEGER  NULL
  ,cornit_IT      VARCHAR(200)
  ,owns           INTEGER  NULL
  ,ownr           VARCHAR(200)
  ,spcn           VARCHAR(200)
  ,subc           INTEGER  NULL
  ,subc_kw        VARCHAR(200) NULL
  ,topl           INTEGER  NULL
  ,topl_kw        VARCHAR(200) NULL
  ,pptl           INTEGER  NULL
  ,pptl_kw        VARCHAR(200) NULL
  ,deleted        VARCHAR(200) NULL
  ,username       VARCHAR(200) NULL
  ,timestamp      VARCHAR(200) NULL
  ,sequencenumber INTEGER  NULL
)    
        
--delete from ln_cisli305 where compnr = @compnr and orno = @orno and stbp=@stbp and sotp = @sotp and pfbp=@pfbp and pfad = @pfad;        
        
INSERT INTO #temp_usln_whinp100    
           (compnr,
koor,
koor_kw,
orno,
kotr,
kotr_kw,
pono,
ponb,
boml,
dlin,
effn,
item,
atse,
cuni,
plpl,
plpl_kw,
pric,
ccur,
chan,
qana,
qanp,
qorg,
qopu,
qinp,
qipp,
expl,
expp,
date,
ordt,
site,
typw,
typw_kw,
cwar,
cwoc,
bpid,
cprj,
cact,
ccco,
bfst,
iscn,
prio,
blck,
blck_kw,
oprs,
cornit_IT,
owns,
ownr,
spcn,
subc,
subc_kw,
topl,
topl_kw,
pptl,
pptl_kw,
deleted,
username,
timestamp,
sequencenumber)    
     SELECT * FROM OPENJSON (@json)    
  WITH(compnr INTEGER '$.compnr',
koor INTEGER '$.koor',
koor_kw VARCHAR(200) '$.koor_kw',
orno VARCHAR(200) '$.orno',
kotr BIT '$.kotr',
kotr_kw VARCHAR(200) '$.kotr_kw',
pono INTEGER '$.pono',
ponb BIT '$.ponb',
boml BIT '$.boml',
dlin BIT '$.dlin',
effn BIT '$.effn',
item VARCHAR(200) '$.item',
atse VARCHAR(200) '$.atse',
cuni VARCHAR(200) '$.cuni',
plpl INTEGER '$.plpl',
plpl_kw VARCHAR(200) '$.plpl_kw',
pric numeric(18,4) '$.pric',
ccur VARCHAR(200) '$.ccur',
chan VARCHAR(200) '$.chan',
qana BIT '$.qana',
qanp BIT '$.qanp',
qorg BIT '$.qorg',
qopu BIT '$.qopu',
qinp BIT '$.qinp',
qipp BIT '$.qipp',
expl BIT '$.expl',
expp BIT '$.expp',
date VARCHAR(200) '$.date',
ordt VARCHAR(200) '$.ordt',
site VARCHAR(200) '$.site',
typw BIT '$.typw',
typw_kw VARCHAR(200) '$.typw_kw',
cwar VARCHAR(200) '$.cwar',
cwoc VARCHAR(200) '$.cwoc',
bpid VARCHAR(200) '$.bpid',
cprj VARCHAR(200) '$.cprj',
cact VARCHAR(200) '$.cact',
ccco VARCHAR(200) '$.ccco',
bfst VARCHAR(200) '$.bfst',
iscn BIT '$.iscn',
prio INTEGER '$.prio',
blck INTEGER '$.blck',
blck_kw VARCHAR(200) '$.blck_kw',
oprs INTEGER '$.oprs',
cornit_IT VARCHAR(200) '$.cornit_IT',
owns INTEGER '$.owns',
ownr VARCHAR(200) '$.ownr',
spcn VARCHAR(200) '$.spcn',
subc INTEGER '$.subc',
subc_kw VARCHAR(200) '$.subc_kw',
topl INTEGER '$.topl',
topl_kw VARCHAR(200) '$.topl_kw',
pptl INTEGER '$.pptl',
pptl_kw VARCHAR(200) '$.pptl_kw',
deleted VARCHAR(200) '$.deleted',
username VARCHAR(200) '$.username',
timestamp VARCHAR(200) '$.timestamp',
sequencenumber INTEGER '$.sequencenumber')    
                            
    
    
    DELETE usln_whinp100 FROM usln_whinp100 INNER JOIN #temp_usln_whinp100 ON usln_whinp100.compnr = #temp_usln_whinp100.compnr and    
  usln_whinp100.koor = #temp_usln_whinp100.koor and usln_whinp100.orno = #temp_usln_whinp100.orno and usln_whinp100.pono = #temp_usln_whinp100.pono 
  and usln_whinp100.item = #temp_usln_whinp100.item;    
    
    
 INSERT INTO usln_whinp100 SELECT * FROM #temp_usln_whinp100;    
    
    
 update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dlid;    

 drop table #temp_usln_whinp100;
        
end

GO

