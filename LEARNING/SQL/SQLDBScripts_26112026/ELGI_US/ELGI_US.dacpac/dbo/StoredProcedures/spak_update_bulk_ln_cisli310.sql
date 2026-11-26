CREATE PROC [dbo].[spak_update_bulk_ln_cisli310] @dlid [nvarchar](50),@json [nvarchar](max) AS      
begin      
  
CREATE TABLE #temp_usln_cisli310(
	[compn] [nvarchar](254) NULL,
	[sfcp] [nvarchar](254) NULL,
	[tran] [varchar](254) NULL,
	[idoc] [nvarchar](254) NULL,
	[line] [nvarchar](254) NULL,
	[srtp_kw] [varchar](254) NULL,
	[orno] [varchar](254) NULL,
	[pono] [nvarchar](254) NULL,
	[oref] [varchar](254) NULL,
	[bseq] [nvarchar](254) NULL,
	[koor_kw] [varchar](254) NULL,
	[invt_kw] [varchar](254) NULL,
	[sotp] [varchar](254) NULL,
	[itsc_kw] [varchar](254) NULL,
	[bpcl] [varchar](254) NULL,
	[exmt_kw] [varchar](254) NULL,
	[cvat] [varchar](254) NULL,
	[tlsq] [nvarchar](254) NULL,
	[ceno] [varchar](254) NULL,
	[rcod] [varchar](254) NULL,
	[bpct] [varchar](254) NULL,
	[abct_kw] [varchar](254) NULL,
	[cofc] [varchar](254) NULL,
	[sfdp] [varchar](254) NULL,
	[grid] [varchar](254) NULL,
	[crep] [varchar](254) NULL,
	[msid] [varchar](254) NULL,
	[cbrn] [varchar](254) NULL,
	[creg] [varchar](254) NULL,
	[deln] [varchar](254) NULL,
	[ofbp] [varchar](254) NULL,
	[ofad] [varchar](254) NULL,
	[stbp] [varchar](254) NULL,
	[stoa] [varchar](254) NULL,
	[cprj] [varchar](254) NULL,
	[chtp_kw] [varchar](254) NULL,
	[amti] [nvarchar](254) NULL,
	[amth_1] [nvarchar](254) NULL,
	[amth_2] [nvarchar](254) NULL,
	[amth_3] [nvarchar](254) NULL,
	[tbai] [nvarchar](254) NULL,
	[tbah_1] [nvarchar](254) NULL,
	[tbah_2] [nvarchar](254) NULL,
	[tbah_3] [nvarchar](254) NULL,
	[rtbi] [nvarchar](254) NULL,
	[txai] [nvarchar](254) NULL,
	[txah_1] [nvarchar](254) NULL,
	[txah_2] [nvarchar](254) NULL,
	[txah_3] [nvarchar](254) NULL,
	[stxi] [nvarchar](254) NULL,
	[stxh_1] [nvarchar](254) NULL,
	[stxh_2] [nvarchar](254) NULL,
	[stxh_3] [nvarchar](254) NULL,
	[rtxi] [nvarchar](254) NULL,
	[rtxh_1] [nvarchar](254) NULL,
	[rtxh_2] [nvarchar](254) NULL,
	[rtxh_3] [nvarchar](254) NULL,
	[slai] [nvarchar](254) NULL,
	[slah_1] [nvarchar](254) NULL,
	[slah_2] [nvarchar](254) NULL,
	[slah_3] [nvarchar](254) NULL,
	[scai] [nvarchar](254) NULL,
	[scah_1] [nvarchar](254) NULL,
	[scah_2] [nvarchar](254) NULL,
	[scah_3] [nvarchar](254) NULL,
	[scdt] [datetime] NULL,
	[ldai] [nvarchar](254) NULL,
	[ldah_1] [nvarchar](254) NULL,
	[ldah_2] [nvarchar](254) NULL,
	[ldah_3] [nvarchar](254) NULL,
	[odai] [nvarchar](254) NULL,
	[odah_1] [nvarchar](254) NULL,
	[odah_2] [nvarchar](254) NULL,
	[odah_3] [nvarchar](254) NULL,
	[cvai] [nvarchar](254) NULL,
	[cvah_1] [nvarchar](254) NULL,
	[cvah_2] [nvarchar](254) NULL,
	[cvah_3] [nvarchar](254) NULL,
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
	[hbai] [nvarchar](254) NULL,
	[pric] [nvarchar](254) NULL,
	[dqua] [nvarchar](254) NULL,
	[cuqs] [varchar](254) NULL,
	[cuns] [varchar](254) NULL,
	[cups] [varchar](254) NULL,
	[refa] [varchar](254) NULL,
	[refb] [varchar](254) NULL,
	[hdsc] [varchar](254) NULL,
	[ldsc] [varchar](254) NULL,
	[cdec] [varchar](254) NULL,
	[ptpa] [varchar](254) NULL,
	[shpm] [varchar](254) NULL,
	[shln] [nvarchar](254) NULL,
	[dlvr] [nvarchar](254) NULL,
	[schd] [nvarchar](254) NULL,
	[nins] [nvarchar](254) NULL,
	[hbnr] [nvarchar](254) NULL,
	[pjln] [nvarchar](254) NULL,
	[prel_kw] [varchar](254) NULL,
	[tprj] [varchar](254) NULL,
	[item] [varchar](254) NULL,
	[bemp] [varchar](254) NULL,
	[task] [varchar](254) NULL,
	[leac] [varchar](254) NULL,
	[cstp] [varchar](254) NULL,
	[ptrr] [nvarchar](254) NULL,
	[ptrr_kw] [varchar](254) NULL,
	[sfad] [varchar](254) NULL,
	[stad] [varchar](254) NULL,
	[oaad] [varchar](254) NULL,
	[ooad] [varchar](254) NULL,
	[odat] [datetime] NULL,
	[ddat] [datetime] NULL,
	[pgdt] [datetime] NULL,
	[rate_1] [nvarchar](254) NULL,
	[rate_2] [nvarchar](254) NULL,
	[rate_3] [nvarchar](254) NULL,
	[ratf_1] [nvarchar](254) NULL,
	[ratf_2] [nvarchar](254) NULL,
	[ratf_3] [nvarchar](254) NULL,
	[ratd] [datetime] NULL,
	[rtyp] [varchar](254) NULL,
	[bona] [varchar](254) NULL,
	[boid] [varchar](254) NULL,
	[rrin_kw] [varchar](254) NULL,
	[oqua] [nvarchar](254) NULL,
	[reas] [varchar](254) NULL,
	[tcba] [nvarchar](254) NULL,
	[tcta] [nvarchar](254) NULL,
	[tcsa] [nvarchar](254) NULL,
	[tcbr] [nvarchar](254) NULL,
	[tctr] [nvarchar](254) NULL,
	[amtc] [nvarchar](254) NULL,
	[pcmp_kw] [varchar](254) NULL,
	[clsb_kw] [varchar](254) NULL,
	[cdf_ccig] [varchar](254) NULL,
	[cdf_ccup] [varchar](254) NULL,
	[delet] [varchar](254) NULL,
	[usern] [varchar](254) NULL,
	[times] [datetime] NULL,
	[seque] [nvarchar](254) NULL
)  
      
