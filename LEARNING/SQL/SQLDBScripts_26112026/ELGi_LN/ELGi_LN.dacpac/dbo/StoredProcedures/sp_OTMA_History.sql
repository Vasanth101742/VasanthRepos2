


CREATE proc [dbo].[sp_OTMA_History] as


--IF EXISTS
--    (
--        SELECT 1
--        FROM daydemand
--        WHERE CONVERT(DATE, Req_Del_Date) = CONVERT(DATE, GETDATE())
--          AND cbr_6 IS NULL
--    )
--    BEGIN
--        EXEC sp_DayDemand
--    END



--    /* Delete records older than 6 months */
--    DELETE FROM daydemandHistory
--    WHERE req_del_date < DATEADD(MONTH, -6, CAST(GETDATE() AS DATE))


--    /* Delete today's existing records before inserting again */
--    DELETE FROM daydemandHistory
--    WHERE req_del_date = CONVERT(DATE, GETDATE())
--      AND Buyer_name IN ('SATHISH N', 'PRAKASH M')


--delete from  daydemandHistory where req_del_date < DATEADD(MONTH, -6, CAST(GETDATE() AS DATE))

--delete from  daydemandHistory where req_del_date = convert(date,getdate())

--alter table DayDemandHistory add redflag Nvarchar(50)


insert into OTMA_History (Company,sub_division,model,warehouse,pdno,child_item,Child_Item_Desc,Lean_Type,Lean_Stock_Out,
Lot_No,Buyer_name,Day_Demand,Stock,Stock_Status_6,cbr_6,SNo_6,Status_6,Req_Del_Date,Supplier_name,TPL_Code,qrdr,redflag,responsible)

SELECT Company,sub_division,model,warehouse,pdno,child_item,Child_Item_Desc,Lean_Type,Lean_Stock_Out,Lot_No,Buyer_name,Day_Demand
,Stock,Stock_Status_6,cbr_6,SNo_6,Status_6,convert(date,Req_Del_Date) 'Req_del_Date',Supplier_name,TPL_Code,qrdr,redflag,responsible

FROM daydemand 

WHERE CONVERT(DATE,Req_Del_date)=CONVERT(DATE,GETDATE())

--AND Buyer_name IN ('SATHISH N','PRAKASH M')

GO

