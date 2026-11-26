CREATE VIEW [dbo].[vw_collection_GL_receipts_ATS]
AS
SELECT company, Trantyp, InvNo, CustNo, ABS(AmntHome) AS gl_receipt, DocDt, 
90111 AS dpst, '051' AS area, CTranTyp, CDocNo, AnpTranTyp, AnpDocNo,DocTyp
FROM (select * from Collection_Stage2 where company in (select Company from ELGI_Companies_Master where CompanyGroup='ATS')) a  

WHERE (Trantyp = 'BCD') 
AND (CONVERT(datetime, DocDt) >= '04/01/2008') 
AND (CONVERT(datetime, DocDt) >= DATEADD(mm, - 2, CONVERT(varchar,DATEPART(mm, GETDATE())) + '/01/' + DATENAME(yy, GETDATE()))) 
AND (CLineNo = 1)

GO

