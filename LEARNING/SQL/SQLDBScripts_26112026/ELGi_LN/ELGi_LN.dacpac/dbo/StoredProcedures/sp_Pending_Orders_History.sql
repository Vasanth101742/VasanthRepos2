Create PROCEDURE sp_Pending_Orders_History as 
begin 
IF DAY(CONVERT(DATE,GETDATE()))=1
	begin
      insert into Pending_Orders_History 
      select *,getdate() 'UpdatedDate' from pending_orders
	end
end

GO

