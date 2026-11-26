CREATE TABLE [dbo].[cost_data] (
    [itemselected]     NVARCHAR (255) NULL,
    [desc]             NVARCHAR (255) NULL,
    [main_item]        NVARCHAR (255) NULL,
    [mainitmdesc]      NVARCHAR (255) NULL,
    [child_item]       NVARCHAR (255) NULL,
    [item_description] NVARCHAR (255) NULL,
    [TYPE]             NVARCHAR (255) NULL,
    [Cur]              NVARCHAR (255) NULL,
    [BItem]            NVARCHAR (765) NOT NULL,
    [Qty]              FLOAT (53)     NULL,
    [Import+15%]       FLOAT (53)     NULL,
    [CostPrice]        FLOAT (53)     NULL,
    [Exch_Rate]        FLOAT (53)     NULL,
    [Rate_Unit]        FLOAT (53)     NULL,
    [Basic_price]      FLOAT (53)     NULL,
    [CItem]            NVARCHAR (765) NULL,
    [CImport+15%]      FLOAT (53)     NULL,
    [CQty]             FLOAT (53)     NULL,
    [CCur]             NVARCHAR (255) NULL,
    [CCostPrice]       FLOAT (53)     NULL,
    [CRate_Unit]       FLOAT (53)     NULL,
    [CExch_Rate]       FLOAT (53)     NULL,
    [CBasic_price]     FLOAT (53)     NULL,
    [Status]           VARCHAR (6)    NOT NULL,
    [BOMADD]           FLOAT (53)     NULL,
    [BOMDEL]           FLOAT (53)     NULL,
    [NETDIFF]          FLOAT (53)     NULL,
    [Pricediff]        FLOAT (53)     NULL,
    [QTYDIFF]          FLOAT (53)     NULL,
    [Exchange_Diff]    FLOAT (53)     NULL,
    [DOM_IMP]          FLOAT (53)     NULL,
    [IMP_DOM]          FLOAT (53)     NULL
);


GO

