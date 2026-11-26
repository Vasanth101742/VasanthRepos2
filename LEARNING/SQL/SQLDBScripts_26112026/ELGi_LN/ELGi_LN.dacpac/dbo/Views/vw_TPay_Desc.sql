create view [dbo].[vw_TPay_Desc] as
select 1 as Tpay,'Purchase Invoice' as TpayDesc union
select 2 as Tpay,'Normal Payment' as TpayDesc union
select 3 as Tpay,'Sales Invoice' as TpayDesc union
select 4 as Tpay,'Credit Note' as TpayDesc union
select 5 as Tpay,'Correction' as TpayDesc union
select 6 as Tpay,'Currency Difference' as TpayDesc union
select 7 as Tpay,'Payment Difference' as TpayDesc union
select 8 as Tpay,'Anticipated Payment' as TpayDesc union
select 9 as Tpay,'Advance Payment' as TpayDesc union
select 10 as Tpay,'Unallocated Payment' as TpayDesc union
select 11 as Tpay,'Advance Anticipated' as TpayDesc union
select 12 as Tpay,'Unallocated Anticipated' as TpayDesc union
select 13 as Tpay,'Standing Order' as TpayDesc union
select 14 as Tpay,'Assignment' as TpayDesc union
select 15 as Tpay,'Trade Notes' as TpayDesc union
select 16 as Tpay,'Cash Journal' as TpayDesc

GO

