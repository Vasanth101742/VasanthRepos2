CREATE PROC [dbo].[sp_update_Bulk_Ln_tccom100] @dl_id [nvarchar](50),@json [nvarchar](MAX) AS  
begin  
  


CREATE TABLE #templn_tccom100(
	[compnr] [numeric](20, 0) NULL,
	[bpid] [varchar](254) NULL,
	[ctit] [varchar](254) NULL,
	[Nama] [varchar](254) NULL,
	[Seak] [varchar](254) NULL,
	[prbp] [varchar](254) NULL,
	[prst] [numeric](10, 0) NULL,
	[prst_kw] [varchar](254) NULL,
	[stdt] [nvarchar](254) NULL,
	[endt] [nvarchar](254) NULL,
	[clan] [varchar](10) NULL,
	[ccur] [varchar](10) NULL,
	[sndr] [numeric](10, 0) NULL,
	[sndr_kw] [varchar](254) NULL,
	[edyn] [numeric](10, 0) NULL,
	[edyn_kw] [varchar](254) NULL,
	[fovn] [varchar](254) NULL,
	[lvdt] [nvarchar](254) NULL,
	[inrl] [numeric](10, 0) NULL,
	[inrl_kw] [varchar](254) NULL,
	[iscn] [numeric](10, 0) NULL,
	[Lgid] [varchar](254) NULL,
	[Cmid] [varchar](254) NULL,
	[bptx] [varchar](254) NULL,
	[cadr] [varchar](254) NULL,
	[telp] [varchar](254) NULL,
	[tlcy] [varchar](254) NULL,
	[tlci] [varchar](254) NULL,
	[tlln] [varchar](254) NULL,
	[tlex] [varchar](254) NULL,
	[tefx] [varchar](254) NULL,
	[tfcy] [varchar](254) NULL,
	[tfci] [varchar](254) NULL,
	[tfln] [varchar](254) NULL,
	[tfex] [varchar](254) NULL,
	[ccnt] [varchar](254) NULL,
	[cint] [numeric](10, 0) NULL,
	[cint_kw] [varchar](254) NULL,
	[foid] [numeric](10, 0) NULL,
	[crid] [numeric](10, 0) NULL,
	[icst] [numeric](10, 0) NULL,
	[icst_kw] [varchar](254) NULL,
	[icod] [numeric](10, 0) NULL,
	[icod_kw] [varchar](254) NULL,
	[fact] [numeric](10, 0) NULL,
	[fact_kw] [varchar](254) NULL,
	[ecmp] [numeric](10, 0) NULL,
	[coff] [numeric](10, 0) NULL,
	[coff_kw] [varchar](254) NULL,
	[crdt] [nvarchar](254) NULL,
	[lmdt] [nvarchar](254) NULL,
	[lmus] [varchar](254) NULL,
	[bprl] [numeric](10, 0) NULL,
	[bprl_kw] [varchar](254) NULL,
	[btbv] [numeric](10, 0) NULL,
	[btbv_kw] [varchar](254) NULL,
	[usid] [varchar](254) NULL,
	[clcd] [numeric](10, 0) NULL,
	[clcd_kw] [varchar](254) NULL,
	[cbcl] [varchar](254) NULL,
	[Beid] [varchar](254) NULL,
	[Inet] [varchar](254) NULL,
	[imag] [varchar](254) NULL,
	[smt1] [numeric](10, 0) NULL,
	[smt1_kw] [varchar](254) NULL,
	[Sml1] [varchar](254) NULL,
	[smt2] [numeric](10, 0) NULL,
	[smt2_kw] [varchar](254) NULL,
	[Sml2] [varchar](254) NULL,
	[smt3] [numeric](10, 0) NULL,
	[smt3_kw] [varchar](254) NULL,
	[sml3] [varchar](254) NULL,
	[smt4] [numeric](10, 0) NULL,
	[smt4_kw] [varchar](254) NULL,
	[sml4] [varchar](254) NULL,
	[smt5] [numeric](10, 0) NULL,
	[smt5_kw] [varchar](254) NULL,
	[sml5] [varchar](254) NULL,
	[txta] [numeric](10, 0) NULL,
	[ctit_ref_compnr] [numeric](10, 0) NULL,
	[prbp_ref_compnr] [numeric](10, 0) NULL,
	[clan_ref_compnr] [numeric](10, 0) NULL,
	[ccur_ref_compnr] [numeric](10, 0) NULL,
	[bptx_ref_compnr] [numeric](10, 0) NULL,
	[cadr_ref_compnr] [numeric](10, 0) NULL,
	[ccnt_ref_compnr] [numeric](10, 0) NULL,
	[cbcl_ref_compnr] [numeric](10, 0) NULL,
	[txta_ref_compnr] [numeric](10, 0) NULL,
	[deleted] [varchar](254) NULL,
	[username] [varchar](254) NULL,
	[timestamp1] [nvarchar](254) NULL,
	[sequencenumber] [numeric](10, 0) NULL
) 
  
