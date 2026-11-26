CREATE proc [dbo].[SP_GR_TPLSPEC_DF]
as
begin

delete  [DF].[TT].dbo.[TPL_SPEC]
delete  [LN].[Integration].[dbo].[TPL_SPEC]

INSERT INTO [DF].[TT].[dbo].[TPL_SPEC]
([T$REFCNTD],[T$REFCNTU],[T$ITEM],[T$MITM],[T$REVI],[T$SLNO],[T$PFAD],[T$WPRE],[T$UPRE],[T$APOW],[T$MRAT],[T$RSMM],[T$SREF],[T$CFAD],[T$SREV],[T$OILR]
,[T$TANK],[T$UNIT],[T$UPDT],[T$UPTM],[T$LOGN],[T$PIPV],[T$PROD],[T$MODL],[T$LFAD],[T$UPRB],[T$WPRB],[T$ASPK],[T$TOFC],[T$PMDN],[T$GDNO],[T$MRNO],[T$RSNL],[T$RSVB]
,[T$PNWD],[T$AOPZ],[T$DOTE],[T$CSTF],[T$DPDN],[T$DCFT],[T$TSMM],[T$OLRS],[T$EMEC],[T$FSMT],[T$IPMM],[T$SPCF],[T$MSCH],[T$NPSC],[T$MSCK],[T$MXVL],[T$MAAT],[T$RCAA]
,[T$NLCR],[T$RSFS],[T$SVSP],[T$SVSB],[T$PWHT],[T$ODWP],[T$ODOU],[T$TDRV],[T$MPIL],[T$PIPZ],[T$CPCS],[T$MTYP],[T$MFMR],[T$FSPD],[T$WOPO],[T$WFPO],[T$WFLP],[T$FRAT],[T$HLOD],[T$SCSP]
,[T$OCOV],[T$HLTP],[T$HLTB],[T$LPSC],[T$APRP],[T$APRB],[T$NSPP],[T$NSPB],[T$HTTV],[T$RSAP],[T$CTYP],[T$MPVP],[T$MPVB],[T$TTYP],[T$TYSZ],[T$RTMS],[T$DVPS],[T$DVPP]
,[T$DNPP],[T$BTYP],[T$BLEN],[T$BSLN],[T$BMAS],[T$SBTB],[T$MMAP],[T$MSBA],[T$VOLT],[T$FREQ],[T$SVSK],[T$DCYC],[T$FADR],[T$FADM],[T$MWPR],[T$IDPR],[T$SCSS],[T$OCSS]
,[T$EMAK],[T$EMOD],[T$EPON],[T$CSPO],[T$FAPO],[T$ROSP],[T$IDSP],[T$DRSP],[T$FCRC],[T$ELOC],[T$ECCA],[T$BACQ],[T$FWHO],[T$FLWH],[T$TMOU],[T$IOFR],[T$FTCA],[T$DISC]
,[T$DISL],[T$DISM],[T$COMS],[T$CYLC],[T$NCYL],[T$DCYL],[T$SLEN],[T$RSCR],[T$MDRT],[T$TVAL],[T$DROT],[T$AFTP],[T$TLUB],[T$TCTB],[T$TCIC],[T$TCAC],[T$ARCP],[T$SSPF],[T$SSPS]
,[T$SSPI],[T$SSAC],[T$SSAR],[T$PWCO],[T$PWCI],[T$TBWH],[T$NLCY],[T$DLCB],[T$DHCB],[T$TVLP],[T$TVHP],[T$ISPR],[T$PIPH],[T$PIZH],[T$DOTA],[T$DOTB],[T$DOTC],[T$MPIH],[T$ODSC]
,[T$ODUC],[T$CUTP],[T$CUTB],[T$TCAP],[T$FARM],[T$FAMM],[T$MWPK],[T$IDPK],[T$SCSK],[T$OCSK],[T$MCNP],[T$TOMI],[T$TOMA],[T$RSNP],[T$RSDV],[T$NSCY],[T$DFCY],[T$DSCY],[T$DTCY]
,[T$FSPR],[T$SSPR],[T$BPDE],[T$MOTO],[T$FLW1],[T$FLW2],[T$FLW3],[T$FLW4],[T$FLW5],[T$FLW6],[T$FRQ1],[T$FRQ2],[T$FRQ3],[T$FRQ4],[T$FRQ5],[T$FRQ6],[T$IPK1],[T$IPK2]
,[T$IPK3],[T$IPK4],[T$IPK5],[T$IPK6],[T$SPC1],[T$SPC2],[T$SPC3],[T$SPC4],[T$SPC5],[T$SPC6],[T$TDR1],[T$TDR2],[T$TDR3],[T$TDR4],[T$TDR5],[T$TDR6],ModifiedDate)

