create procedure sp_DTA_insert_output_recommendation
	@SessionID int,
	@Recommendation nvarchar(max)
as 
begin
	declare @retval  int
	set nocount on

	exec @retval = sp_DTA_check_permission @SessionID

	if @retval = 1
	begin
		raiserror(31002,-1,-1)
		return(1)
	end
	
	Insert into [dbo].[DTA_output_recommendation]([SessionID], [Recommendation]) values(@SessionID, @Recommendation)
end

GO

