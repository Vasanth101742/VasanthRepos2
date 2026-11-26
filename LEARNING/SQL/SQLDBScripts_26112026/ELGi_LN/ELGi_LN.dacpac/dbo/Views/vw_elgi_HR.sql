CREATE view [vw_elgi_HR] as

SELECT 	distinct GLOBAL, 
	A.company,
	A.Emp_Name,
	OLD_BAAN_EMPCODE, 
	CAST(coalesce (A.Emp_Code,OLD_BAAN_EMPCODE) AS INT)  EMP_CODE,
	--a.emp_code,
	Dense_rank() OVER(PARTITION BY LTRIM(RTRIM(A.EMP_CODE)),finmonthno
order by global ) AS ERANK,
	A.Designation, 
	Org_Unit, 
	isnull(ltrim(rtrim(Division_Name)),'') Division_Name, 
	isnull(ltrim(rtrim(Function_Name)),'') Function_Name,
	isnull(ltrim(rtrim(Department)),'') Department, 
	case when ltrim(rtrim(A.Band)) is null then 'Overseas'
	when ltrim(rtrim(A.Band))='' then 'Overseas'
	else ltrim(rtrim(A.Band)) end as Band,
	Location,
	Emp_Status, 	Reason, 	Seperation_Date, 	Transfer_Date,
	Start_Date, 	Data_Load_Date, 	num, 	FinMonthNo, 	FinMonthName, 
	FinYear, 	Fin_Year, Vertical_ordr,	vertical,	Function2,	Function2_ordr	
	--,Division_NewPage
