CREATE TABLE [dbo].[price_Amenment] (
    [Date]      DATE           NULL,
    [COMPANY]   NVARCHAR (38)  NULL,
    [Custcode]  NVARCHAR (18)  NULL,
    [Custname]  NVARCHAR (70)  NULL,
    [T$ITEM]    NVARCHAR (94)  NULL,
    [Old_orno]  NVARCHAR (18)  NULL,
    [Old_pono]  NVARCHAR (38)  NULL,
    [Old_seq]   NVARCHAR (38)  NULL,
    [old_qty]   NVARCHAR (38)  NULL,
    [old_pric]  NVARCHAR (38)  NULL,
    [T$NORNO]   NVARCHAR (18)  NULL,
    [T$NPONO]   NVARCHAR (38)  NULL,
    [New_qty]   NVARCHAR (38)  NULL,
    [New_pric]  NVARCHAR (38)  NULL,
    [T$HSNC]    NVARCHAR (38)  NULL,
    [T$GSTIN]   NVARCHAR (70)  NULL,
    [T$REM1]    NVARCHAR (200) NULL,
    [T$REMK]    NVARCHAR (200) NULL,
    [comp_new]  INT            NULL,
    [item_desc] NVARCHAR (60)  NULL
);


GO

