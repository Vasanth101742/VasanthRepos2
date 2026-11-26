create view [dbo].[vw_FinCustGrp] as 
select '1' as FinCustGrpCode,'Customer-Private Sector' as FinCustGrpName union
select '2' as FinCustGrpCode,'Customer-Government Sector' as FinCustGrpName union
select '3' as FinCustGrpCode,'Customer-PSU' as FinCustGrpName union
select '4' as FinCustGrpCode,'Customer-Customer Export' as FinCustGrpName union
select '5' as FinCustGrpCode,'Customer-Government Sector Export' as FinCustGrpName union
select '6' as FinCustGrpCode,'Branches/Elgi depots/Factories' as FinCustGrpName union
select '7' as FinCustGrpCode,'Customer-ELGI SUBSIDIARY' as FinCustGrpName union
select '8' as FinCustGrpCode,'Customer-ELGI Dealers' as FinCustGrpName union
select '9' as FinCustGrpCode,'Customer-ELGI Dealers Export' as FinCustGrpName union
select '10' as FinCustGrpCode,'Customer-OE' as FinCustGrpName union
select '11' as FinCustGrpCode,'Nill' as FinCustGrpName

GO

