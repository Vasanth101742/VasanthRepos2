create procedure sp_DTA_get_tuningoptions
	@SessionID int 

as 
begin
	declare @retval  int							
	set nocount on

	exec @retval =  sp_DTA_check_permission @SessionID

	if @retval = 1
	begin
		raiserror(31002,-1,-1)
		return(1)
	end	

	select TuningOptions from [dbo].[DTA_input] where SessionID = @SessionID	

end

GO

