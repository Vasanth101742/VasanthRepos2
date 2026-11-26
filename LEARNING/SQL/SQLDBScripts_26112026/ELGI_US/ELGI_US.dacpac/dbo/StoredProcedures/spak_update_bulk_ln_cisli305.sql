CREATE PROC [dbo].[spak_update_bulk_ln_cisli305] @dlid [nvarchar](50),@json [nvarchar](max) AS        
begin        
    
CREATE TABLE #temp_usln_cisli305(
	[compnr] [nvarchar](254) NULL,
	[sfcp] [nvarchar](254) NULL,
	[tran] [varchar](254) NULL,
	[idoc] [varchar](254) NULL,
	[scmp] [nvarchar](254) NULL,
	[brid] [varchar](254) NULL,
	[doct_kw] [varchar](254) NULL,
	[stat_kw] [varchar](254) NULL,
	[idat] [datetime] NULL,
	[rtdt] [datetime] NULL,
	[fdpt] [varchar](254) NULL,
	[itbp] [varchar](254) NULL,
	[pfbp] [varchar](254) NULL,
	[opbp] [varchar](254) NULL,
	[itoa] [varchar](254) NULL,
	[pfoa] [varchar](254) NULL,
	[ccur] [varchar](254) NULL,
	[cpay] [varchar](254) NULL,
	[ccrs] [varchar](254) NULL,
	[cidm] [varchar](254) NULL,
	[paym] [varchar](254) NULL,
	[txct] [varchar](254) NULL,
	[regt] [varchar](254) NULL,
	[jurl_kw] [varchar](254) NULL,
	[jurc] [varchar](254) NULL,
	[reeu] [varchar](254) NULL,
	[regc] [varchar](254) NULL,
	[rseq] [nvarchar](254) NULL,
	[reid] [varchar](254) NULL,
	[rexp_kw] [varchar](254) NULL,
	[bpct] [varchar](254) NULL,
	[bprt] [varchar](254) NULL,
	[bpjl_kw] [varchar](254) NULL,
	[bpjc] [varchar](254) NULL,
	[bpri] [varchar](254) NULL,
	[trde_kw] [varchar](254) NULL,
	[fyer] [nvarchar](254) NULL,
	[fper] [nvarchar](254) NULL,
	[ryer] [nvarchar](254) NULL,
	[rper] [nvarchar](254) NULL,
	[txyr] [nvarchar](254) NULL,
	[txpr] [nvarchar](254) NULL,
	[fcrt_kw] [varchar](254) NULL,
	[cinm] [varchar](254) NULL,
	[repl_kw] [varchar](254) NULL,
	[styp] [varchar](254) NULL,
	[invt_kw] [varchar](254) NULL,
	[sapr_kw] [varchar](254) NULL,
	[uapr_kw] [varchar](254) NULL,
	[comr] [varchar](254) NULL,
	[cban] [varchar](254) NULL,
	[lmbi_kw] [varchar](254) NULL,
	[fman_kw] [varchar](254) NULL,
	[abct_kw] [varchar](254) NULL,
	[sbim_kw] [varchar](254) NULL,
	[rinv_kw] [varchar](254) NULL,
	[rpan_kw] [varchar](254) NULL,
	[apdt] [datetime] NULL,
	[rtyp] [varchar](254) NULL,
	[rate_1] [nvarchar](254) NULL,
	[rate_2] [nvarchar](254) NULL,
	[rate_3] [nvarchar](254) NULL,
	[ratf_1] [nvarchar](254) NULL,
	[ratf_2] [nvarchar](254) NULL,
	[ratf_3] [nvarchar](254) NULL,
	[ratd] [datetime] NULL,
	[dim1] [varchar](254) NULL,
	[dim2] [varchar](254) NULL,
	[dim3] [varchar](254) NULL,
	[dim4] [varchar](254) NULL,
	[dim5] [varchar](254) NULL,
	[dim6] [varchar](254) NULL,
	[dim7] [varchar](254) NULL,
	[dim8] [varchar](254) NULL,
	[dim9] [varchar](254) NULL,
	[dm254] [varchar](254) NULL,
	[dm11] [varchar](254) NULL,
	[dm12] [varchar](254) NULL,
	[cvat] [varchar](254) NULL,
	[cofc] [varchar](254) NULL,
	[crep] [varchar](254) NULL,
	[msid] [varchar](254) NULL,
	[cbrn] [varchar](254) NULL,
	[creg] [varchar](254) NULL,
	[posa_kw] [varchar](254) NULL,
	[deln] [varchar](254) NULL,
	[ofbp] [varchar](254) NULL,
	[ofad] [varchar](254) NULL,
	[stbp] [varchar](254) NULL,
	[stoa] [varchar](254) NULL,
	[cono] [varchar](254) NULL,
	[cnln] [varchar](254) NULL,
	[cprj] [varchar](254) NULL,
	[cdoc] [varchar](254) NULL,
	[cslo] [varchar](254) NULL,
	[cslt] [varchar](254) NULL,
	[cins] [varchar](254) NULL,
	[cpuo] [varchar](254) NULL,
	[cput] [varchar](254) NULL,
	[cwho] [varchar](254) NULL,
	[cwht] [varchar](254) NULL,
	[cshp] [varchar](254) NULL,
	[cpcs] [varchar](254) NULL,
	[csvo] [varchar](254) NULL,
	[csvt] [varchar](254) NULL,
	[csvc] [varchar](254) NULL,
	[cmso] [varchar](254) NULL,
	[cmst] [varchar](254) NULL,
	[cmsc] [varchar](254) NULL,
	[cscl] [varchar](254) NULL,
	[cscc] [varchar](254) NULL,
	[csco] [varchar](254) NULL,
	[csct] [varchar](254) NULL,
	[cfro] [varchar](254) NULL,
	[creb] [varchar](254) NULL,
	[srtp_kw] [varchar](254) NULL,
	[orno] [varchar](254) NULL,
	[itsc_kw] [varchar](254) NULL,
	[rfcp] [nvarchar](254) NULL,
	[rtra] [varchar](254) NULL,
	[rido] [nvarchar](254) NULL,
	[srvt] [varchar](254) NULL,
	[ingr] [varchar](254) NULL,
	[amti] [nvarchar](254) NULL,
	[amth_1] [nvarchar](254) NULL,
	[amth_2] [nvarchar](254) NULL,
	[amth_3] [nvarchar](254) NULL,
	[txai] [nvarchar](254) NULL,
	[txah_1] [nvarchar](254) NULL,
	[txah_2] [nvarchar](254) NULL,
	[txah_3] [nvarchar](254) NULL,
	[stxi] [nvarchar](254) NULL,
	[stxh_1] [nvarchar](254) NULL,
	[stxh_2] [nvarchar](254) NULL,
	[stxh_3] [nvarchar](254) NULL,
	[scai] [nvarchar](254) NULL,
	[scah_1] [nvarchar](254) NULL,
	[scah_2] [nvarchar](254) NULL,
	[scah_3] [nvarchar](254) NULL,
	[scdt] [datetime] NULL,
	[d1ai] [nvarchar](254) NULL,
	[d1ah_1] [nvarchar](254) NULL,
	[d1ah_2] [nvarchar](254) NULL,
	[d1ah_3] [nvarchar](254) NULL,
	[d1dt] [datetime] NULL,
	[d2ai] [nvarchar](254) NULL,
	[d2ah_1] [nvarchar](254) NULL,
	[d2ah_2] [nvarchar](254) NULL,
	[d2ah_3] [nvarchar](254) NULL,
	[d2dt] [datetime] NULL,
	[d3ai] [nvarchar](254) NULL,
	[d3ah_1] [nvarchar](254) NULL,
	[d3ah_2] [nvarchar](254) NULL,
	[d3ah_3] [nvarchar](254) NULL,
	[d3dt] [datetime] NULL,
	[rddf] [nvarchar](254) NULL,
	[rddh_1] [nvarchar](254) NULL,
	[rddh_2] [nvarchar](254) NULL,
	[rddh_3] [nvarchar](254) NULL,
	[dcai] [nvarchar](254) NULL,
	[inii] [nvarchar](254) NULL,
	[tbii] [nvarchar](254) NULL,
	[aaai] [nvarchar](254) NULL,
	[ppri] [nvarchar](254) NULL,
	[opai] [nvarchar](254) NULL,
	[insc_kw] [varchar](254) NULL,
	[ttyp] [varchar](254) NULL,
	[sern] [nvarchar](254) NULL,
	[txup_kw] [varchar](254) NULL,
	[setl_kw] [varchar](254) NULL,
	[edpr_kw] [varchar](254) NULL,
	[cinv] [varchar](254) NULL,
	[bkrn] [varchar](254) NULL,
	[bkrl] [varchar](254) NULL,
	[pkvr] [nvarchar](254) NULL,
	[sigt] [varchar](254) NULL,
	[bpos_kw] [varchar](254) NULL,
	[noil] [nvarchar](254) NULL,
	[txdt] [datetime] NULL,
	[stdb_kw] [varchar](254) NULL,
	[tide_kw] [varchar](254) NULL,
	[invl] [varchar](254) NULL,
	[xlay] [varchar](254) NULL,
	[dudt] [datetime] NULL,
	[tinv_kw] [varchar](254) NULL,
	[pitp] [varchar](254) NULL,
	[rndg_kw] [varchar](254) NULL,
	[ueis_kw] [varchar](254) NULL,
	[bank] [varchar](254) NULL,
	[tcur] [varchar](254) NULL,
	[tcty] [varchar](254) NULL,
	[tcrd_kw] [varchar](254) NULL,
	[tcdt] [datetime] NULL,
	[tcrt] [nvarchar](254) NULL,
	[tcrf] [nvarchar](254) NULL,
	[tceb_kw] [varchar](254) NULL,
	[tcta] [nvarchar](254) NULL,
	[lccr] [varchar](254) NULL,
	[qrin_kw] [varchar](254) NULL,
	[deleted] [varchar](254) NULL,
	[username] [varchar](254) NULL,
	[timestamp] [datetime] NULL,
	[sequen] [nvarchar](254) NULL
)    
        
