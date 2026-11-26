CREATE TABLE [dbo].[ATS_Spares_BDI_FOC_Orders_OTD] (
    [dpst]            NVARCHAR (12) NULL,
    [company]         INT           NULL,
    [ordernum]        NVARCHAR (18) NULL,
    [positionnum]     INT           NULL,
    [custcode]        NVARCHAR (18) NULL,
    [orderdate]       DATETIME      NULL,
    [plan_deliv_date] DATETIME      NULL,
    [orderqty]        FLOAT (53)    NULL,
    [deliverydt]      DATETIME      NULL,
    [deliveredqty]    FLOAT (53)    NULL,
    [backordqty]      FLOAT (53)    NULL,
    [warehouse]       VARCHAR (50)  NULL,
    [otd]             INT           NULL,
    [ItemCode]        NVARCHAR (94) NULL,
    [ItemDescription] CHAR (30)     NULL,
    [Ordertype]       NVARCHAR (6)  NULL,
    [Type]            VARCHAR (3)   NULL
);


GO

