CREATE procedure [dbo].[sp_EU_BPDetails] (
@Busines_Partner nvarchar(250),
@Parental_Company_Name nvarchar(255),
@Region nvarchar(200),
@Country nvarchar(255),
@ASM_Name nvarchar(250)
) as

begin 
set NOCOUNT on 


insert into EU_BPDetails (
Busines_Partner,
PARENTAL_COMPANY_NAME,
Region,
Country,
ASM_NAME
)
values (
@Busines_Partner,
@Parental_Company_Name,
@Region,
@Country,
@asm_name

)

update EU_BPDetails set UpdatedDate =getdate()


end

GO