select distinct [T$REFCNTD],[T$REFCNTU],[T$ITEM],[T$MITM],[T$REVI],[T$SLNO],[T$PFAD],[T$WPRE],[T$UPRE],[T$APOW],[T$MRAT],[T$RSMM],[T$SREF],[T$CFAD],[T$SREV],[T$OILR]
,[T$TANK],[T$UNIT],[T$UPDT],[T$UPTM],[T$LOGN],[T$PIPV],[T$PROD],[T$MODL],[T$LFAD],[T$UPRB],[T$WPRB],[T$ASPK],[T$TOFC],[T$PMDN],[T$GDNO],[T$MRNO],[T$RSNL],[T$RSVB]
,[T$PNWD],[T$AOPZ],[T$DOTE],[T$CSTF],[T$DPDN],[T$DCFT],[T$TSMM],isnull(replace(replace(replace([T$OLRS],'-','0'),'NA','0'),'Null','0'),'0'),[T$EMEC],[T$FSMT],[T$IPMM],[T$SPCF],[T$MSCH],[T$NPSC],[T$MSCK],[T$MXVL],[T$MAAT],[T$RCAA]
,[T$NLCR],[T$RSFS],[T$SVSP],[T$SVSB],[T$PWHT],[T$ODWP],[T$ODOU],[T$TDRV],[T$MPIL],[T$PIPZ],[T$CPCS],[T$MTYP],isnull(replace(replace(replace([T$MFMR],'-','0'),'NA','0'),'Null','0'),'0')[T$MFMR],[T$FSPD],[T$WOPO],[T$WFPO],[T$WFLP],[T$FRAT],[T$HLOD],[T$SCSP]
,[T$OCOV],[T$HLTP],[T$HLTB],[T$LPSC],[T$APRP],[T$APRB],[T$NSPP],[T$NSPB],[T$HTTV],[T$RSAP],[T$CTYP],[T$MPVP],[T$MPVB],[T$TTYP],[T$TYSZ],[T$RTMS],
isnull(replace(replace(replace([T$DVPS],'-','0'),'NA','0'),'Null','0'),'0'),isnull(replace(replace(replace([T$DVPP],'-','0'),'NA','0'),'Null','0'),'0')
,isnull(replace(replace(replace([T$DNPP],'-','0'),'NA','0'),'Null','0'),'0') ,[T$BTYP],[T$BLEN],[T$BSLN],[T$BMAS],[T$SBTB],[T$MMAP],[T$MSBA],[T$VOLT],[T$FREQ],isnull(replace(replace(replace([T$SVSK],'-','0'),'NA','0'),'Null','0'),'0')[T$SVSK],[T$DCYC],[T$FADR],[T$FADM],[T$MWPR],[T$IDPR],[T$SCSS],[T$OCSS]
,[T$EMAK],[T$EMOD],[T$EPON],[T$CSPO],[T$FAPO],[T$ROSP],[T$IDSP],[T$DRSP],[T$FCRC],[T$ELOC],[T$ECCA],[T$BACQ],[T$FWHO],[T$FLWH],[T$TMOU],[T$IOFR],[T$FTCA],[T$DISC]
,[T$DISL],[T$DISM],[T$COMS],[T$CYLC],[T$NCYL],[T$DCYL],[T$SLEN],[T$RSCR],[T$MDRT],[T$TVAL],[T$DROT],[T$AFTP],[T$TLUB],[T$TCTB],[T$TCIC],[T$TCAC],[T$ARCP],[T$SSPF],[T$SSPS]
,[T$SSPI],[T$SSAC],[T$SSAR],[T$PWCO],[T$PWCI],[T$TBWH],[T$NLCY],[T$DLCB],[T$DHCB],[T$TVLP],[T$TVHP],[T$ISPR],isnull(replace(replace(replace([T$PIPH],'-','0'),'NA','0'),'Null','0'),'0')[T$PIPH],
isnull(replace(replace(replace([T$PIZH],'-','0'),'NA','0'),'Null','0'),'0')[T$PIZH],isnull(replace(replace(replace([T$DOTA],'-','0'),'NA','0'),'Null','0'),'0')[T$DOTA],[T$DOTB],[T$DOTC],[T$MPIH],[T$ODSC]
,[T$ODUC],[T$CUTP],[T$CUTB],[T$TCAP],[T$FARM],[T$FAMM],[T$MWPK],[T$IDPK],[T$SCSK],[T$OCSK],[T$MCNP],[T$TOMI],[T$TOMA],[T$RSNP],[T$RSDV],[T$NSCY],[T$DFCY],[T$DSCY],[T$DTCY]
,[T$FSPR],[T$SSPR],[T$BPDE],[T$MOTO],[T$FLW1],[T$FLW2],[T$FLW3],[T$FLW4],[T$FLW5],[T$FLW6],[T$FRQ1],[T$FRQ2],[T$FRQ3],[T$FRQ4],[T$FRQ5],[T$FRQ6],[T$IPK1],[T$IPK2]
,[T$IPK3],[T$IPK4],[T$IPK5],[T$IPK6],
isnull(replace(replace(replace([T$SPC1],'-','0'),'NA','0'),'Null','0'),'0')[T$SPC1],isnull(replace(replace(replace([T$SPC2],'-','0'),'NA','0'),'Null','0'),'0')[T$SPC2]
,isnull(replace(replace(replace([T$SPC3],'-','0'),'NA','0'),'Null','0'),'0')[T$SPC3],isnull(replace(replace(replace([T$SPC4],'-','0'),'NA','0'),'Null','0'),'0')[T$SPC4]
,isnull(replace(replace(replace([T$SPC5],'-','0'),'NA','0'),'Null','0'),'0')[T$SPC5],isnull(replace(replace(replace([T$SPC6],'-','0'),'NA','0'),'Null','0'),'0')[T$SPC6],[T$TDR1],[T$TDR2],[T$TDR3],[T$TDR4],[T$TDR5],[T$TDR6],getdate() from (
SELECT b.*
FROM 
(SELECT t$MITM,MAX(t$REVI) REVI,max(t$srev) 'srev' FROM TZZSFC001ALL 
GROUP BY t$MITM)A
left JOIN TZZSFC001ALL B
ON A.t$MITM=B.t$MITM
AND A.REVI=B.t$REVI
AND A.SREV=B.t$srev
)a where isnull([T$MITM],'')!='' 




