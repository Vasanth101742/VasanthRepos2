

CREATE proc [dbo].[sp_DayDemandHistory] as


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


insert into DayDemandHistory (Company,sub_division,model,warehouse,pdno,child_item,Child_Item_Desc,Lean_Type,Lean_Stock_Out,
Lot_No,Buyer_name,Day_Demand,Stock,Stock_Status_6,cbr_6,SNo_6,Status_6,Req_Del_Date,Supplier_name,TPL_Code,qrdr,redflag)

SELECT Company,sub_division,model,warehouse,pdno,child_item,Child_Item_Desc,Lean_Type,Lean_Stock_Out,Lot_No,Buyer_name,Day_Demand
,Stock,Stock_Status_6,cbr_6,SNo_6,Status_6,convert(date,Req_Del_Date) 'Req_del_Date',Supplier_name,TPL_Code,qrdr,redflag

FROM daydemand 

WHERE CONVERT(DATE,Req_Del_date)=CONVERT(DATE,GETDATE())

--AND Buyer_name IN ('SATHISH N','PRAKASH M')

--alter table DayDemandHistory add UpdatedDate datetime

update DayDemandHistory set Responsible = 'Aircenter' where Supplier_name like '%ELGI EQUIPMENTS LIMITED (AIRCENTER)%' and Buyer_name like '%JAYAPAL%'

update DayDemandHistory set Responsible = 'PVD' where Supplier_name like '%ELGI EQUIPMENTS LIMITED - PVD%' and Buyer_name like '%KUPPUSAMY A%'

update DayDemandHistory set Responsible = 'MOTOR' where Supplier_name like '%ELGI EQUIPMENTS LIMITED (MOTOR DIVI%' and Buyer_name like '%ARUNPRASAD MANOHARAN%'

update DayDemandHistory set Responsible = 'Inhouse' where Supplier_name like '%ELGI EQUIPMENTS LIMITED%' and Buyer_name like '%NITHISHKUMAR K.J%'

update DayDemandHistory set Responsible = 'Inhouse' where Supplier_name like '%ELGI EQUIPMENTS LIMITED%' and Buyer_name like '%VIJAYAKUMAR S%'

update DayDemandHistory set Responsible='Materials' where responsible is null

update DayDemandHistory set UpdatedDate= getdate() where CONVERT(DATE,Req_Del_date)=CONVERT(DATE,GETDATE())

GO