FROM (
	

	--Domestic (Live and Resigned) Employees From SAP

	SELECT distinct 
 'DOMESTIC' AS GLOBAL,company,Emp_Name,' ' AS OLD_BAAN_EMPCODE, 
		Emp_Code,Band,Designation,Org_Unit,
		ltrim(rtrim(c.Division_Name)) as Division_Name,
		ltrim(rtrim(c.Function_Name)) as Function_Name,
		ltrim(rtrim(c.Department)) as Department,
		Location,Emp_Status,Reason,Seperation_Date,Transfer_Date,
		Start_Date,Data_Load_Date,num,FinMonthNo,FinMonthName, 
		FinYear,Fin_Year,Vertical_ordr,vertical,Function2,Function2_ordr
		 
	FROM 	HR_Master a
	left outer join (select distinct Division_Code,Division_Name,Function_Code,Function_Name,Dept_Code,Department,Vertical_ordr,vertical,Function2,Function2_ordr from HR_NewDimension2) b
	on ltrim(rtrim(a.Division_Code))=ltrim(rtrim(b.Division_Code))
	and ltrim(rtrim(a.Function_Code))=ltrim(rtrim(b.Function_Code))
	and ltrim(rtrim(a.Dept_Code))=ltrim(rtrim(b.Dept_Code))

 left outer join  --Newly Added on 20 Dec 2016 to display the latest DFD names
 (select Division_Code,Division_Name,Function_Code,Function_Name,Dept_Code,Department from HR_MASTER_DFD) c
 on a.Division_Code=c.Division_Code
 and a.Function_Code=c.Function_Code
 and a.Dept_Code=c.Dept_Code
	
	where emp_code not  between 800000 and 899999
	and Org_Unit<>'ERGO DESIGN PVT LIMITED'






----------------------------Method 1: International employees FETCHING FROM BAAN ----------------------------------------------------

--union 
	
----INTERNATIONAL (Live) Employees from BAAN
	
--	SELECT distinct 'INTERNATIONAL' AS GLOBAL,Emp_Name,F.Emp_Code AS OLD_BAAN_EMPCODE,I.NEW_ECODE AS Emp_Code, 
--		--case when ltrim(rtrim(f.Band))='' then 'Overseas'
--		--else ltrim(rtrim(f.Band)) end Band, 
--		f.Band,Designation,Org_Unit,
--		case when ltrim(rtrim(DIVNM)) is null then ltrim(rtrim(f.Division_Name))
--		else ltrim(rtrim(DIVNM)) end as Division_Name,	
--		case when ltrim(rtrim(FUNNM)) is null then ltrim(rtrim(f.Function_Name)) 
--		else ltrim(rtrim(FUNNM)) end as Function_Name, 
--		case when ltrim(rtrim(DEPNM)) is null then ltrim(rtrim(f.Department))
--		else ltrim(rtrim(DEPNM)) end as Department,
--		Location,Emp_Status,Reason,'' as Seperation_Date,Transfer_Date,New_Division,New_Function, 
--		New_Department,EE_Subgroup,Start_Date,Data_Load_Date,num,FinMonthNo,FinMonthName,FinYear, 
--		Fin_Year,Vertical_ordr,vertical,Function2,Function2_ordr
		
--	FROM (select * from HR_EMP where  Location is null or Location not in ('FRANCE')) F
--		left JOIN HR_OLD_NEW_EMPCODE I
--		ON F.Emp_Code=I.OLD_ECODE
--		left join
--		(
--		select 	a.ECODE,a.DIVCD,b.DIVNM,a.FUNCD,b.FUNNM,a.DEPCD,b.DEPNM 
--		from 	tthhrd113 a
--			inner join  tthhrd085 b
--				on a.DIVCD=b.DIVCD
--				and a.FUNCD=b.FUNCD
--				and a.DEPCD=b.DEPCD
--		) J
--		on ltrim(rtrim(f.Emp_Code))=ltrim(rtrim(J.ECODE))
		
--		left outer join (select distinct Division_Code,Division_Name,Function_Code,Function_Name,Dept_Code,Department,Vertical_ordr,vertical,Function2,Function2_ordr from HR_NewDimension2) b
--	  on ltrim(rtrim(j.DIVCD))=ltrim(rtrim(b.Division_Code))
--	  and ltrim(rtrim(j.FUNCD))=ltrim(rtrim(b.Function_Code))
--	  and ltrim(rtrim(j.DEPCD))=ltrim(rtrim(b.Dept_Code))
					
--		where f.emp_code between 800000 and 899999
--		and f.emp_code<>800445
		
--		union all 

--	--INTERNATIONAL (Resigned) Employees from BAAN
		
--		select 'INTERNATIONAL' AS GLOBAL, 
--		ENAME,a.ECODE,a.ECODE,'','','',
--		b.DIVNM,b.FUNNM,b.DEPNM,
--		--'','','',
--		'','WITHDRAWN','',DDATE as Seperation_Date,'','','','','','',
--			--'','','','','' ,'',
--			b.Data_Load_Date,1 as num,
--			case when month(b.Data_Load_Date) between 1 and 3 then month(b.Data_Load_Date) + 9 
--				else month(b.Data_Load_Date) - 3 end as FinMonthNo,
--   datename(mm,b.Data_Load_Date)  as FinMonthName,
--   case when month(b.Data_Load_Date) between 1 and 3 then year(b.Data_Load_Date) - 1 
--   else year(b.Data_Load_Date)  end as FinYear,
--   CASE WHEN month(b.Data_Load_Date) > 3 
--   THEN (CONVERT(varchar, year(b.Data_Load_Date)) + '-' + CONVERT(varchar, year(b.Data_Load_Date) + 1)) 
--   ELSE (CONVERT(varchar, year(b.Data_Load_Date) - 1) + '-' + CONVERT(varchar, year(b.Data_Load_Date))) END AS Fin_Year,
--   Vertical_ordr,vertical,Function2,function2_ordr

--			from tthhrd031100 a --Fetches Resigned Foreign Employees

--inner join
--(
--		select 	a.ECODE,a.DIVCD,b.DIVNM,a.FUNCD,b.FUNNM,a.DEPCD,b.DEPNM,(select max(Data_Load_Date) from HR_MASTER) as Data_Load_Date
--		from 	tthhrd113 a
--			inner join  tthhrd085 b
--				on a.DIVCD=b.DIVCD
--				and a.FUNCD=b.FUNCD
--				and a.DEPCD=b.DEPCD
										
--		) b --Fetches Employee's  DFD information
--		on a.ECODE=b.ECODE

--		left outer join (select distinct Division_Code,Division_Name,Function_Code,Function_Name,Dept_Code,Department,Vertical_ordr,vertical,Function2,Function2_ordr from HR_NewDimension2) c
--	  on ltrim(rtrim(b.DIVCD))=ltrim(rtrim(c.Division_Code))
--	  and ltrim(rtrim(b.FUNCD))=ltrim(rtrim(c.Function_Code))
--	  and ltrim(rtrim(b.DEPCD))=ltrim(rtrim(c.Dept_Code))
		
		
--where a.ECODE between 800000 and 899999 
--and a.ECODE<>800445
--and month(DDATE)= (select case when month(getdate()-1)=1 then 12 else month(getdate()-1)-1 end)
--and year(DDATE) = (select case when month(getdate()-1)=1 then year(getdate())-1 else year(getdate()) end )


-------------------------End of Method 1: International employees FETCHING FROM BAAN ------------------------------------------




---------------- Method 2: Manual file Data load from Dharanidharan (HR Team)----------------------------------------------------
--UNION

--select GLOBAL,Emp_Name,OLD_BAAN_EMPCODE,Emp_Code,Band,Designation,'' as Org_Unit,Division_Name,Function_Name,Department,
--null as Location,Emp_Status,'' as Reason,
--case when Seperation_Date is null then '1900-01-01 00:00:00.000' else  Seperation_Date end as Seperation_Date,
--'' as Transfer_Date,'' as New_Division,'' as New_Function,'' as New_Department,
--'' as EE_Subgroup,Start_Date,Data_Load_Date,num,FinMonthNo,FinMonthName,FinYear,Fin_Year,Vertical_ordr,vertical,Function2,Function2_ordr 
--from hr_emp_manualload

------------------End of Method 2: Manual file data load from Dharanidharan HR Team----------------------------------------------





-----------------------Method 3: International employees from Intranet-----------------------------------------------------------

Union

--Active Foreign Employees
select * from (
select 'INTERNATIONAL' as GLOBAL,comp_code,Emp_Name,emp_code as OLD_BAAN_EMPCODE,new_emp_code as Emp_Code,Band,Designation,
'' as Org_Unit,a.region_name as Division_Name,a.Function_Name,a.sub_function_name as Department,
uname as Location,
case when employee_status='Live' then 'ACTIVE'
when employee_status='Resigned' then 'WITHDRAWN' else employee_status end as Emp_Status,'' as Reason,
case when settledate is null or settledate='' then '1900-01-01 00:00:00.000'
else convert(datetime,substring(settledate,7,4)+'-'+substring(settledate,4,2)+'-'+substring(settledate,1,2)) 
end as Seperation_Date,
'' as Transfer_Date,joindate as Start_Date,
Data_Load_Date,1 as num,
case when month(Data_Load_Date) between 1 and 3 then month(Data_Load_Date) + 9 else month(Data_Load_Date) - 3 end as FinMonthNo,
datename(mm,Data_Load_Date)  as FinMonthName,
case when month(Data_Load_Date) between 1 and 3 then year(Data_Load_Date) - 1 else year(Data_Load_Date)  end as FinYear,
CASE WHEN month(Data_Load_Date) > 3 THEN (CONVERT(varchar, year(Data_Load_Date)) + '-' + CONVERT(varchar, year(Data_Load_Date) + 1)) 
                      ELSE (CONVERT(varchar, year(Data_Load_Date) - 1) + '-' + CONVERT(varchar, year(Data_Load_Date))) END AS Fin_Year,

b.Vertical_ordr,b.vertical,b.Function2,b.Function2_ordr 
from (select *,
dateadd(d,-1,convert(date,convert(varchar,year(getdate()))+'-'+RIGHT('00'+CAST(month(getdate()) AS VARCHAR(2)),2)+'-01'))  as Data_Load_Date
from [ELGi_Intranet].dbo.Employee_Detail where new_emp_code between 800000 and 899999 
)a
left outer join  (select * from [ELGI-DW].dbo.HR_NewDimension2)b
on a.region_code=b.Division_Code
and a.function_code=b.Function_Code
and a.sub_function_code=b.Dept_Code
)c
where Emp_Status='ACTIVE'
and Emp_Code not in (800445,800482,800509,800510,800520)
and Start_Date<= dateadd(d,-1,convert(datetime,convert(varchar,year(getdate()))+'-'+RIGHT('00'+CAST(month(getdate()) AS VARCHAR(2)),2)+'-01'))

union

--Foreign Employees Resigned on the Current Month
select * from (
select 'INTERNATIONAL' as GLOBAL,comp_code,Emp_Name,emp_code as OLD_BAAN_EMPCODE,new_emp_code as Emp_Code,Band,Designation,
'' as Org_Unit,a.region_name as Division_Name,a.Function_Name,a.sub_function_name as Department,
uname as Location,
case when employee_status='Live' then 'ACTIVE'
when employee_status='Resigned' then 'WITHDRAWN' else employee_status end as Emp_Status,'' as Reason,
case when settledate is null or settledate='' then '1900-01-01 00:00:00.000'
else convert(datetime,substring(settledate,7,4)+'-'+substring(settledate,4,2)+'-'+substring(settledate,1,2)) 
end as Seperation_Date,
'' as Transfer_Date,joindate as Start_Date,
Data_Load_Date,1 as num,
case when month(Data_Load_Date) between 1 and 3 then month(Data_Load_Date) + 9 else month(Data_Load_Date) - 3 end as FinMonthNo,
datename(mm,Data_Load_Date)  as FinMonthName,
case when month(Data_Load_Date) between 1 and 3 then year(Data_Load_Date) - 1 else year(Data_Load_Date)  end as FinYear,
CASE WHEN month(Data_Load_Date) > 3 THEN (CONVERT(varchar, year(Data_Load_Date)) + '-' + CONVERT(varchar, year(Data_Load_Date) + 1)) 
                      ELSE (CONVERT(varchar, year(Data_Load_Date) - 1) + '-' + CONVERT(varchar, year(Data_Load_Date))) END AS Fin_Year,

b.Vertical_ordr,b.vertical,b.Function2,b.Function2_ordr 
from (select *,
dateadd(d,-1,convert(date,convert(varchar,year(getdate()))+'-'+RIGHT('00'+CAST(month(getdate()) AS VARCHAR(2)),2)+'-01'))  as Data_Load_Date 
from [ELGi_Intranet].dbo.Employee_Detail where new_emp_code between 800000 and 899999 
)a
left outer join  (select * from [ELGI-DW].dbo.HR_NewDimension2)b
on a.region_code=b.Division_Code
and a.function_code=b.Function_Code
and a.sub_function_code=b.Dept_Code
)c
where Emp_Status='WITHDRAWN'
and Emp_Code not in (800445,800482,800509,800510,800520)
and Seperation_Date between 
--Old Logic
--(select max(Data_Load_Date)+1 from elgi_hr) and
--dateadd(d,-1,convert(datetime,convert(varchar,year(getdate()))+'-'+RIGHT('00'+CAST(month(getdate()) AS VARCHAR(2)),2)+'-01'))
--New Logic
dateadd(mm,-1,dateadd(mm,datediff(mm,0,getdate()),0)) --as  'First day of previous Month'
and
dateadd(dd,-2,dateadd(mm,0,dateadd(mm,datediff(mm,0,getdate()),0))) --as  'Last day of previous Month'

union 


--Foreign Employees Resigned on the Next Month to be shown as ACTIVE in the Current Month
select * from (
select 'INTERNATIONAL' as GLOBAL,comp_code,Emp_Name,emp_code as OLD_BAAN_EMPCODE,new_emp_code as Emp_Code,Band,Designation,
'' as Org_Unit,a.region_name as Division_Name,a.Function_Name,a.sub_function_name as Department,
uname as Location,
case when employee_status='Live' then 'ACTIVE'
when employee_status='Resigned' then 'ACTIVE' --Resigned on the Next Month to be shown as ACTIVE in the Current Month
else employee_status end as Emp_Status,'' as Reason,
case when settledate is null or settledate='' then '1900-01-01 00:00:00.000'
else convert(datetime,substring(settledate,7,4)+'-'+substring(settledate,4,2)+'-'+substring(settledate,1,2)) 
end as Seperation_Date,
'' as Transfer_Date,joindate as Start_Date,
Data_Load_Date,1 as num,
case when month(Data_Load_Date) between 1 and 3 then month(Data_Load_Date) + 9 else month(Data_Load_Date) - 3 end as FinMonthNo,
datename(mm,Data_Load_Date)  as FinMonthName,
case when month(Data_Load_Date) between 1 and 3 then year(Data_Load_Date) - 1 else year(Data_Load_Date)  end as FinYear,
CASE WHEN month(Data_Load_Date) > 3 THEN (CONVERT(varchar, year(Data_Load_Date)) + '-' + CONVERT(varchar, year(Data_Load_Date) + 1)) 
                      ELSE (CONVERT(varchar, year(Data_Load_Date) - 1) + '-' + CONVERT(varchar, year(Data_Load_Date))) END AS Fin_Year,

b.Vertical_ordr,b.vertical,b.Function2,b.Function2_ordr 
from (select *,
dateadd(d,-1,convert(date,convert(varchar,year(getdate()))+'-'+RIGHT('00'+CAST(month(getdate()) AS VARCHAR(2)),2)+'-01'))  as Data_Load_Date 
from [ELGi_Intranet].dbo.Employee_Detail where new_emp_code between 800000 and 899999 
)a
left outer join  (select * from [ELGI-DW].dbo.HR_NewDimension2)b
on a.region_code=b.Division_Code
and a.function_code=b.Function_Code
and a.sub_function_code=b.Dept_Code
)c
where Emp_Status='ACTIVE'
and Emp_Code not in (800445,800482,800509,800510)
and Seperation_Date >
dateadd(d,-1,convert(datetime,convert(varchar,year(getdate()))+'-'+RIGHT('00'+CAST(month(getdate()) AS VARCHAR(2)),2)+'-01'))


---------------------End of Method 3: International employees from Intranet---------------------------------------------------------


)A

GO

