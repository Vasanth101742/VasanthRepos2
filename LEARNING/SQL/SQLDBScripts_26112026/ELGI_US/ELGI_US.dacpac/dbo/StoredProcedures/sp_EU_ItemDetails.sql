create procedure [dbo].[sp_EU_ItemDetails] (
@ItemCode NVARCHAR(MAX),
@Product_Type NVARCHAR(MAX),
@Price_Groups NVARCHAR(MAX),
@Product_line NVARCHAR(MAX),
@Product_Line_II NVARCHAR(MAX),
@Product_line_III NVARCHAR(MAX),
@Product_line_IV_Prouct_Type NVARCHAR(MAX),
@Type NVARCHAR(MAX),
@Frame NVARCHAR(MAX),
@KW NVARCHAR(MAX),
@Pressure NVARCHAR(MAX),
@VFD NVARCHAR(MAX),
@Voltage NVARCHAR(MAX),
@Version NVARCHAR(MAX),
@T_TD NVARCHAR(MAX),
@Tank_Size NVARCHAR(MAX),
@Label_TPL NVARCHAR(MAX),
@Premium NVARCHAR(MAX),
@BIN_Non_BIN NVARCHAR(MAX)
) as

begin 
set NOCOUNT on 



INSERT INTO [dbo].[EU_ItemDetails]
([ItemCode]
           ,[Product_Type]
           ,[Price_Groups]
           ,[Product_line]
           ,[Product_Line_II]
           ,[Product_line_III]
           ,[Product_line_IV_Prouct_Type]
           ,[Type]
           ,[Frame]
           ,[KW]
           ,[Pressure]
           ,[VFD]
           ,[Voltage]
           ,[Version]
           ,[T_TD]
           ,[Tank_Size]
           ,[Label_TPL]
           ,[Premium]
           ,[BIN_Non_BIN])
values (
@ItemCode ,
@Product_Type ,
@Price_Groups ,
@Product_line ,
@Product_Line_II ,
@Product_line_III ,
@Product_line_IV_Prouct_Type ,
@Type ,
@Frame ,
@KW ,
@Pressure ,
@VFD ,
@Voltage ,
@Version ,
@T_TD ,
@Tank_Size ,
@Label_TPL ,
@Premium ,
@BIN_Non_BIN 

)

update [EU_ItemDetails] set UpdatedDate =getdate()


end

GO

