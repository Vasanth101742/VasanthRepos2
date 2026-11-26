CREATE proc [SP_GR_Correction]
as
begin

delete LN_TDSLS400 where deleted='Y'
delete LN_TDSLS401 where deleted='Y'
delete LN_TCCOM100 where deleted='Y'
delete LN_CISLI810 where deleted='Y'
delete LN_TDPUR400 where deleted='Y'
delete LN_TDPUR450 where deleted='Y'
delete LN_TDSLS450 where deleted='Y'
delete LN_TISFC001 where deleted='Y'
delete LN_WHINH312 where deleted='Y'
delete LN_CISLI305 where deleted='Y'
delete LN_CISLI200 where deleted='Y'
delete LN_WHINR110 where deleted='Y'
delete LN_TXSLS802 where deleted='Y'
delete LN_TDPUR401 where deleted='Y'
delete LN_TCIBD001 where deleted='Y'
delete LN_TDPUR094 where deleted='Y'
delete LN_TCMCS065 where deleted='Y'
delete LN_TSSOC205 where deleted='Y'
delete LN_TCCOM001 where deleted='Y'
delete LN_TSSOC210 where deleted='Y'
delete LN_TSSOC200 where deleted='Y'
delete LN_WHINH220 where deleted='Y'
delete LN_WHINH210 where deleted='Y'
delete LN_TCMCS015 where deleted='Y'
delete LN_TCMCS023 where deleted='Y'
delete LN_CISLI312 where deleted='Y'
delete LN_WHINH430 where deleted='Y'
delete LN_CISLI310 where deleted='Y'
delete LN_WHINP100 where deleted='Y'
delete LN_TSMDM030 where deleted='Y'
delete LN_TCCOM130 where deleted='Y'
delete LN_TXSLS803 where deleted='Y'
delete LN_TSCTM320 where deleted='Y'
delete LN_TSCTM460 where deleted='Y'
delete LN_TSCTM400 where deleted='Y'
delete LN_TSCTM300 where deleted='Y'
delete LN_TSCTM450 where deleted='Y'
delete LN_TSCTM480 where deleted='Y'
delete LN_TXSOC801 where deleted='Y'
delete LN_TSEPP100 where deleted='Y'
delete LN_WHWMD215 where deleted='Y'
delete LN_WHINH301 where deleted='Y'
delete LN_WHINA112 where deleted='Y'
delete LN_WHINA113 where deleted='Y'
delete LN_TXSLS999 where deleted='Y'
delete LN_BPTMM111 where deleted='Y'
delete LN_BPTMM130 where deleted='Y'


update LN_tsepp100 set qudt= CONVERT(datetime,SWITCHOFFSET(CONVERT(datetimeoffset,qudt),DATENAME(TzOffset, SYSDATETIMEOFFSET())))



end

GO

