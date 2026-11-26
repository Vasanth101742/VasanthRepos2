CREATE PROC [dbo].[spak_insert_main_table] @dl_id [nvarchar](200),@dl_document_indexed_date [datetime],@dl_document_name [nvarchar](200),@dl_instance_count [int],@Count [int] AS    
begin    


DECLARE @Date DATETIME;
SET @Date = GETDATE();
    
if exists(select dl_doc from mastertable where dl_doc = @dl_document_name and Dl_id = @dl_id and csta = 'Success!!!' and bsta = 'Success!!!' and CAST(Dl_date as date) = CAST(@dl_document_indexed_date as date))    
begin    
 select 1    
end    
else    
begin    
 If Not Exists(select * from mastertable where dl_id= @dl_id)      
 begin     
  insert into mastertable(dl_date,dl_id,dl_doc,dl_cnt,insert_date,sequence)     
  values (@dl_document_indexed_date,@dl_id,@dl_document_name,@dl_instance_count,@Date,@Count)      
 end     
 select 0    
end    
end

GO

