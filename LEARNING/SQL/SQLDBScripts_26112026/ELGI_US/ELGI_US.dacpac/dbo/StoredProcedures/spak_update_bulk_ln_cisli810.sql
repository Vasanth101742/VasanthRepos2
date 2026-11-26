CREATE PROC [dbo].[spak_update_bulk_ln_cisli810] @dlid [nvarchar](50),@json [nvarchar](max) AS      
begin      
  
CREATE TABLE #temp_usln_cisli810(
	[compnr] [varchar](254) NULL,
	[srcp] [varchar](254) NULL,
	[srtp] [varchar](254) NULL,
	[srtp_kw] [varchar](254) NULL,
	[orno] [varchar](254) NULL,
	[pono] [varchar](254) NULL,
	[oref] [varchar](254) NULL,
	[tref] [varchar](254) NULL,
	[bseq] [varchar](254) NULL,
	[sfcp] [varchar](254) NULL,
	[tran] [varchar](254) NULL,
	[idoc] [varchar](254) NULL,
	[line] [varchar](254) NULL,
	[stat] [varchar](254) NULL,
	[stat_kw] [varchar](254) NULL,
	[codt] [datetime2](0) NULL,
	[brid] [varchar](254) NULL,
	[koor] [varchar](254) NULL,
	[koor_kw] [varchar](254) NULL,
	[ofbp] [varchar](254) NULL,
	[itbp] [varchar](254) NULL,
	[styp] [varchar](254) NULL,
	[apdt] [datetime2](0) NULL,
	[crep] [varchar](254) NULL,
	[cprj] [varchar](254) NULL,
	[bemp] [varchar](254) NULL,
	[amti] [numeric](18, 4) NULL,
	[comrit_it] [varchar](254) NULL,
	[bona] [varchar](254) NULL,
	[guid] [varchar](254) NULL,
	[sotp] [varchar](254) NULL,
	[srco] [varchar](254) NULL,
	[cstp] [varchar](254) NULL,
	[astm] [datetime2](0) NULL,
	[tdoc] [varchar](254) NULL,
	[tdoc_kw] [varchar](254) NULL,
	[tinv] [varchar](254) NULL,
	[tinv_kw] [varchar](254) NULL,
	[tceb] [varchar](254) NULL,
	[tceb_kw] [varchar](254) NULL,
	[deleted] [bit] NULL,
	[username] [varchar](254) NULL,
	[timestamp] [datetime2](0) NULL,
	[sequencenumber] [varchar](254) NULL
)  
      
--delete from ln_cisli305 where compnr = @compnr and orno = @orno and stbp=@stbp and sotp = @sotp and pfbp=@pfbp and pfad = @pfad;      
      
INSERT INTO #temp_usln_cisli810  
           (compnr,
srcp,
srtp,
srtp_kw,
orno,
pono,
oref,
tref,
bseq,
sfcp,
[tran],
idoc,
line,
stat,
stat_kw,
codt,
brid,
koor,
koor_kw,
ofbp,
itbp,
styp,
apdt,
crep,
cprj,
bemp,
amti,
comrit_it,
bona,
guid,
sotp,
srco,
cstp,
astm,
tdoc,
tdoc_kw,
tinv,
tinv_kw,
tceb,
tceb_kw,
deleted,
username,
[timestamp],
sequencenumber)  
     SELECT * FROM OPENJSON (@json)  
  WITH(compnr character varying(30) '$.compnr',
srcp character varying(30) '$.srcp',
srtp character varying(30) '$.srtp',
srtp_kw character varying(30) '$.srtp_kw',
orno character varying(30) '$.orno',
pono character varying(30) '$.pono',
oref character varying(50) '$.oref',
tref character varying(50) '$.tref',
bseq character varying(30) '$.bseq',
sfcp character varying(30) '$.sfcp',
[tran] character varying(50) '$.tran',
idoc character varying(30) '$.idoc',
line character varying(30) '$.line',
stat character varying(30) '$.stat',
stat_kw character varying(30) '$.stat_kw',
codt datetime2(0)  '$.codt',
brid character varying(30) '$.brid',
koor character varying(30) '$.koor',
koor_kw character varying(30) '$.koor_kw',
ofbp character varying(30) '$.ofbp',
itbp character varying(30) '$.itbp',
styp character varying(30) '$.styp',
apdt datetime2(0)  '$.apdt',
crep character varying(50) '$.crep',
cprj character varying(50) '$.cprj',
bemp character varying(50) '$.bemp',
amti numeric(18,4)  '$.amti',
comrit_it character varying(50) '$.comrit_it',
bona character varying(20) '$.bona',
guid character varying(50) '$.guid',
sotp character varying(50) '$.sotp',
srco character varying(50) '$.srco',
cstp character varying(50) '$.cstp',
astm datetime2(0)  '$.astm',
tdoc character varying(30) '$.tdoc',
tdoc_kw character varying(50) '$.tdoc_kw',
tinv character varying(30) '$.tinv',
tinv_kw character varying(50) '$.tinv_kw',
tceb character varying(30) '$.tceb',
tceb_kw character varying(30) '$.tceb_kw',
deleted bit  '$.deleted',
username character varying(20) '$.username',
[timestamp] datetime2(0)  '$.timestamp',
sequencenumber character varying(30) '$.sequencenumber')  
                          
  
  
    DELETE usln_cisli810 FROM usln_cisli810 INNER JOIN #temp_usln_cisli810 ON usln_cisli810.compnr = #temp_usln_cisli810.compnr and  
  usln_cisli810.[tran] = #temp_usln_cisli810.[tran] and usln_cisli810.sfcp = #temp_usln_cisli810.sfcp   
  and usln_cisli810.idoc = #temp_usln_cisli810.idoc and usln_cisli810.line = #temp_usln_cisli810.line;  
  
  
 INSERT INTO usln_cisli810 SELECT * FROM #temp_usln_cisli810;  
  
  
 update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dlid;  


 drop table #temp_usln_cisli810;
      
end

GO

