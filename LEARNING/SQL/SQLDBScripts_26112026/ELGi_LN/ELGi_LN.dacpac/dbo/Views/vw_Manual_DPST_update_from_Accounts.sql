create view vw_Manual_DPST_update_from_Accounts as
Select 'ICN' as Trantype, '34000004' as Invoice, '90033' as DPST  union
select 'CCN', '34000005', '90092' union
select 'CCN', '34000006', '90083' union
select 'CCN', '34000007', '90083' union
select 'CDN', '32000030', '90083' union
select 'ICN', '34000002', '90015' union
select 'CCN', '34000004', '90028' union
select 'CCN', '34000003', '90029'

GO

