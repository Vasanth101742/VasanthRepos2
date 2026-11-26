CREATE view [dbo].[vw_COSEA_Dealers_Master]
as
select 'COSEA' as Organ,'623' as AreaCode,'CU1C01251' as DealerCode,'C-Point' as DealerName, 'ACTIVE DISTRIBUTORS' as DealerType union
select 'COSEA' as Organ,'623' as AreaCode,'CU1P02004' as DealerCode,'Airpower systems' as DealerName, 'ACTIVE DISTRIBUTORS' as DealerType union
select 'COSEA' as Organ,'623' as AreaCode,'CUSQ00001' as DealerCode,'Q Air' as DealerName, 'ACTIVE DISTRIBUTORS' as DealerType  union
select 'COSEA','624','CU1F00001','PT Fadnov AirTech','ACTIVE DISTRIBUTORS' union
select 'COSEA','624','CU1M00009','PT Maju Langgeng mandri','ACTIVE DISTRIBUTORS' union
select 'COSEA','624','CU1M00004','PT Multi Mekanika Solution','ACTIVE DISTRIBUTORS' union
select 'COSEA','624','CU1K00002','PT Kusuma Teknik Persada','ACTIVE DISTRIBUTORS' union
select 'COSEA','624','CU1H00003','PT Himawan' ,'OTHER DISTRIBUTORS' union
select 'COSEA','624','CU1T00001','PT Teconindo' ,'OTHER DISTRIBUTORS' union
select 'COSEA','624','CU1E00004','PT Elcoblast' ,'OTHER DISTRIBUTORS' union
select 'COSEA','624','CU1T00009','PT Tjokro Varia Industris' ,'OTHER DISTRIBUTORS' union
select 'COSEA','624','CU1M00022','PT Mitraplus Filter Industris' ,'OTHER DISTRIBUTORS' union
select 'COSEA','624','CU1S00030','PT. SEKAWAN','ACTIVE DISTRIBUTORS' union
select 'COSEA','624','CU1T00010','PT. TRIGUNA KARYA NUSANTARA','ACTIVE DISTRIBUTORS'

GO