INSERT INTO [LN].[Integration].[dbo].[TPL_SPEC]
([T$REFCNTD],[T$REFCNTU],[T$ITEM],[T$MITM],[T$REVI],[T$SLNO],[T$PFAD],[T$WPRE],[T$UPRE],[T$APOW],[T$MRAT],[T$RSMM],[T$SREF],[T$CFAD],[T$SREV],[T$OILR]
,[T$TANK],[T$UNIT],[T$UPDT],[T$UPTM],[T$LOGN],[T$PIPV],[T$PROD],[T$MODL],[T$LFAD],[T$UPRB],[T$WPRB],[T$ASPK],[T$TOFC],[T$PMDN],[T$GDNO],[T$MRNO],[T$RSNL],[T$RSVB]
,[T$PNWD],[T$AOPZ],[T$DOTE],[T$CSTF],[T$DPDN],[T$DCFT],[T$TSMM],[T$OLRS],[T$EMEC],[T$FSMT],[T$IPMM],[T$SPCF],[T$MSCH],[T$NPSC],[T$MSCK],[T$MXVL],[T$MAAT],[T$RCAA]
,[T$NLCR],[T$RSFS],[T$SVSP],[T$SVSB],[T$PWHT],[T$ODWP],[T$ODOU],[T$TDRV],[T$MPIL],[T$PIPZ],[T$CPCS],[T$MTYP],[T$MFMR],[T$FSPD],[T$WOPO],[T$WFPO],[T$WFLP],[T$FRAT],[T$HLOD],[T$SCSP]
,[T$OCOV],[T$HLTP],[T$HLTB],[T$LPSC],[T$APRP],[T$APRB],[T$NSPP],[T$NSPB],[T$HTTV],[T$RSAP],[T$CTYP],[T$MPVP],[T$MPVB],[T$TTYP],[T$TYSZ],[T$RTMS],[T$DVPS],[T$DVPP]
,[T$DNPP],[T$BTYP],[T$BLEN],[T$BSLN],[T$BMAS],[T$SBTB],[T$MMAP],[T$MSBA],[T$VOLT],[T$FREQ],[T$SVSK],[T$DCYC],[T$FADR],[T$FADM],[T$MWPR],[T$IDPR],[T$SCSS],[T$OCSS]
,[T$EMAK],[T$EMOD],[T$EPON],[T$CSPO],[T$FAPO],[T$ROSP],[T$IDSP],[T$DRSP],[T$FCRC],[T$ELOC],[T$ECCA],[T$BACQ],[T$FWHO],[T$FLWH],[T$TMOU],[T$IOFR],[T$FTCA],[T$DISC]
,[T$DISL],[T$DISM],[T$COMS],[T$CYLC],[T$NCYL],[T$DCYL],[T$SLEN],[T$RSCR],[T$MDRT],[T$TVAL],[T$DROT],[T$AFTP],[T$TLUB],[T$TCTB],[T$TCIC],[T$TCAC],[T$ARCP],[T$SSPF],[T$SSPS]
,[T$SSPI],[T$SSAC],[T$SSAR],[T$PWCO],[T$PWCI],[T$TBWH],[T$NLCY],[T$DLCB],[T$DHCB],[T$TVLP],[T$TVHP],[T$ISPR],[T$PIPH],[T$PIZH],[T$DOTA],[T$DOTB],[T$DOTC],[T$MPIH],[T$ODSC]
,[T$ODUC],[T$CUTP],[T$CUTB],[T$TCAP],[T$FARM],[T$FAMM],[T$MWPK],[T$IDPK],[T$SCSK],[T$OCSK],[T$MCNP],[T$TOMI],[T$TOMA],[T$RSNP],[T$RSDV],[T$NSCY],[T$DFCY],[T$DSCY],[T$DTCY]
,[T$FSPR],[T$SSPR],[T$BPDE],[T$MOTO],[T$FLW1],[T$FLW2],[T$FLW3],[T$FLW4],[T$FLW5],[T$FLW6],[T$FRQ1],[T$FRQ2],[T$FRQ3],[T$FRQ4],[T$FRQ5],[T$FRQ6],[T$IPK1],[T$IPK2]
,[T$IPK3],[T$IPK4],[T$IPK5],[T$IPK6],[T$SPC1],[T$SPC2],[T$SPC3],[T$SPC4],[T$SPC5],[T$SPC6],[T$TDR1],[T$TDR2],[T$TDR3],[T$TDR4],[T$TDR5],[T$TDR6])

