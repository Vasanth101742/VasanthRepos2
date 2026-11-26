CREATE procedure [dbo].[sp_elgi_area_access_backup] as

Truncate table elgi_Area_Access_backup 

Truncate table elgi_DPST_access_backup

--alter table elgi_Area_Access_backup add UpdatedDate datetime

insert into elgi_area_access_backup (userid,area) select * from elgi_area_access

update Elgi_Area_Access_backup set UpdatedDate=getdate()

--alter table elgi_dpst_Access_backup add UpdatedDate datetime


insert into elgi_DPST_access_backup (userid,DPST) select * from ELGI_DPST_ACCESS

update elgi_DPST_access_backup set UpdatedDate=getdate()

GO

