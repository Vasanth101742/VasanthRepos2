
--@AssemblyLine as Varchar(50),
CREATE function [dbo].[UFN_TentativeClosingPlan]
(
@ReleaseDate date,
@DaysToAdd int
)
returns date
as
begin
	declare @ResultDate date
	--declare @Date date=convert(date,getdate())

	select @ResultDate=ALCDate --,@Date,datepart(dw,@Date)  
     From (
           select Date as ALCDate,ROW_NUMBER()over(order by date asc) as rno  From TTCCCP020400

           where ccal='COMPANY' and DFCA =1 and convert(date,DATE)  > @ReleaseDate
		   )a
         where rno=@DaysToAdd

return @ResultDate  
END

GO