select distinct [T$REFCNTD],[T$REFCNTU],[T$ITEM],[T$MITM],[T$REVI],[T$SLNO],[T$PFAD],[T$WPRE],[T$UPRE],[T$APOW],[T$MRAT],[T$RSMM],[T$SREF],[T$CFAD],[T$SREV],[T$OILR]
,[T$TANK],[T$UNIT],[T$UPDT],[T$UPTM],[T$LOGN],[T$PIPV],[T$PROD],[T$MODL],[T$LFAD],[T$UPRB],[T$WPRB],[T$ASPK],[T$TOFC],[T$PMDN],[T$GDNO],[T$MRNO],[T$RSNL],[T$RSVB]
,[T$PNWD],[T$AOPZ],[T$DOTE],[T$CSTF],[T$DPDN],[T$DCFT],[T$TSMM],isnull(replace(replace(replace([T$OLRS],'-','0'),'NA','0'),'Null','0'),'0'),[T$EMEC],[T$FSMT],[T$IPMM],[T$SPCF],[T$MSCH],[T$NPSC],[T$MSCK],[T$MXVL],[T$MAAT],[T$RCAA]
,[T$NLCR],[T$RSFS],[T$SVSP],[T$SVSB],[T$PWHT],[T$ODWP],[T$ODOU],[T$TDRV],[T$MPIL],[T$PIPZ],[T$CPCS],[T$MTYP],isnull(replace(replace(replace([T$MFMR],'-','0'),'NA','0'),'Null','0'),'0')[T$MFMR],[T$FSPD],[T$WOPO],[T$WFPO],[T$WFLP],[T$FRAT],[T$HLOD],[T$SCSP]
,[T$OCOV],[T$HLTP],[T$HLTB],[T$LPSC],[T$APRP],[T$APRB],[T$NSPP],[T$NSPB],[T$HTTV],[T$RSAP],[T$CTYP],[T$MPVP],[T$MPVB],[T$TTYP],[T$TYSZ],[T$RTMS],
isnull(replace(replace(replace([T$DVPS],'-','0'),'NA','0'),'Null','0'),'0'),isnull(replace(replace(replace([T$DVPP],'-','0'),'NA','0'),'Null','0'),'0')
,isnull(replace(replace(replace([T$DNPP],'-','0'),'NA','0'),'Null','0'),'0') ,[T$BTYP],[T$BLEN],[T$BSLN],[T$BMAS],[T$SBTB],[T$MMAP],[T$MSBA],[T$VOLT],[T$FREQ],isnull(replace(replace(replace([T$SVSK],'-','0'),'NA','0'),'Null','0'),'0')[T$SVSK],[T$DCYC],[T$FADR],[T$FADM],[T$MWPR],[T$IDPR],[T$SCSS],[T$OCSS]
,[T$EMAK],[T$EMOD],[T$EPON],[T$CSPO],[T$FAPO],[T$ROSP],[T$IDSP],[T$DRSP],[T$FCRC],[T$ELOC],[T$ECCA],[T$BACQ],[T$FWHO],[T$FLWH],[T$TMOU],[T$IOFR],[T$FTCA],[T$DISC]
,[T$DISL],[T$DISM],[T$COMS],[T$CYLC],[T$NCYL],[T$DCYL],[T$SLEN],[T$RSCR],[T$MDRT],[T$TVAL],[T$DROT],[T$AFTP],[T$TLUB],[T$TCTB],[T$TCIC],[T$TCAC],[T$ARCP],[T$SSPF],[T$SSPS]
,[T$SSPI],[T$SSAC],[T$SSAR],[T$PWCO],[T$PWCI],[T$TBWH],[T$NLCY],[T$DLCB],[T$DHCB],[T$TVLP],[T$TVHP],[T$ISPR],isnull(replace(replace(replace([T$PIPH],'-','0'),'NA','0'),'Null','0'),'0')[T$PIPH],
isnull(replace(replace(replace([T$PIZH],'-','0'),'NA','0'),'Null','0'),'0')[T$PIZH],isnull(replace(replace(replace([T$DOTA],'-','0'),'NA','0'),'Null','0'),'0')[T$DOTA],[T$DOTB],[T$DOTC],[T$MPIH],[T$ODSC]
,[T$ODUC],[T$CUTP],[T$CUTB],[T$TCAP],[T$FARM],[T$FAMM],[T$MWPK],[T$IDPK],[T$SCSK],[T$OCSK],[T$MCNP],[T$TOMI],[T$TOMA],[T$RSNP],[T$RSDV],[T$NSCY],[T$DFCY],[T$DSCY],[T$DTCY]
,[T$FSPR],[T$SSPR],[T$BPDE],[T$MOTO],[T$FLW1],[T$FLW2],[T$FLW3],[T$FLW4],[T$FLW5],[T$FLW6],[T$FRQ1],[T$FRQ2],[T$FRQ3],[T$FRQ4],[T$FRQ5],[T$FRQ6],[T$IPK1],[T$IPK2]
,[T$IPK3],[T$IPK4],[T$IPK5],[T$IPK6],
isnull(replace(replace(replace([T$SPC1],'-','0'),'NA','0'),'Null','0'),'0')[T$SPC1],isnull(replace(replace(replace([T$SPC2],'-','0'),'NA','0'),'Null','0'),'0')[T$SPC2]
,isnull(replace(replace(replace([T$SPC3],'-','0'),'NA','0'),'Null','0'),'0')[T$SPC3],isnull(replace(replace(replace([T$SPC4],'-','0'),'NA','0'),'Null','0'),'0')[T$SPC4]
,isnull(replace(replace(replace([T$SPC5],'-','0'),'NA','0'),'Null','0'),'0')[T$SPC5],isnull(replace(replace(replace([T$SPC6],'-','0'),'NA','0'),'Null','0'),'0')[T$SPC6],[T$TDR1],[T$TDR2],[T$TDR3],[T$TDR4],[T$TDR5],[T$TDR6] from (
SELECT b.*
FROM 
(SELECT t$MITM,MAX(t$REVI) REVI,max(t$srev) 'srev' FROM TZZSFC001ALL 
GROUP BY t$MITM)A
left JOIN TZZSFC001ALL B
ON A.t$MITM=B.t$MITM
AND A.REVI=B.t$REVI
AND A.SREV=B.t$srev
)a where isnull([T$MITM],'')!='' 





end

GO

