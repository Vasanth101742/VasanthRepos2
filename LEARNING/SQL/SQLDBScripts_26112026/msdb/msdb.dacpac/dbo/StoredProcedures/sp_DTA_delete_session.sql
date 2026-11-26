
create procedure sp_DTA_delete_session 
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

	delete from [dbo].[DTA_input] where SessionID=@SessionID
end

GO

