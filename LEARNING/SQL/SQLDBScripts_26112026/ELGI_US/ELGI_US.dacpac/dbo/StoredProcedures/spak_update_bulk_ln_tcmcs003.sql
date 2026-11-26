CREATE PROC [dbo].[spak_update_bulk_ln_tcmcs003] @dlid [nvarchar](50),@json [nvarchar](max) AS      
begin      
  
CREATE TABLE #temp_usln_tcmcs003(
	[compnr] [varchar](254) NULL,
	[cwar] [varchar](254) NULL,
	[dscait_it] [varchar](254) NULL,
	[cadr] [varchar](254) NULL,
	[typw] [int] NULL,
	[typw_kw] [varchar](254) NULL,
	[cprj] [varchar](254) NULL,
	[bpid] [varchar](254) NULL,
	[comp] [int] NULL,
	[wmsc] [int] NULL,
	[wmsc_kw] [varchar](254) NULL,
	[casi] [varchar](254) NULL,
	[inep] [varchar](254) NULL,
	[inep_kw] [varchar](254) NULL,
	[imgt] [varchar](254) NULL,
	[imgt_kw] [varchar](254) NULL,
	[imbp] [varchar](254) NULL,
	[xsit] [varchar](254) NULL,
	[xsit_kw] [varchar](254) NULL,
	[xsbp] [varchar](254) NULL,
	[sfbp] [varchar](254) NULL,
	[otbp] [varchar](254) NULL,
	[stbp] [varchar](254) NULL,
	[ofbp] [varchar](254) NULL,
	[clan] [varchar](254) NULL,
	[pwip] [varchar](254) NULL,
	[pwip_kw] [varchar](254) NULL,
	[swhu] [varchar](254) NULL,
	[swhu_kw] [varchar](254) NULL,
	[duns] [varchar](254) NULL,
	[cdf_otyp] [varchar](254) NULL,
	[cadr_ref_compnr] [varchar](254) NULL,
	[cprj_ref_compnr] [varchar](254) NULL,
	[casi_ref_compnr] [varchar](254) NULL,
	[imbp_ref_compnr] [varchar](254) NULL,
	[xsbp_ref_compnr] [varchar](254) NULL,
	[sfbp_ref_compnr] [varchar](254) NULL,
	[otbp_ref_compnr] [varchar](254) NULL,
	[stbp_ref_compnr] [varchar](254) NULL,
	[ofbp_ref_compnr] [varchar](254) NULL,
	[clan_ref_compnr] [varchar](254) NULL,
	[cwar_eunt] [varchar](254) NULL,
	[eunt_rcmp] [varchar](254) NULL,
	[deleted] [varchar](254) NULL,
	[username] [varchar](254) NULL,
	[timestamp] [datetime2](0) NULL,
	[sequencenumber] [varchar](254) NULL
)  
      
--delete from ln_cisli305 where compnr = @compnr and orno = @orno and stbp=@stbp and sotp = @sotp and pfbp=@pfbp and pfad = @pfad;      
      
INSERT INTO #temp_usln_tcmcs003  
           (compnr,
	cwar,
	dscait_it,
	cadr,
	typw,
	typw_kw,
	cprj,
	bpid,
	comp,
	wmsc,
	wmsc_kw,
	casi,
	inep,
	inep_kw,
	imgt,
	imgt_kw,
	imbp,
	xsit,
	xsit_kw,
	xsbp,
	sfbp,
	otbp,
	stbp,
	ofbp,
	clan,
	pwip,
	pwip_kw,
	swhu,
	swhu_kw,
	duns,
	cdf_otyp,
	cadr_ref_compnr,
	cprj_ref_compnr,
	casi_ref_compnr,
	imbp_ref_compnr,
	xsbp_ref_compnr,
	sfbp_ref_compnr,
	otbp_ref_compnr,
	stbp_ref_compnr,
	ofbp_ref_compnr,
	clan_ref_compnr,
	cwar_eunt,
	eunt_rcmp,
	deleted,
	username,
	timestamp,
	sequencenumber)  
     SELECT * FROM OPENJSON (@json)  
  WITH(compnr varchar(50)  '$.compnr',
cwar varchar(30)  '$.cwar',
dscait_it varchar(30)  '$.dscait_it',
cadr varchar(30)  '$.cadr',
typw int  '$.typw',
typw_kw varchar(30)  '$.typw_kw',
cprj varchar(30)  '$.cprj',
bpid varchar(30)  '$.bpid',
comp int  '$.comp',
wmsc int  '$.wmsc',
wmsc_kw varchar(50)  '$.wmsc_kw',
casi varchar(30)  '$.casi',
inep varchar(50)  '$.inep',
inep_kw varchar(30)  '$.inep_kw',
imgt varchar(50)  '$.imgt',
imgt_kw varchar(50)  '$.imgt_kw',
imbp varchar(30)  '$.imbp',
xsit varchar(50)  '$.xsit',
xsit_kw varchar(20)  '$.xsit_kw',
xsbp varchar(30)  '$.xsbp',
sfbp varchar(30)  '$.sfbp',
otbp varchar(30)  '$.otbp',
stbp varchar(30)  '$.stbp',
ofbp varchar(30)  '$.ofbp',
clan varchar(30)  '$.clan',
pwip varchar(50)  '$.pwip',
pwip_kw varchar(30)  '$.pwip_kw',
swhu varchar(50)  '$.swhu',
swhu_kw varchar(50)  '$.swhu_kw',
duns varchar(50)  '$.duns',
cdf_otyp varchar(30)  '$.cdf_otyp',
cadr_ref_compnr varchar(50)  '$.cadr_ref_compnr',
cprj_ref_compnr varchar(50)  '$.cprj_ref_compnr',
casi_ref_compnr varchar(50)  '$.casi_ref_compnr',
imbp_ref_compnr varchar(50)  '$.imbp_ref_compnr',
xsbp_ref_compnr varchar(50)  '$.xsbp_ref_compnr',
sfbp_ref_compnr varchar(50)  '$.sfbp_ref_compnr',
otbp_ref_compnr varchar(50)  '$.otbp_ref_compnr',
stbp_ref_compnr varchar(50)  '$.stbp_ref_compnr',
ofbp_ref_compnr varchar(50)  '$.ofbp_ref_compnr',
clan_ref_compnr varchar(50)  '$.clan_ref_compnr',
cwar_eunt varchar(10)  '$.cwar_eunt',
eunt_rcmp varchar(50)  '$.eunt_rcmp',
deleted varchar(10)  '$.deleted',
username varchar(10)  '$.username',
timestamp datetime2(0)  '$.timestamp',
sequencenumber varchar(50)  '$.sequencenumber')  
                          
  
  
    DELETE usln_tcmcs003 FROM usln_tcmcs003 INNER JOIN #temp_usln_tcmcs003 ON usln_tcmcs003.compnr = #temp_usln_tcmcs003.compnr and  
  usln_tcmcs003.cwar = #temp_usln_tcmcs003.cwar and usln_tcmcs003.cadr = #temp_usln_tcmcs003.cadr   
  and usln_tcmcs003.typw = #temp_usln_tcmcs003.typw and usln_tcmcs003.cprj = #temp_usln_tcmcs003.cprj
  and usln_tcmcs003.bpid = #temp_usln_tcmcs003.bpid and usln_tcmcs003.comp = #temp_usln_tcmcs003.comp;  
  
  
 INSERT INTO usln_tcmcs003 SELECT * FROM #temp_usln_tcmcs003;  
  
  
 update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dlid;  


 drop table #temp_usln_tcmcs003;
      
end

GO

