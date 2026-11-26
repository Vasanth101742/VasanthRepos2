
CREATE procedure [dbo].[sp_wmwhse1_ELGILPNDETAIL]
As Begin

Truncate table wmwhse1_ELGILPNDETAIL
truncate table WMS_PackStatus_Orderline

Insert into wmwhse1_ELGILPNDETAIL
 
select * from [dbo].[WMWHSE1_CODELKUP] as wmslocation
where DESCRIPTION like '%pack order%' 
and isnull(EXT_UDF_STR5,'')<>''
and EXT_UDF_STR2 like '%SHO%'


insert into WMS_PackStatus_Orderline

select distinct SALESORDERDOCUMENT,SALESORDERLINE,SKU,SHIPPEDQTY,convert(date,a.EXT_UDF_DATE1) as Hpkcompldate from [WMWHSE1_ORDERS] a
left join WMWHSE1_ORDERDETAIL b on b.ORDERKEY=a.ORDERKEY
where isnull(SALESORDERDOCUMENT,'')<>''


END

GO

