-- =============================================
-- Author:		Raviprasath
-- Create date: 03/07/2025
-- Description:	Monthly data from ELGi_OverDue_Triggers
-- =============================================
CREATE PROCEDURE [dbo].[sp_ELGi_OverDue_Triggers_History]

AS
BEGIN

--IF CONVERT(DATE, GETDATE()) =   DATEADD(DAY, 1, EOMONTH(GETDATE(), -1))
--BEGIN
--    DELETE FROM ELGi_OverDue_Triggers_History
--    WHERE CurrentDate >=  DATEADD(DAY, 1, EOMONTH(GETDATE(), -2))
--      AND CurrentDate <=  EOMONTH(GETDATE(), -1);
--END


IF
--CONVERT(DATE, GETDATE()) =  EOMONTH(GETDATE()) and
GETDATE() < DATEADD(HOUR, 16, CAST(CAST(GETDATE() AS DATE) AS DATETIME))
BEGIN
DELETE FROM ELGi_OverDue_Triggers_History_Avg Where CurrentMonth =  FORMAT(GETDATE(), 'MMM-yyyy')
Insert  ELGi_OverDue_Triggers_History_Avg
Select  empname,TriggerType,Round(CAST(Count1 AS float)/Count2,0)'Average',Format(Getdate(),'MMM-yyyy')'CurrentMonth' from (
Select empname, TriggerType , count(ltrim(rtrim(ITEM)))'Count1',DAY(GETDATE())'Count2' 
 from ELGi_OverDue_Triggers_History
Where DueType = 'Over Due' 
Group BY empname, TriggerType
)R1
Group BY empname,TriggerType,Count1,Count2
END


--Delete from ELGi_OverDue_Triggers_History Where CONVERT(DATE, CurrentDate) = CONVERT(DATE, GETDATE()) 
-->If there is mismatch in Today execute this query
--alter table ELGi_OverDue_Triggers_History  add ProjectCode nvarchar(250)

IF NOT EXISTS (
    SELECT 1 
    FROM ELGi_OverDue_Triggers_History 
    WHERE CONVERT(DATE, CurrentDate) = CONVERT(DATE, GETDATE())
)
BEGIN
    INSERT INTO ELGi_OverDue_Triggers_History (company,LOT_NO,orno,ITEM,Description,Tri_Dt,RPLT,duedate,TYPE,binqty,sceduledqty
		,DIVI,SUPERMARKET,DEPT,DEPARTMENT,SupplierNum,NAMA,BUYR,empname,TYPE_DESC,PendingDays,TriggerType,LGSC,DueTypeOrdr,DueType
		,DueSlabOrdr,DueSlab,OverDueCounts,TypeOrder,PendingQty,Revision,Category,
		VARI,VARI_Order,redflag,cwar,projectcode,CurrentDate)
    SELECT *, GETDATE() AS CurrentDate 
    FROM ELGi_OverDue_Triggers;
END


END


IF GETDATE() < DATEADD(HOUR, 16, CAST(CAST(GETDATE() AS DATE) AS DATETIME))
BEGIN


    DECLARE @count_history INT = (
        SELECT COUNT(*) 
        FROM ELGi_OverDue_Triggers_History 
        WHERE CAST(CurrentDate AS DATE) = Convert(date,Getdate())
    );

    DECLARE @count_current INT = (
        SELECT COUNT(*) 
        FROM ELGi_OverDue_Triggers 
    );

    IF @count_history <> @count_current
    BEGIN
        DELETE FROM ELGi_OverDue_Triggers_History 
        WHERE CAST(CurrentDate AS DATE) =  Convert(date,Getdate())

        INSERT INTO ELGi_OverDue_Triggers_History (company,LOT_NO,orno,ITEM,Description,Tri_Dt,RPLT,duedate,TYPE,binqty,sceduledqty
		,DIVI,SUPERMARKET,DEPT,DEPARTMENT,SupplierNum,NAMA,BUYR,empname,TYPE_DESC,PendingDays,TriggerType,LGSC,DueTypeOrdr,DueType
		,DueSlabOrdr,DueSlab,OverDueCounts,TypeOrder,PendingQty,Revision,Category,
		VARI,VARI_Order,redflag,cwar,projectcode,CurrentDate)
        SELECT *, GETDATE() AS CurrentDate 
        FROM ELGi_OverDue_Triggers;
    END
END





--alter table ELGi_OverDue_Triggers_History add RedFlag nvarchar(50)

GO

