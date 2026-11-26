create view [dbo].[vw_Sales_Classification_Australia] as
select 1 as id, 'Industrials' as Category,'DEALERS' as CustType,'Units' as vertical1 union
select 1,'Industrials','DEALERS','AM' union
select 1,'Industrials','IAC','Units' union
select 1,'Industrials','IAC','AM' union
select 1,'Portables','DEALERS','Units' union
select 1,'Portables','DEALERS','AM' union
select 1,'Portables','IAC','Units' union
select 1,'Portables','IAC','AM'

GO