INSERT INTO #templn_tccom100 ([compnr],[bpid],[ctit],[Nama],[Seak],[prbp],[prst],[prst_kw],[stdt],[endt],[clan],[ccur],[sndr]  
      ,[sndr_kw],[edyn],[edyn_kw],[fovn],[lvdt],[inrl],[inrl_kw],[iscn],[Lgid],[Cmid],[bptx],[cadr],[telp],[tlcy],[tlci]  
      ,[tlln],[tlex],[tefx],[tfcy],[tfci],[tfln],[tfex],[ccnt],[cint],[cint_kw],[foid],[crid],[icst],[icst_kw],[icod]  
      ,[icod_kw],[fact],[fact_kw],[ecmp],[coff],[coff_kw],[crdt],[lmdt],[lmus],[bprl],[bprl_kw],[btbv],[btbv_kw],[usid]  
      ,[clcd],[clcd_kw],[cbcl],[Beid],[Inet],[imag],[smt1],[smt1_kw],[Sml1],[smt2],[smt2_kw],[Sml2],[smt3],[smt3_kw],[sml3]  
      ,[smt4],[smt4_kw],[sml4],[smt5],[smt5_kw],[sml5],[txta],[ctit_ref_compnr],[prbp_ref_compnr],[clan_ref_compnr],[ccur_ref_compnr]  
      ,[bptx_ref_compnr],[cadr_ref_compnr],[ccnt_ref_compnr],[cbcl_ref_compnr],[txta_ref_compnr],[deleted],[username],[timestamp1]  
      ,[sequencenumber]) SELECT * FROM OPENJSON (@json)  
