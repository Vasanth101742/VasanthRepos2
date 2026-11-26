
CREATE  PROC [dbo].[SP_HOURLY_BILLING]
AS 
BEGIN
declare @fromdate as date 

set @fromdate ='20250331'

truncate table HOURLY_BILLING

	
INSERT INTO HOURLY_BILLING (GRP) VALUES ('EXPORTS')

INSERT INTO HOURLY_BILLING (DPST,TYPE,GRP) VALUES 
(90001,'RCD','SPARES'),
(90015,'RCD','SPARES'),
(90032,'RoCD','SPARES'),
(90034,'RoCD','SPARES'),
(90038,'RoCD','SPARES'),
(90063,'RoCD','SPARES'),
(90078,'RoCD','SPARES'),

(90013,'RCD','SPARES'),
(90031,'ROCD','SPARES'),
(90076,'DPSAC','SPARES'),
(90039,'KIT','SPARES'),
(90082,'EPSAC','SPARES'),
(90083,'CAC','SPARES'),
(90084,'OFSAC','SPARES'),

(90092,'RLY','RAILWAY'),
(90095,'RLY','RAILWAY'),

(90028,'ROCD','GSC-OIL'),
(90077,'DPSAC','GSC-OIL'),
(90075,'RCD','GSC-OIL'),

(90028,'ROCD','SANAND'),
(90077,'DPSAC','SANAND'),
(90075,'RCD','SANAND')


UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90013') and AMTH$1 >0 and b.[TRAN] in ('412','432') and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90013)

	UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 	AND COFC IN ('90031')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90031)

	UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90076')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90076)

	UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90039')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90039)

	UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90082')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90082)

	UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90092)

	UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90028')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90077')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90077)AND GRP ='GSC-OIL'

	UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90075')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP ='GSC-OIL'

	UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90083')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90083)


	UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90084')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90084)
 
		UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90001')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90001)


			UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90015')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90015)


			UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90032')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90032)


			UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90034')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90034)


			UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90038')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90038)


			UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90063')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90063)

				UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90078')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90078)

					UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90095')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90095)

	---END FTD
	
		------------ START MTD
	
	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90013')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90013)

	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90031')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90031)

	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90076')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90076)

	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90039')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90039)

	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90082')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90082)

	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90092)

	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90001')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90001)


	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90015')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90015)


	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90032')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90032)


	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90034')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90034)


	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90038')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90038)


	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90063')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90063)


	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90095')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90095)



	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90028')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP ='GSC-OIL'




	UPDATE HOURLY_BILLING SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90077')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90077)AND GRP ='GSC-OIL'

	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90075')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP ='GSC-OIL'

	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90083')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90083)


	
	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90084')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90084)


------------- END MTD

		------------ START YTD
	
UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90013')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90013)

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90031')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90031)

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90076')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90076)

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90039')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90039)

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90082')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90082)

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90092)

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90028')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP ='GSC-OIL'

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90077')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90077)AND GRP ='GSC-OIL'

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90075')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP ='GSC-OIL'

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90083')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90083)

	
	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90084')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90084)

	
	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90082')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90082)

		UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90001')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90001)

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90015')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90015)

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90032')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90032)

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90034')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90034)

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90038')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90038)

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90063')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90063)

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90078')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90078)

	UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90095')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90095)

	
	-------------------END YTD

	----------------------------------start hourly billing

		UPDATE HOURLY_BILLING  SET [7-8]=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90001')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90001)

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90001')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90001)

	UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90001')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90001)

	UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90001')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90001)


			UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90001')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90001)

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90001')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90001)

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90001')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90001)


			UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90001')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90001)


	UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90001')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90001)


	UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90001')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90001)


	UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90001')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90001)

		UPDATE HOURLY_BILLING  SET [7-8]=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90015')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90015)

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90015')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90015)

	UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90015')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90015)

	UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90015')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90015)


			UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90015')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90015)

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90015')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90015)

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90015')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90015)


			UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90015')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90015)


	UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90015')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90015)


	UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90015')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90015)


	UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90015')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90015)



	UPDATE HOURLY_BILLING  SET [7-8]=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90032')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90032)

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90032')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90032)

	UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90032')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90032)

	UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90032')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90032)


			UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90032')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90032)

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90032')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90032)

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90032')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90032)


			UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90032')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90032)


	UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90032')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90032)


	UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90032')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90032)


	UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90032')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90032)


	UPDATE HOURLY_BILLING  SET [7-8]=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90034')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90034)

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90034')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90034)

	UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90034')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90034)

	UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90034')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90034)


			UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90034')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90034)

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90034')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90034)

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90034')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90034)


			UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90034')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90034)


	UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90034')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90034)


	UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90034')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90034)


	UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90034')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90034)


	UPDATE HOURLY_BILLING  SET [7-8]=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90038')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90038)

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90038')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90038)

	UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90038')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90038)

	UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90038')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90038)


			UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90038')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90038)

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90038')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90038)

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90038')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90038)


			UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90038')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90038)


	UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90038')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90038)


	UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90038')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90038)


	UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90038')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90038)


	UPDATE HOURLY_BILLING  SET [7-8]=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90063')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90063)

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90063')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90063)

	UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90063')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90063)

	UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90063')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90063)


			UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90063')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90063)

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90063')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90063)

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90063')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90063)


			UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90063')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90063)


	UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90063')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90063)


	UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90063')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90063)


	UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90063')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90063)


	UPDATE HOURLY_BILLING  SET [7-8]=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90078')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90078)

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90078')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90078)

	UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90078')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90078)

	UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90078')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90078)


			UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90078')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90078)

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90078')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90078)

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90078')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90078)


			UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90078')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90078)


	UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90078')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90078)


	UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90078')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90078)


	UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90078')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90078)

		UPDATE HOURLY_BILLING  SET [7-8]=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90095')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90095)

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90095')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90095)

	UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90095')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90095)

	UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90095')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90095)


			UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90095')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90095)

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90095')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90095)

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90095')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90095)


			UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90095')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90095)


	UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90095')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90095)


	UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90095')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90095)


	UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90095')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90095)



	---------------- end

	UPDATE HOURLY_BILLING  SET [7-8]=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90013')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90013)

	UPDATE HOURLY_BILLING  SET [7-8]=	VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90031')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90031)

	UPDATE HOURLY_BILLING  SET [7-8]=	VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90076')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90076)

	UPDATE HOURLY_BILLING  SET [7-8]=	VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90039')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90039)

	UPDATE HOURLY_BILLING  SET [7-8]=	VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90082')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90082)

	UPDATE HOURLY_BILLING  SET [7-8]=	VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90092)

	UPDATE HOURLY_BILLING  SET [7-8]=	VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP ='GSC-OIL'

	UPDATE HOURLY_BILLING  SET [7-8]=	VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	
	WHERE HOURLY_BILLING.DPST IN (90077)AND GRP ='GSC-OIL'

	UPDATE HOURLY_BILLING  SET [7-8]=	VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP ='GSC-OIL'

	UPDATE HOURLY_BILLING  SET [7-8]=	VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90083')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90083)

	
	UPDATE HOURLY_BILLING  SET [7-8]=	VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90084')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90084)

	------------
	
	UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90013')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90013)

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90031')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90031)
		
		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90076')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90076)

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90039')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90039)

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90082')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90082)

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90092)

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90077)AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90083')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90083)

		UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90084')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90084)
-------------------
UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90013')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90013)

		UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90031')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90031)

		UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90076')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90076)

		UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90039')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90039)

		UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90082')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90082)

		UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90092)

		UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	
	WHERE HOURLY_BILLING.DPST IN (90077)AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90083')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90083)

		UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90084')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90084)

------------------------
	UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90013')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90013)

		UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90031')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90031)

		UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90076')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90076)

		UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90039')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90039)

		UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90082')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90082)

		UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90092)

		UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	
	WHERE HOURLY_BILLING.DPST IN (90077)AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90083')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90083)

		UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90084')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90084)
	---------------
		UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90013')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90013)

		UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90031')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90031)

		UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90076')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90076)

		UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90039')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90039)

		UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90082')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90082)

		UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90092)

		UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP ='GSC-OIL'

			UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90077)AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90083')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90083)

		UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90084')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90084)
--------------------------
	UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90013')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90013)

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90031')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90031)

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90076')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90076)

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90039')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90039)

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90082')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90082)

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90092)

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90077)AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90083')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90083)

		UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90084')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90084)
