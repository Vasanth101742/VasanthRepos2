create view vw_ATS_Workshop_Categories as
select 'NEW' as WorkshopType,'Package' as WS_Category union
select 'NWS','Package' union
select 'NMS','Package' union
select 'NBS','Package' union
select 'NEO','Package' union
select 'OEN','Package' union
select 'EWS','Topup' union
select 'OLD','Topup' union
select 'OEE','Topup' union
select 'OTH','Topup' union
select '-','Topup'

GO