--delete from ln_cisli305 where compnr = @compnr and orno = @orno and stbp=@stbp and sotp = @sotp and pfbp=@pfbp and pfad = @pfad;        
        
INSERT INTO #temp_usln_cisli305    
           ([compnr]    
           ,[sfcp]    
           ,[tran]    
           ,[idoc]    
           ,[scmp]    
           ,[brid]    
           ,[doct_kw]    
           ,[stat_kw]    
           ,[idat]    
           ,[rtdt]    
           ,[fdpt]    
           ,[itbp]    
           ,[pfbp]    
           ,[opbp]    
           ,[itoa]    
           ,[pfoa]    
           ,[ccur]    
           ,[cpay]    
           ,[ccrs]    
           ,[cidm]    
           ,[paym]    
           ,[txct]    
           ,[regt]    
           ,[jurl_kw]    
           ,[jurc]    
           ,[reeu]    
           ,[regc]    
           ,[rseq]    
           ,[reid]    
           ,[rexp_kw]    
           ,[bpct]    
           ,[bprt]    
           ,[bpjl_kw]    
           ,[bpjc]    
           ,[bpri]    
           ,[trde_kw]    
           ,[fyer]    
           ,[fper]    
           ,[ryer]    
           ,[rper]    
           ,[txyr]    
           ,[txpr]    
           ,[fcrt_kw]    
           ,[cinm]    
           ,[repl_kw]    
           ,[styp]    
           ,[invt_kw]    
           ,[sapr_kw]    
           ,[uapr_kw]    
           ,[comr]    
           ,[cban]    
           ,[lmbi_kw]    
           ,[fman_kw]    
           ,[abct_kw]    
           ,[sbim_kw]    
           ,[rinv_kw]    
           ,[rpan_kw]    
           ,[apdt]    
           ,[rtyp]    
           ,[rate_1]    
           ,[rate_2]    
           ,[rate_3]    
           ,[ratf_1]    
           ,[ratf_2]    
           ,[ratf_3]    
           ,[ratd]    
           ,[dim1]    
           ,[dim2]    
           ,[dim3]    
           ,[dim4]    
           ,[dim5]    
           ,[dim6]    
           ,[dim7]    
           ,[dim8]    
           ,[dim9]    
           ,[dm11]    
           ,[dm12]    
           ,[cvat]    
           ,[cofc]    
           ,[crep]    
           ,[msid]    
           ,[cbrn]    
           ,[creg]    
           ,[posa_kw]    
           ,[deln]    
           ,[ofbp]    
           ,[ofad]    
           ,[stbp]    
           ,[stoa]    
           ,[cono]    
           ,[cnln]    
           ,[cprj]    
           ,[cdoc]    
           ,[cslo]    
           ,[cslt]    
           ,[cins]    
           ,[cpuo]    
           ,[cput]    
           ,[cwho]    
           ,[cwht]    
           ,[cshp]    
           ,[cpcs]    
           ,[csvo]    
           ,[csvt]    
           ,[csvc]    
           ,[cmso]    
           ,[cmst]    
           ,[cmsc]    
           ,[cscl]    
           ,[cscc]    
           ,[csco]    
           ,[csct]    
           ,[cfro]    
           ,[creb]    
           ,[srtp_kw]    
           ,[orno]    
           ,[itsc_kw]    
           ,[rfcp]    
           ,[rtra]    
           ,[rido]    
           ,[srvt]    
           ,[ingr]    
           ,[amti]    
           ,[amth_1]    
           ,[amth_2]    
           ,[amth_3]    
           ,[txai]    
           ,[txah_1]    
           ,[txah_2]    
           ,[txah_3]    
           ,[stxi]    
           ,[stxh_1]    
           ,[stxh_2]    
           ,[stxh_3]    
           ,[scai]    
           ,[scah_1]    
           ,[scah_2]    
           ,[scah_3]    
           ,[scdt]    
           ,[d1ai]    
           ,[d1ah_1]    
           ,[d1ah_2]    
           ,[d1ah_3]    
           ,[d1dt]    
           ,[d2ai]    
           ,[d2ah_1]    
           ,[d2ah_2]    
           ,[d2ah_3]    
           ,[d2dt]    
           ,[d3ai]    
           ,[d3ah_1]    
           ,[d3ah_2]    
           ,[d3ah_3]    
           ,[d3dt]    
           ,[rddf]    
           ,[rddh_1]    
           ,[rddh_2]    
           ,[rddh_3]    
           ,[dcai]    
           ,[inii]    
           ,[tbii]    
           ,[aaai]    
           ,[ppri]    
           ,[opai]    
           ,[insc_kw]    
           ,[ttyp]    
           ,[sern]    
           ,[txup_kw]    
           ,[setl_kw]    
           ,[edpr_kw]    
           ,[cinv]    
           ,[bkrn]    
           ,[bkrl]    
           ,[pkvr]    
           ,[sigt]    
   ,[bpos_kw]    
           ,[noil]    
           ,[txdt]    
           ,[stdb_kw]    
           ,[tide_kw]    
           ,[invl]    
           ,[xlay]    
           ,[dudt]    
           ,[tinv_kw]    
           ,[pitp]    
           ,[rndg_kw]    
           ,[ueis_kw]    
           ,[bank]    
           ,[tcur]    
           ,[tcty]    
           ,[tcrd_kw]    
           ,[tcdt]    
           ,[tcrt]    
           ,[tcrf]    
           ,[tceb_kw]    
           ,[tcta]    
           ,[lccr]    
           ,[qrin_kw]    
           ,[deleted]    
           ,[username]    
           ,[timestamp]    
           ,[sequen])    
     SELECT * FROM OPENJSON (@json)    
  WITH(compnr nvarchar(10) '$.compnr',    
sfcp nvarchar(10) '$.sfcp',    
[tran] nvarchar(20) '$.tran',    
idoc nvarchar(20) '$.idoc',    
scmp nvarchar(10) '$.scmp',    
brid nvarchar(20) '$.brid',    
doct_kw nvarchar(50) '$.doct_kw',    
stat_kw nvarchar(50) '$.stat_kw',    
idat datetime '$.idat',    
rtdt datetime '$.rtdt',    
fdpt nvarchar(50) '$.fdpt',    
itbp nvarchar(20) '$.itbp',    
pfbp nvarchar(20) '$.pfbp',    
opbp nvarchar(20) '$.opbp',    
itoa nvarchar(20) '$.itoa',    
pfoa nvarchar(20) '$.pfoa',    
ccur nvarchar(20) '$.ccur',    
cpay nvarchar(20) '$.cpay',    
ccrs nvarchar(20) '$.ccrs',    
cidm nvarchar(20) '$.cidm',    
paym nvarchar(20) '$.paym',    
txct nvarchar(20) '$.txct',    
regt nvarchar(50) '$.regt',    
jurl_kw nvarchar(50) '$.jurl_kw',    
jurc nvarchar(50) '$.jurc',    
reeu nvarchar(50) '$.reeu',    
regc nvarchar(50) '$.regc',    
rseq nvarchar(10) '$.rseq',    
reid nvarchar(30) '$.reid',    
rexp_kw nvarchar(50) '$.rexp_kw',    
bpct nvarchar(30) '$.bpct',    
bprt nvarchar(30) '$.bprt',    
bpjl_kw nvarchar(50) '$.bpjl_kw',    
bpjc nvarchar(30) '$.bpjc',    
bpri nvarchar(30) '$.bpri',    
trde_kw nvarchar(50) '$.trde_kw',    
fyer nvarchar(10) '$.fyer',    
fper nvarchar(10) '$.fper',    
ryer nvarchar(10) '$.ryer',    
rper nvarchar(10) '$.rper',    
txyr nvarchar(10) '$.txyr',    
txpr nvarchar(10) '$.txpr',    
fcrt_kw nvarchar(50) '$.fcrt_kw',    
cinm nvarchar(50) '$.cinm',    
repl_kw nvarchar(50) '$.repl_kw',    
styp nvarchar(50) '$.styp',    
invt_kw nvarchar(50) '$.invt_kw',    
sapr_kw nvarchar(50) '$.sapr_kw',    
uapr_kw nvarchar(50) '$.uapr_kw',    
comr nvarchar(50) '$.comr.it_IT',    
cban nvarchar(20) '$.cban',    
lmbi_kw nvarchar(50) '$.lmbi_kw',    
fman_kw nvarchar(50) '$.fman_kw',    
abct_kw nvarchar(50) '$.abct_kw',    
sbim_kw nvarchar(50) '$.sbim_kw',    
rinv_kw nvarchar(50) '$.rinv_kw',    
rpan_kw nvarchar(50) '$.rpan_kw',    
apdt datetime '$.apdt',    
rtyp nvarchar(20) '$.rtyp',    
rate_1 nvarchar(10) '$.rate_1',    
rate_2 nvarchar(15) '$.rate_2',    
rate_3 nvarchar(15) '$.rate_3',    
ratf_1 nvarchar(15) '$.ratf_1',    
ratf_2 nvarchar(15) '$.ratf_2',    
ratf_3 nvarchar(15) '$.ratf_3',    
ratd datetime '$.ratd',    
dim1 nvarchar(20) '$.dim1',    
dim2 nvarchar(20) '$.dim2',    
dim3 nvarchar(20) '$.dim3',    
dim4 nvarchar(20) '$.dim4',    
dim5 nvarchar(20) '$.dim5',    
dim6 nvarchar(20) '$.dim6',    
dim7 nvarchar(20) '$.dim7',    
dim8 nvarchar(20) '$.dim8',    
dim9 nvarchar(20) '$.dim9',    
dm11 nvarchar(20) '$.dm11',    
dm12 nvarchar(20) '$.dm12',    
cvat nvarchar(20) '$.cvat',    
cofc nvarchar(20) '$.cofc',    
crep nvarchar(20) '$.crep',    
msid nvarchar(20) '$.msid',    
cbrn nvarchar(20) '$.cbrn',    
creg nvarchar(20) '$.creg',    
posa_kw nvarchar(50) '$.posa_kw',    
deln nvarchar(20) '$.deln',    
ofbp nvarchar(20) '$.ofbp',    
ofad nvarchar(20) '$.ofad',    
stbp nvarchar(20) '$.stbp',    
stoa nvarchar(20) '$.stoa',    
cono nvarchar(20) '$.cono',    
cnln nvarchar(20) '$.cnln',    
cprj nvarchar(20) '$.cprj',    
cdoc nvarchar(20) '$.cdoc.it_IT',    
cslo nvarchar(20) '$.cslo',    
cslt nvarchar(20) '$.cslt',    
cins nvarchar(20) '$.cins',    
cpuo nvarchar(20) '$.cpuo',    
cput nvarchar(20) '$.cput',    
cwho nvarchar(20) '$.cwho',    
cwht nvarchar(20) '$.cwht',    
cshp nvarchar(20) '$.cshp',    
cpcs nvarchar(20) '$.cpcs',    
csvo nvarchar(20) '$.csvo',    
csvt nvarchar(20) '$.csvt',    
csvc nvarchar(20) '$.csvc',    
cmso nvarchar(20) '$.cmso',    
cmst nvarchar(20) '$.cmst',    
cmsc nvarchar(20) '$.cmsc',    
cscl nvarchar(20) '$.cscl',    
cscc nvarchar(20) '$.cscc',    
csco nvarchar(20) '$.csco',    
csct nvarchar(20) '$.csct',    
cfro nvarchar(20) '$.cfro',    
creb nvarchar(20) '$.creb',    
srtp_kw nvarchar(50) '$.srtp_kw',    
orno nvarchar(20) '$.orno',    
itsc_kw nvarchar(50) '$.itsc_kw',    
rfcp nvarchar(15) '$.rfcp',    
rtra nvarchar(50) '$.rtra',    
rido nvarchar(15) '$.rido',    
srvt nvarchar(50) '$.srvt',    
ingr nvarchar(50) '$.ingr',    
amti nvarchar(20) '$.amti',    
amth_1 nvarchar(20) '$.amth_1',    
amth_2 nvarchar(20) '$.amth_2',    
amth_3 nvarchar(20) '$.amth_3',    
txai nvarchar(20) '$.txai',    
txah_1 nvarchar(20) '$.txah_1',    
txah_2 nvarchar(20) '$.txah_2',    
txah_3 nvarchar(20) '$.txah_3',    
stxi nvarchar(20) '$.stxi',    
stxh_1 nvarchar(20) '$.stxh_1',    
stxh_2 nvarchar(20) '$.stxh_2',    
stxh_3 nvarchar(20) '$.stxh_3',    
scai nvarchar(20) '$.scai',    
scah_1 nvarchar(20) '$.scah_1',    
scah_2 nvarchar(20) '$.scah_2',    
scah_3 nvarchar(20) '$.scah_3',    
scdt datetime '$.scdt',    
d1ai nvarchar(20) '$.d1ai',    
d1ah_1 nvarchar(20) '$.d1ah_1',    
d1ah_2 nvarchar(20) '$.d1ah_2',    
d1ah_3 nvarchar(20) '$.d1ah_3',    
d1dt datetime '$.d1dt',    
d2ai nvarchar(20) '$.d2ai',    
d2ah_1 nvarchar(20) '$.d2ah_1',    
d2ah_2 nvarchar(20) '$.d2ah_2',    
d2ah_3 nvarchar(20) '$.d2ah_3',    
d2dt datetime '$.d2dt',    
d3ai nvarchar(20) '$.d3ai',    
d3ah_1 nvarchar(20) '$.d3ah_1',    
d3ah_2 nvarchar(20) '$.d3ah_2',    
d3ah_3 nvarchar(20) '$.d3ah_3',    
d3dt datetime '$.d3dt',    
rddf nvarchar(20) '$.rddf',    
rddh_1 nvarchar(20) '$.rddh_1',    
rddh_2 nvarchar(20) '$.rddh_2',    
rddh_3 nvarchar(20) '$.rddh_3',    
dcai nvarchar(15) '$.dcai',    
inii nvarchar(15) '$.inii',    
tbii nvarchar(15) '$.tbii',    
aaai nvarchar(15) '$.aaai',    
ppri nvarchar(15) '$.ppri',    
opai nvarchar(15) '$.opai',    
insc_kw nvarchar(50) '$.insc_kw',    
ttyp nvarchar(30) '$.ttyp',    
sern nvarchar(15) '$.sern',    
txup_kw nvarchar(50) '$.txup_kw',    
setl_kw nvarchar(50) '$.setl_kw',    
edpr_kw nvarchar(50) '$.edpr_kw',    
cinv nvarchar(30) '$.cinv.it_IT',    
bkrn nvarchar(30) '$.bkrn',    
bkrl nvarchar(30) '$.bkrl',    
pkvr nvarchar(10) '$.pkvr',    
sigt nvarchar(20) '$.sigt',    
bpos_kw nvarchar(50) '$.bpos_kw',    
noil nvarchar(10) '$.noil',    
txdt datetime '$.txdt',    
stdb_kw nvarchar(50) '$.stdb_kw',    
tide_kw nvarchar(50) '$.tide_kw',    
invl nvarchar(30) '$.invl',    
xlay nvarchar(30) '$.xlay',    
dudt datetime '$.dudt',    
tinv_kw nvarchar(50) '$.tinv_kw',    
pitp nvarchar(30) '$.pitp',    
rndg_kw nvarchar(50) '$.rndg_kw',    
ueis_kw nvarchar(50) '$.ueis_kw',    
bank nvarchar(30) '$.bank',    
tcur nvarchar(30) '$.tcur',    
tcty nvarchar(30) '$.tcty',    
tcrd_kw nvarchar(50) '$.tcrd_kw',    
tcdt datetime '$.tcdt',    
tcrt nvarchar(10) '$.tcrt',    
tcrf nvarchar(10) '$.tcrf',    
tceb_kw nvarchar(50) '$.tceb_kw',    
tcta nvarchar(10) '$.tcta',    
lccr nvarchar(20) '$.lccr.it_IT',    
qrin_kw nvarchar(50) '$.qrin_kw',    
deleted nvarchar(20) '$.deleted',    
username nvarchar(30) '$.username',    
timestamp datetime '$.timestamp',    
sequen nvarchar(10) '$.sequencenumber')    
                            
    
    
    DELETE usln_cisli305 FROM usln_cisli305 INNER JOIN #temp_usln_cisli305 ON usln_cisli305.compnr = #temp_usln_cisli305.compnr and    
  usln_cisli305.[tran] = #temp_usln_cisli305.[tran] and usln_cisli305.sfcp = #temp_usln_cisli305.sfcp and usln_cisli305.idoc = #temp_usln_cisli305.idoc;    
    
    
 INSERT INTO usln_cisli305 SELECT * FROM #temp_usln_cisli305;    
    
    
 update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dlid;    

 drop table #temp_usln_cisli305;
        
end

GO

