CREATE TABLE [dbo].[daydemand_temp_M5] (
    [sub_division]         NVARCHAR (40)  NULL,
    [sub_division_sorting] INT            NULL,
    [pdno]                 NVARCHAR (100) NULL,
    [tpl_code]             NVARCHAR (50)  NULL,
    [child_item]           NVARCHAR (150) NULL,
    [Req_del_date]         DATETIME       NULL,
    [stock]                FLOAT (53)     NULL,
    [bom_qty]              FLOAT (53)     NULL,
    [Shortage_Items_Count] INT            NULL,
    [SNO]                  INT            NULL,
    [stock_status]         NVARCHAR (50)  NULL,
    [CBR]                  NVARCHAR (50)  NULL,
    [status]               NVARCHAR (50)  NULL,
    [Child_Item_Desc]      NVARCHAR (250) NULL,
    [Company]              NVARCHAR (250) NULL
);


GO