--delete from ln_cisli305 where compnr = @compnr and orno = @orno and stbp=@stbp and sotp = @sotp and pfbp=@pfbp and pfad = @pfad;      
      
INSERT INTO #temp_usln_cisli310  
           ([compn]  
           ,[sfcp]  
           ,[tran]  
           ,[idoc]  
           ,[line]  
           ,[srtp_kw]  
           ,[orno]  
           ,[pono]  
           ,[oref]  
           ,[bseq]  
           ,[koor_kw]  
           ,[invt_kw]  
           ,[sotp]  
           ,[itsc_kw]  
           ,[bpcl]  
           ,[exmt_kw]  
           ,[cvat]  
           ,[tlsq]  
           ,[ceno]  
           ,[rcod]  
           ,[bpct]  
           ,[abct_kw]  
           ,[cofc]  
           ,[sfdp]  
           ,[grid]  
           ,[crep]  
           ,[msid]  
           ,[cbrn]  
           ,[creg]  
           ,[deln]  
           ,[ofbp]  
           ,[ofad]  
           ,[stbp]  
           ,[stoa]  
           ,[cprj]  
           ,[chtp_kw]  
           ,[amti]  
           ,[amth_1]  
           ,[amth_2]  
           ,[amth_3]  
           ,[tbai]  
           ,[tbah_1]  
           ,[tbah_2]  
           ,[tbah_3]  
           ,[rtbi]  
           ,[txai]  
           ,[txah_1]  
           ,[txah_2]  
           ,[txah_3]  
           ,[stxi]  
           ,[stxh_1]  
           ,[stxh_2]  
           ,[stxh_3]  
           ,[rtxi]  
           ,[rtxh_1]  
           ,[rtxh_2]  
           ,[rtxh_3]  
           ,[slai]  
           ,[slah_1]  
           ,[slah_2]  
           ,[slah_3]  
           ,[scai]  
           ,[scah_1]  
           ,[scah_2]  
           ,[scah_3]  
           ,[scdt]  
           ,[ldai]  
           ,[ldah_1]  
           ,[ldah_2]  
           ,[ldah_3]  
           ,[odai]  
           ,[odah_1]  
           ,[odah_2]  
           ,[odah_3]  
           ,[cvai]  
           ,[cvah_1]  
           ,[cvah_2]  
           ,[cvah_3]  
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
           ,[hbai]  
           ,[pric]  
           ,[dqua]  
           ,[cuqs]  
           ,[cuns]  
           ,[cups]  
           ,[refa]  
           ,[refb]  
           ,[hdsc]  
           ,[ldsc]  
           ,[cdec]  
           ,[ptpa]  
           ,[shpm]  
           ,[shln]  
           ,[dlvr]  
           ,[schd]  
           ,[nins]  
           ,[hbnr]  
           ,[pjln]  
           ,[prel_kw]  
           ,[tprj]  
           ,[item]  
           ,[bemp]  
           ,[task]  
           ,[leac]  
           ,[cstp]  
           ,[ptrr]  
           ,[ptrr_kw]  
           ,[sfad]  
           ,[stad]  
           ,[oaad]  
           ,[ooad]  
           ,[odat]  
           ,[ddat]  
           ,[pgdt]  
           ,[rate_1]  
           ,[rate_2]  
           ,[rate_3]  
           ,[ratf_1]  
           ,[ratf_2]  
           ,[ratf_3]  
           ,[ratd]  
           ,[rtyp]  
           ,[bona]  
           ,[boid]  
           ,[rrin_kw]  
           ,[oqua]  
           ,[reas]  
           ,[tcba]  
           ,[tcta]  
           ,[tcsa]  
           ,[tcbr]  
           ,[tctr]  
           ,[amtc]  
           ,[pcmp_kw]  
           ,[clsb_kw]  
           ,[cdf_ccig]  
           ,[cdf_ccup]  
           ,[delet]  
           ,[usern]  
           ,[times]  
           ,[seque])  
     SELECT * FROM OPENJSON (@json)  
  WITH(compn nvarchar(10) '$.compnr',  
sfcp nvarchar(10) '$.sfcp',  
[tran] varchar(10) '$.tran',  
idoc nvarchar(10) '$.idoc',  
line nvarchar(10) '$.line',  
srtp_kw varchar(50) '$.srtp_kw',  
orno varchar(50) '$.orno',  
pono nvarchar(10) '$.pono',  
oref varchar(50) '$.oref',  
bseq nvarchar(10) '$.bseq',  
koor_kw varchar(50) '$.koor_kw',  
invt_kw varchar(50) '$.invt_kw',  
sotp varchar(20) '$.sotp',  
itsc_kw varchar(50) '$.itsc_kw',  
bpcl varchar(50) '$.bpcl',  
exmt_kw varchar(50) '$.exmt_kw',  
cvat varchar(20) '$.cvat',  
tlsq nvarchar(10) '$.tlsq',  
ceno varchar(20) '$.ceno',  
rcod varchar(20) '$.rcod',  
bpct varchar(20) '$.bpct',  
abct_kw varchar(50) '$.abct_kw',  
cofc varchar(20) '$.cofc',  
sfdp varchar(20) '$.sfdp',  
grid varchar(20) '$.grid',  
crep varchar(20) '$.crep',  
msid varchar(20) '$.msid',  
cbrn varchar(20) '$.cbrn',  
creg varchar(20) '$.creg',  
deln varchar(20) '$.deln',  
ofbp varchar(20) '$.ofbp',  
ofad varchar(20) '$.ofad',  
stbp varchar(20) '$.stbp',  
stoa varchar(20) '$.stoa',  
cprj varchar(20) '$.cprj',  
chtp_kw varchar(50) '$.chtp_kw',  
amti nvarchar(20) '$.amti',  
amth_1 nvarchar(20) '$.amth_1',  
amth_2 nvarchar(20) '$.amth_2',  
amth_3 nvarchar(20) '$.amth_3',  
tbai nvarchar(20) '$.tbai',  
tbah_1 nvarchar(20) '$.tbah_1',  
tbah_2 nvarchar(20) '$.tbah_2',  
tbah_3 nvarchar(20) '$.tbah_3',  
rtbi nvarchar(20) '$.rtbi',  
txai nvarchar(20) '$.txai',  
txah_1 nvarchar(20) '$.txah_1',  
txah_2 nvarchar(20) '$.txah_2',  
txah_3 nvarchar(20) '$.txah_3',  
stxi nvarchar(20) '$.stxi',  
stxh_1 nvarchar(20) '$.stxh_1',  
stxh_2 nvarchar(20) '$.stxh_2',  
stxh_3 nvarchar(20) '$.stxh_3',  
rtxi nvarchar(20) '$.rtxi',  
rtxh_1 nvarchar(20) '$.rtxh_1',  
rtxh_2 nvarchar(20) '$.rtxh_2',  
rtxh_3 nvarchar(20) '$.rtxh_3',  
slai nvarchar(20) '$.slai',  
slah_1 nvarchar(20) '$.slah_1',  
slah_2 nvarchar(20) '$.slah_2',  
slah_3 nvarchar(20) '$.slah_3',  
scai nvarchar(20) '$.scai',  
scah_1 nvarchar(20) '$.scah_1',  
scah_2 nvarchar(20) '$.scah_2',  
scah_3 nvarchar(20) '$.scah_3',  
scdt datetime '$.scdt',  
ldai nvarchar(20) '$.ldai',  
ldah_1 nvarchar(20) '$.ldah_1',  
ldah_2 nvarchar(20) '$.ldah_2',  
ldah_3 nvarchar(20) '$.ldah_3',  
odai nvarchar(20) '$.odai',  
odah_1 nvarchar(20) '$.odah_1',  
odah_2 nvarchar(20) '$.odah_2',  
odah_3 nvarchar(20) '$.odah_3',  
cvai nvarchar(20) '$.cvai',  
cvah_1 nvarchar(20) '$.cvah_1',  
cvah_2 nvarchar(20) '$.cvah_2',  
cvah_3 nvarchar(20) '$.cvah_3',  
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
hbai nvarchar(20) '$.hbai',  
pric nvarchar(20) '$.pric',  
dqua nvarchar(20) '$.dqua',  
cuqs varchar(20) '$.cuqs',  
cuns varchar(20) '$.cuns',  
cups varchar(20) '$.cups',  
refa varchar(50) '$.refa.it_IT',  
refb varchar(50) '$.refb.it_IT',  
hdsc varchar(50) '$.hdsc.it_IT',  
ldsc varchar(50) '$.ldsc.it_IT',  
cdec varchar(20) '$.cdec',  
ptpa varchar(20) '$.ptpa',  
shpm varchar(20) '$.shpm',  
shln nvarchar(10) '$.shln',  
dlvr nvarchar(10) '$.dlvr',  
schd nvarchar(10) '$.schd',  
nins nvarchar(10) '$.nins',  
hbnr nvarchar(10) '$.hbnr',  
pjln nvarchar(10) '$.pjln',  
prel_kw varchar(50) '$.prel_kw',  
tprj varchar(50) '$.tprj',  
item varchar(50) '$.item',  
bemp varchar(20) '$.bemp',  
task varchar(20) '$.task',  
leac varchar(20) '$.leac',  
cstp varchar(20) '$.cstp',  
ptrr nvarchar(10) '$.ptrr',  
ptrr_kw varchar(50) '$.ptrr_kw',  
sfad varchar(50) '$.sfad',  
stad varchar(50) '$.stad',  
oaad varchar(50) '$.oaad',  
ooad varchar(20) '$.ooad',  
odat datetime '$.odat',  
ddat datetime '$.ddat',  
pgdt datetime '$.pgdt',  
rate_1 nvarchar(20) '$.rate_1',  
rate_2 nvarchar(20) '$.rate_2',  
rate_3 nvarchar(20) '$.rate_3',  
ratf_1 nvarchar(20) '$.ratf_1',  
ratf_2 nvarchar(10) '$.ratf_2',  
ratf_3 nvarchar(10) '$.ratf_3',  
ratd datetime '$.ratd',  
rtyp varchar(20) '$.rtyp',  
bona varchar(20) '$.bona',  
boid varchar(20) '$.boid',  
rrin_kw varchar(50) '$.rrin_kw',  
oqua nvarchar(20) '$.oqua',  
reas varchar(50) '$.reas',  
tcba nvarchar(20) '$.tcba',  
tcta nvarchar(20) '$.tcta',  
tcsa nvarchar(20) '$.tcsa',  
tcbr nvarchar(20) '$.tcbr',  
tctr nvarchar(20) '$.tctr',  
amtc nvarchar(20) '$.amtc',  
pcmp_kw varchar(50) '$.pcmp_kw',  
clsb_kw varchar(50) '$.clsb_kw',  
cdf_ccig varchar(50) '$.cdf_ccig',  
cdf_ccup varchar(50) '$.cdf_ccup',  
delet varchar(20) '$.deleted',  
usern varchar(50) '$.username',  
times datetime '$.timestamp',  
seque nvarchar(10) '$.sequencenumber')  
                          
  
  
    DELETE usln_cisli310 FROM usln_cisli310 INNER JOIN #temp_usln_cisli310 ON usln_cisli310.compn = #temp_usln_cisli310.compn and  
  usln_cisli310.[tran] = #temp_usln_cisli310.[tran] and usln_cisli310.sfcp = #temp_usln_cisli310.sfcp   
  and usln_cisli310.idoc = #temp_usln_cisli310.idoc and usln_cisli310.line = #temp_usln_cisli310.line;  
  
  
 INSERT INTO usln_cisli310 SELECT * FROM #temp_usln_cisli310;  
  
  
 update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dlid;  


 drop table #temp_usln_cisli310;
      
end

GO

