CREATE VIEW [dbo].[vw_collection_report_daily_new_ats] as

SELECT company, Trantyp, InvNo, CustNo, CustName1, DocDt, collection, DpstCode, DpstName, Description, areacode, AreaName, Zone, region, Global,AnpTranTyp, anpdocno, cdocno, ctrantyp, doctyp, refr
FROM 
(
SELECT dates.company, dates.Trantyp, dates.InvNo, dates.CustNo, e.t_nama as CustName1,
dates.DocDt, - (1 * dates.amnthome) AS collection, c.DpstCode, c.DpstName, c.Description, 
LTRIM(RTRIM(acc_rec_ats.area)) AS areacode, d.AreaName, d.ATS_Zone as zone, d.region, d.Global,
dates.AnpTranTyp, dates.anpdocno, dates.cdocno, dates.ctrantyp, dates.doctyp, 0 AS refr
FROM    
(
SELECT a.company, a.Trantyp, a.InvNo, a.[LineNo], a.CustNo, 
a.DocDt, CASE WHEN len(ltrim(rtrim(a.area))) = 2 THEN '0' + ltrim(rtrim(a.area)) 
ELSE a.area END AS area, a.PurNo, a.DueDt, a.CurRate, 
b.AreaCode AS area_head, CASE WHEN CONVERT(varchar, b.dpst) IS NULL THEN ltrim(rtrim(proj)) 
ELSE CONVERT(varchar, dpst) END AS dpst
FROM (select * from Collection_Stage2 where company in (select Company from ELGI_Companies_Master where CompanyGroup='ATS')
and purno not like '%[a-z]%' 
) a  
LEFT OUTER JOIN 
(

--select company,OrderNo,CustCode,dpst,areacode from LN_Sales_Details_ver2 
--where company in (select Company from ELGI_Companies_Master where CompanyGroup='ATS')
--and dpst not like '%[a-z]%'
select company,OrderNum as OrderNo,CustCode,t_cofc as dpst,areacode from CI_Lines 
where company in (select Company from ELGI_Companies_Master where CompanyGroup='ATS')
and t_cofc not like '%[a-z]%'
--union
--select company,OrderNum,concat('CU1',CustCode),Dpst,Area from TmpSlsDespData_baan 
--where company in (select Company from ELGI_Companies_Master where CompanyGroup='ATS')
) b
ON b.Company = a.company 
AND b.OrderNo = a.PurNo 
AND ltrim(rtrim(b.CustCode)) =ltrim(rtrim(a.CustNo))
--AND ltrim(rtrim(b.CustCode)) =ltrim(rtrim(substring(a.CustNo,4,20)))
WHERE (a.CDocNo = 0)
GROUP BY a.company, a.Trantyp, a.InvNo, a.[LineNo],a.CustNo, a.DocDt, a.Area, a.PurNo,a.DueDt,a.CurRate,b.AreaCode,b.dpst,a.Proj
) AS acc_rec_ats 

INNER JOIN
   
(
SELECT     company, Trantyp, InvNo, CustNo, DocDt, SUM(AmntHome) AS amnthome, AnpTranTyp, MAX(AnpDocNo) AS anpdocno,
MAX(CDocNo) AS cdocno, MAX(CTranTyp) AS ctrantyp, 2 AS doctyp, [LineNo]
FROM (select * from Collection_Stage2 where company in (select Company from ELGI_Companies_Master where CompanyGroup='ATS')) a  
WHERE   convert(datetime,docdt) >= dateadd(yy,-4,getdate()-1) AND      (DocTyp IN (2, 8))


GROUP BY company, Trantyp, InvNo, CustNo, DocDt, AnpTranTyp, [LineNo]

--UNION

--SELECT     company, Trantyp, InvNo, CustNo, DocDt, SUM(AmntHome) AS amnthome, AnpTranTyp, MAX(AnpDocNo) AS anpdocno,     
--MAX(CDocNo) AS cdocno, MAX(CTranTyp) AS ctrantyp, 2 AS doctyp, [LineNo]
--FROM (select * from Collection_Stage2 where company in (select Company from ELGI_Companies_Master where CompanyGroup='ATS')) a  
--WHERE   convert(datetime,docdt) >= '04/01/2011' AND 
--(Trantyp LIKE '%R28%') AND (CTranTyp LIKE '%B28%') AND (DocTyp IN (2, 8))
--GROUP BY company, Trantyp, InvNo, CustNo, DocDt, AnpTranTyp, [LineNo]
) AS dates 
ON dates.company = acc_rec_ats.company 
AND dates.InvNo = acc_rec_ats.InvNo 
AND dates.CustNo = acc_rec_ats.CustNo 
AND dates.Trantyp = acc_rec_ats.Trantyp 
AND dates.[LineNo] = acc_rec_ats.[LineNo] 

LEFT OUTER JOIN
vw_DPST_MASTER c ON LTRIM(RTRIM(c.DpstCode)) = LTRIM(RTRIM(acc_rec_ats.dpst)) 
LEFT OUTER JOIN
vw_AREA_MASTER d ON LTRIM(RTRIM(d.AreaCode)) = LTRIM(RTRIM(acc_rec_ats.area)) 
INNER JOIN TTCCOM100400 e
ON e.t_bpid = acc_rec_ats.CustNo
     
WHERE
(dates.Trantyp NOT LIKE '%ccj%') 
AND (dates.Trantyp NOT LIKE '%ccn%') 
AND (dates.Trantyp NOT LIKE '%cdj%') 
AND (dates.Trantyp NOT LIKE '%cbc%') 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT BETWEEN '251' AND '264') 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT BETWEEN '351' AND '364') 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT BETWEEN '451' AND '464') 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT BETWEEN '551' AND '564') 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT BETWEEN '651' AND '664') 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT BETWEEN '751' AND '764') 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT BETWEEN '2A1' AND '2C6') 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT BETWEEN '3A1' AND '3C6') 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT BETWEEN '4A1' AND '4C6') 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT BETWEEN '5A1' AND '5C6') 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT BETWEEN '7A1' AND '7C6') 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT BETWEEN '8A1' AND '8C6') 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT BETWEEN '9A1' AND '9C6') 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT LIKE 'F%') 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT IN ('BCC')) 
AND (LTRIM(RTRIM(dates.Trantyp)) NOT IN ('271', '272', '371', '372', '471', '472', '571', '572', 
     '671', '672', '674', '771', '772', '871', '872', '971', '972'))
) AS test

GO

