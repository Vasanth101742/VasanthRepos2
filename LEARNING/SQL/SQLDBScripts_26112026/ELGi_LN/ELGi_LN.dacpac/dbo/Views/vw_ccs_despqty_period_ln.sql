CREATE VIEW[dbo].[vw_ccs_despqty_period_ln] as 

select product1 as product,a.cat,multi_month,sum(desptqty) as desptqty from (
select * from (
select product,cat,multi_month,sum(isnull(despqty,0))as desptqty from (
select a.*,cat,warrantyperiod as wi_period from ccs_rca_Desp_data_ln a, ccs_warranty_ref_Ln b
where a.product = b.product)a, (select distinct month as multi_month from ccs_rca_Desp_data_ln  )b
where  convert(datetime,month) between dateadd(mm, 1-wi_period,convert(datetime,multi_month)) and   convert(datetime,multi_month)
group by product,cat,multi_month)a
where multi_month between (select min(month) as multi_month from ccs_rca_Desp_data_ln ) and (select max(month) as multi_month from ccs_rca_Desp_data_ln))a
inner join (select * from ccs_warranty_ref_Ln)b
on a.product = b.product
group by product1, a.cat,multi_month

GO

