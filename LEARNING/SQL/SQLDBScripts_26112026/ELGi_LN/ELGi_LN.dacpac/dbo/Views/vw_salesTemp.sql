CREATE view [dbo].[vw_salesTemp] as
select company,trantype,Invoice from elgi_sales_details
where month(Invoice_Date)=5 and year(Invoice_Date)=2018

GO

