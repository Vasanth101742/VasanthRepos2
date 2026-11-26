CREATE TABLE [dbo].[OTMA_History] (
    [Company]         NVARCHAR (5)   NULL,
    [sub_division]    NVARCHAR (50)  NULL,
    [model]           NVARCHAR (50)  NULL,
    [warehouse]       NVARCHAR (50)  NULL,
    [pdno]            NVARCHAR (50)  NULL,
    [child_item]      NVARCHAR (100) NULL,
    [Child_Item_Desc] NVARCHAR (255) NULL,
    [Lean_Type]       NVARCHAR (50)  NULL,
    [Lean_Stock_Out]  NVARCHAR (50)  NULL,
    [Lot_No]          INT            NULL,
    [Buyer_name]      NVARCHAR (200) NULL,
    [Day_Demand]      FLOAT (53)     NULL,
    [Stock]           FLOAT (53)     NULL,
    [Stock_Status_6]  NVARCHAR (100) NULL,
    [cbr_6]           NVARCHAR (10)  NULL,
    [SNo_6]           INT            NULL,
    [Status_6]        NVARCHAR (100) NULL,
    [Req_del_Date]    DATE           NULL,
    [Supplier_name]   NVARCHAR (200) NULL,
    [TPL_Code]        NVARCHAR (50)  NULL,
    [Qrdr]            FLOAT (53)     NULL,
    [redflag]         NVARCHAR (50)  NULL,
    [responsible]     VARCHAR (25)   NULL
);


GO

