CREATE TABLE [dbo].[ATS_Spares_Orders_OTD_BDI_FOC] (
    [dpst]            NVARCHAR (12)  NULL,
    [company]         INT            NULL,
    [ordernum]        INT            NULL,
    [positionnum]     INT            NULL,
    [custcode]        NVARCHAR (18)  NULL,
    [orderdate]       DATETIME       NULL,
    [plan_deliv_date] DATETIME       NULL,
    [orderqty]        FLOAT (53)     NULL,
    [deliverydt]      DATETIME       NULL,
    [deliveredqty]    FLOAT (53)     NULL,
    [backordqty]      FLOAT (53)     NULL,
    [warehouse]       NVARCHAR (10)  NULL,
    [otd]             INT            NULL,
    [ItemCode]        NVARCHAR (100) NULL,
    [ItemDescription] CHAR (30)      NULL,
    [Ordertype]       NVARCHAR (6)   NULL,
    [Type]            VARCHAR (3)    NULL
);


GO

