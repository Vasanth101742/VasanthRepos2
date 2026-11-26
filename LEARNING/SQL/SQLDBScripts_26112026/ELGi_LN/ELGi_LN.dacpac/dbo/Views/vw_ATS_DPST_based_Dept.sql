
create view [dbo].[vw_ATS_DPST_based_Dept] as
select '90040' as DPSTCODE,'AED - MANUFACTURED UNITS' as DPSTNAME,'Units' as Dept union
select '90041' as DPSTCODE,'AED - SPARES' as DPSTNAME,'Spares' as Dept union
select '90042' as DPSTCODE,'AED - TRADED UNITS' as DPSTNAME,'Units' as Dept union
select '90043' as DPSTCODE,'CLMS PIPING SERVICE CHARGES' as DPSTNAME,'Service' as Dept union
select '90044' as DPSTCODE,'AED-SPECIAL PROJECTS' as DPSTNAME,'PVD ' as Dept union
select '90045' as DPSTCODE,'AED - SERVICE CONTRACT' as DPSTNAME,'Service' as Dept union
select '90048' as DPSTCODE,'AED - SERVICE BILLING' as DPSTNAME,'Service' as Dept union
select '90049' as DPSTCODE,'SUPPLIER SALES' as DPSTNAME,'Supplier Sales' as Dept union
select '90050' as DPSTCODE,'AED - PNEUMATIC TOOLS' as DPSTNAME,'Units' as Dept union
select '90051' as DPSTCODE,'PNEUMATIC TOOLS SPARES' as DPSTNAME,'Spares' as Dept union
select '90052' as DPSTCODE,'PNEMATIC TOOLS ACCESSORIES' as DPSTNAME,'Units' as Dept union
select '90054' as DPSTCODE,'COMPREHENSIVE AMC' as DPSTNAME,'Service' as Dept union
select '90111' as DPSTCODE,'SCRAP MATERIALS & MACHINERY SA' as DPSTNAME,'Scrap Sales' as Dept union
select '90240' as DPSTCODE,'AED - UNITS - INTERNATIONAL' as DPSTNAME,'International' as Dept union
select '90241' as DPSTCODE,'AED - SPARES - INTERNATIONAL' as DPSTNAME,'International' as Dept union
select '90242' as DPSTCODE,'ATS - TRADED UNITS - EXPORTS' as DPSTNAME,'International' as Dept union
select '90250' as DPSTCODE,'AED - PNEU. TOOLS - INTERNATIONAL' as DPSTNAME,'International' as Dept union
select '90251' as DPSTCODE,'PNEU. TOOLS SPARES - INTERNATIONAL' as DPSTNAME,'International' as Dept union
select '90244' as DPSTCODE,'AED - FLACO - INTERNATIONAL' as DPSTNAME,'International' as Dept union
select '90046' as DPSTCODE,'Training Income' as DPSTNAME,'Units' as Dept union
select '90047' as DPSTCODE,'PAYU Income' as DPSTNAME,'Service PAYU' as Dept union
select '90260' as DPSTCODE,'ATS-PRIVATE BRANDING MFG' as DPSTNAME,'Units' as Dept union
select '90262' as DPSTCODE,'ATS-PRIVATE BRANDING TRADED' as DPSTNAME,'Units' as Dept

GO