WITH(  
    compnr nvarchar(50) '$.compnr',bpid nvarchar(50) '$.bpid',ctit nvarchar(50) '$.ctit',Nama nvarchar(100) '$.nama.it_IT',  
    Seak nvarchar(max) '$.seak.it_IT',prbp nvarchar(50) '$.prbp',prst nvarchar(50) '$.prst',prst_kw nvarchar(50) '$.prst_kw',  
 stdt nvarchar(50) '$.stdt',endt nvarchar(50) '$.endt',clan nvarchar(50) '$.clan',ccur nvarchar(50) '$.ccur',  
 sndr nvarchar(50) '$.sndr',sndr_kw nvarchar(50) '$.sndr_kw',edyn nvarchar(50) '$.edyn',edyn_kw nvarchar(50) '$.edyn_kw',  
 fovn nvarchar(50) '$.fovn',lvdt nvarchar(50) '$.lvdt',inrl nvarchar(50) '$.inrl',inrl_kw nvarchar(50) '$.inrl_kw',  
 iscn nvarchar(50) '$.iscn',Lgid nvarchar(50) '$.lgid.it_IT',Cmid nvarchar(50) '$.cmid.it_IT',bptx nvarchar(50) '$.bptx',  
 cadr nvarchar(50) '$.cadr',telp nvarchar(50) '$.telp',tlcy nvarchar(50) '$.tlcy',tlci nvarchar(50) '$.tlci',  
 tlln nvarchar(50) '$.tlln',tlex nvarchar(50) '$.tlex',tefx nvarchar(50) '$.tefx',tfcy nvarchar(50) '$.tfcy',  
 tfci nvarchar(50) '$.tfci',tfln nvarchar(50) '$.tfln',tfex nvarchar(50) '$.tfex',ccnt nvarchar(50) '$.ccnt',  
 cint nvarchar(50) '$.cint',cint_kw nvarchar(50) '$.cint_kw',foid nvarchar(50) '$.foid',crid nvarchar(50) '$.crid',  
 icst nvarchar(50) '$.icst',icst_kw nvarchar(50) '$.icst_kw',icod nvarchar(50) '$.icod',icod_kw nvarchar(50) '$.icod_kw',fact nvarchar(50) '$.fact',  
 fact_kw nvarchar(50) '$.fact_kw',ecmp nvarchar(50) '$.ecmp',coff nvarchar(50) '$.coff',coff_kw nvarchar(50) '$.coff_kw',  
 crdt nvarchar(50) '$.crdt',lmdt nvarchar(50) '$.lmdt',lmus nvarchar(50) '$.lmus',bprl nvarchar(50) '$.bprl',  
 bprl_kw nvarchar(50) '$.bprl_kw',btbv nvarchar(50) '$.btbv',btbv_kw nvarchar(50) '$.btbv_kw',usid nvarchar(50) '$.usid',  
 clcd nvarchar(50) '$.clcd',clcd_kw nvarchar(50) '$.clcd_kw',cbcl nvarchar(50) '$.cbcl',Beid nvarchar(50) '$.beid.it_IT',  
 inet nvarchar(50) '$.inet.it_IT',imag nvarchar(50) '$.imag',smt1 nvarchar(50) '$.smt1',smt1_kw nvarchar(50) '$.smt1_kw',  
 Sml1 nvarchar(50) '$.sml1.it_IT',smt2 nvarchar(50) '$.smt2',smt2_kw nvarchar(50) '$.smt2_kw',Sml2 nvarchar(50) '$.sml2.it_IT',  
 smt3 nvarchar(50) '$.smt3',smt3_kw nvarchar(50) '$.smt3_kw',sml3 nvarchar(50) '$.sml3.it_IT',smt4 nvarchar(50) '$.smt4',  
 smt4_kw nvarchar(50) '$.smt4_kw',sml4 nvarchar(50) '$.sml4.it_IT',smt5 nvarchar(50) '$.smt5',smt5_kw nvarchar(50) '$.smt5_kw',  
 sml5 nvarchar(50) '$.sml5.it_IT',txta nvarchar(50) '$.txta',ctit_ref_compnr nvarchar(50) '$.ctit_ref_compnr',  
 prbp_ref_compnr nvarchar(50) '$.prbp_ref_compnr',clan_ref_compnr nvarchar(50) '$.clan_ref_compnr',  
 ccur_ref_compnr nvarchar(50) '$.ccur_ref_compnr',bptx_ref_compnr nvarchar(50) '$.bptx_ref_compnr',  
 cadr_ref_compnr nvarchar(50) '$.cadr_ref_compnr',ccnt_ref_compnr nvarchar(50) '$.ccnt_ref_compnr',  
 cbcl_ref_compnr nvarchar(50) '$.cbcl_ref_compnr',txta_ref_compnr nvarchar(50) '$.txta_ref_compnr',  
 deleted nvarchar(50) '$.deleted',username nvarchar(50) '$.username',timestamp1 nvarchar(50) '$.timestamp',  
 sequencenumber nvarchar(50) '$.sequencenumber')  
  
  
 DELETE usln_tccom100 FROM usln_tccom100 INNER JOIN #templn_tccom100 ON usln_tccom100.bpid = #templn_tccom100.bpid and usln_tccom100.ctit = #templn_tccom100.ctit
								and usln_tccom100.prbp = #templn_tccom100.prbp and usln_tccom100.prst = #templn_tccom100.prst and usln_tccom100.stdt = #templn_tccom100.stdt 
								and usln_tccom100.endt = #templn_tccom100.endt and usln_tccom100.clan = #templn_tccom100.clan;  
  
  
 INSERT INTO usln_tccom100 SELECT * FROM #templn_tccom100;  
  
  
 update mastertable  set bsta = 'Success!!!',csta = 'Success!!!'  where dl_id = @dl_id;  


 drop table #templn_tccom100;
  
end

GO

