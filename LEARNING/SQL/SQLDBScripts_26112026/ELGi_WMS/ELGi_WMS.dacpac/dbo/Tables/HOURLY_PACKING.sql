CREATE TABLE [dbo].[HOURLY_PACKING] (
    [T$SHPM]        NVARCHAR (18)  NULL,
    [T$REMK]        NVARCHAR (100) NULL,
    [T$LOGN]        NVARCHAR (40)  NULL,
    [item]          NVARCHAR (94)  NULL,
    [ITEM_DESC]     NVARCHAR (60)  NULL,
    [ordqty]        FLOAT (53)     NULL,
    [Compqty]       FLOAT (53)     NULL,
    [PackDate]      DATETIME       NULL,
    [cnt]           INT            NOT NULL,
    [Value]         INT            NOT NULL,
    [Tme]           VARCHAR (5)    NULL,
    [CUSTCODE]      NVARCHAR (18)  NULL,
    [DPST]          NVARCHAR (12)  NULL,
    [ORDERNO]       NVARCHAR (18)  NULL,
    [CUST_ORD_TYPE] NVARCHAR (6)   NULL,
    [DPSTNAME]      VARCHAR (42)   NOT NULL,
    [CUSTNAME]      VARCHAR (39)   NOT NULL,
    [Ordr]          INT            NOT NULL,
    [cwar]          VARCHAR (10)   NULL
);


GO

