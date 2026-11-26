create procedure [dbo].[truncateTable1] @tablename nvarchar(50) as
begin 
set nocount on

if exists(
select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME=@tablename and TABLE_TYPE='Base table'
)

begin 
declare @sql nvarchar(100)
set @sql='Truncate table' +QUOTENAME(@tablename)
begin try 
exec sp_executesql @sql
select 'Table['+@tablename+'] truncated successfully' as message
end try 
begin catch 
select ERROR_MESSAGE() as errorMessage
end catch 
end
else 
begin
select 'The specified table'+@tablename+ 'does not exists'  as Errormessage
end
end

GO