------------------

	UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90013')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90013)

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90031')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90031)

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90076')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90076)

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90039')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90039)

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90082')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90082)

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90092)

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	
	WHERE HOURLY_BILLING.DPST IN (90077)AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90083')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90083)

		UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90084')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90084)
	-----------------
		UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90013')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90013)

		UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90031')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90031)

		UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90076')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90076)

		UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90039')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90039)

		UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90082')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90082)

		UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90092)

		UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90077)AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90083')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90083)

		UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90084')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90084)
-------------
	UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90013')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90013)

		UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90031')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90031)

		UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90076')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90076)

		UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90039')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90039)

		UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90082')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90082)

		UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90092)

		UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90077)AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90083')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90083)


		UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90084')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90084)
	-------------------
		UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90013')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90013)

		UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90031')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90031)

		UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90076')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90076)

		UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90039')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90039)

		UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90082')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90082)

		UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90092)

		UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	
	WHERE HOURLY_BILLING.DPST IN (90077)AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90083')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90083)


		UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90084')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90084)
	----------------
		UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90013')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90013)

		UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90031')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90031)

		UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90076')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90076)

		UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90039')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A 	WHERE HOURLY_BILLING.DPST IN (90039)

		UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90082')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90082)

		UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90092)

		UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90077)AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP ='GSC-OIL'

		UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90083')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90083)

		UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90084')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A	WHERE HOURLY_BILLING.DPST IN (90084)

	-------------------- EXPORTS

	UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND (COFC NOT BETWEEN '90000' AND '90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.GRP IN ('EXPORTS')
	
UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND (COFC NOT BETWEEN '90000' AND '90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.GRP IN ('EXPORTS')
	
UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND (COFC NOT BETWEEN '90000' AND '90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.GRP IN ('EXPORTS')
	
	UPDATE HOURLY_BILLING  SET [7-8]=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND (COFC NOT BETWEEN '90000' AND '90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.GRP IN ('EXPORTS')
	
	UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND (COFC NOT BETWEEN '90000' AND '90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
			WHERE HOURLY_BILLING.GRP IN ('EXPORTS')
		
UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND (COFC NOT BETWEEN '90000' AND '90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
				WHERE HOURLY_BILLING.GRP IN ('EXPORTS')
		
	UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
			AND (COFC NOT BETWEEN '90000' AND '90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
	WHERE HOURLY_BILLING.GRP IN ('EXPORTS')
		
	UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND (COFC NOT BETWEEN '90000' AND '90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
				WHERE HOURLY_BILLING.GRP IN ('EXPORTS')

UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND (COFC NOT BETWEEN '90000' AND '90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
				WHERE HOURLY_BILLING.GRP IN ('EXPORTS')

	UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
		AND (COFC NOT BETWEEN '90000' AND '90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
		WHERE HOURLY_BILLING.GRP IN ('EXPORTS')
		
	UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
		AND (COFC NOT BETWEEN '90000' AND '90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
		WHERE HOURLY_BILLING.GRP IN ('EXPORTS')

		UPDATE HOURLY_BILLING SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
			AND (COFC NOT BETWEEN '90000' AND '90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
 		WHERE HOURLY_BILLING.GRP IN ('EXPORTS')
		
	UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
			AND (COFC NOT BETWEEN '90000' AND '90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
		WHERE HOURLY_BILLING.GRP IN ('EXPORTS')
		
	UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305490 where convert(date,IDAT) >@fromdate) a
	inner join TCISLI310490 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and sotp not in ('226','236','246','270','284','326','332','346','384','516','544','526','546','FCA','FC9','FCT') 
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
		AND (COFC NOT BETWEEN '90000' AND '90092')and AMTH$1 >0 and b.[TRAN] in ('412','432'))A
		WHERE HOURLY_BILLING.GRP IN ('EXPORTS')
		
	----------------- END EXPORTS
	----SANAND

	UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305416 WHERE [TRAN]='A12') a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90028')and AMTH$1 >0)A
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP='SANAND'

	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305416 WHERE [TRAN]='A12') a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90028')and AMTH$1 >0)A
	WHERE HOURLY_BILLING.DPST IN (90028)AND GRP='SANAND'


UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305416 WHERE [TRAN]='A12') a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90028')and AMTH$1 >0)A
	WHERE HOURLY_BILLING.DPST IN (90028) AND GRP='SANAND'



		UPDATE HOURLY_BILLING  SET [7-8]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90028) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90028) AND GRP='SANAND'

	UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90028) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90028) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90028) AND GRP='SANAND'

	UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90028) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90028) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90028) AND GRP='SANAND'

	UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90028) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90028) AND GRP='SANAND'
	
UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90028')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90028) AND GRP='SANAND'


	----------
	
	UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305416 WHERE [TRAN]='A12') a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90075')and AMTH$1 >0 )A
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP='SANAND'

	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305416 WHERE [TRAN]='A12') a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90075')and AMTH$1 >0)A
	WHERE HOURLY_BILLING.DPST IN (90075)AND GRP='SANAND'


UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305416 WHERE [TRAN]='A12') a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90075')and AMTH$1 >0 )A
	WHERE HOURLY_BILLING.DPST IN (90075) AND GRP='SANAND'



		UPDATE HOURLY_BILLING  SET [7-8]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90075) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90075) AND GRP='SANAND'

	UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90075) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90075) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90075) AND GRP='SANAND'

	UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90075) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90075) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90075) AND GRP='SANAND'

	UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90075) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90075) AND GRP='SANAND'
	
UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90075')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90075) AND GRP='SANAND'

---------


	UPDATE HOURLY_BILLING  SET FTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305416 WHERE [TRAN]='A12') a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	 and convert(Date,dateadd(hh,5,IDAT))=CONVERT(DATE,GETDATE()) 
	AND COFC IN ('90077')and AMTH$1 >0)A
	WHERE HOURLY_BILLING.DPST IN (90077) AND GRP='SANAND'

	UPDATE HOURLY_BILLING  SET MTD=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305416 WHERE [TRAN]='A12') a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and convert(Date,dateadd(hh,5,IDAT)) BETWEEN (CONVERT(DATE,DATEADD(DD,-DAY(GETDATE()-1),GETDATE()))) AND (CONVERT(DATE,GETDATE()-1))
	AND COFC IN ('90077')and AMTH$1 >0)A
	WHERE HOURLY_BILLING.DPST IN (90077)AND GRP='SANAND'


UPDATE HOURLY_BILLING  SET YTD=		VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From TCISLI305416 WHERE [TRAN]='A12') a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and convert(Date,dateadd(hh,5,IDAT))>='2018-04-01'
	AND COFC IN ('90077')and AMTH$1 >0)A
	WHERE HOURLY_BILLING.DPST IN (90077) AND GRP='SANAND'



		UPDATE HOURLY_BILLING  SET [7-8]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 01:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 07:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90077) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [8-9]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and dateadd(hh,5,IDAT) 	BETWEEN convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 08:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90077) AND GRP='SANAND'

	UPDATE HOURLY_BILLING  SET [9-10]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
	and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 09:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90077) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [10-11]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 10:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90077) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [11-12]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 11:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90077) AND GRP='SANAND'

	UPDATE HOURLY_BILLING  SET [12-13]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 12:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90077) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [13-14]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 13:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90077) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [14-15]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 14:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90077) AND GRP='SANAND'

	UPDATE HOURLY_BILLING  SET [15-16]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 15:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90077) AND GRP='SANAND'
	
	UPDATE HOURLY_BILLING  SET [16-17]=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 16:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90077) AND GRP='SANAND'
	
UPDATE HOURLY_BILLING  SET AFTER_17=VAL FROM (	select round(sum(b.AMTH$1/1000000),2)as VAL from(select IDAT,[TRAN],IDOC From  TCISLI305416 WHERE [TRAN]='A12')a
	inner join TCISLI310416 b
	on ltrim(rtrim(a.[TRAN]))=ltrim(rtrim(b.[TRAN]))
	and ltrim(rtrim(a.IDOC))=ltrim(rtrim(b.IDOC))  
 and dateadd(hh,5,IDAT) 	BETWEEN	convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 17:00:00.000')) AND convert(datetime,CONCAT(CONVERT(DATE,GETDATE()),' 23:59:59.000'))
	AND COFC IN ('90077')and AMTH$1 >0)A 	 WHERE HOURLY_BILLING.DPST IN (90077) AND GRP='SANAND'



	--   SELECT *  fROM HOURLY_BILLING 
	
	END

GO

