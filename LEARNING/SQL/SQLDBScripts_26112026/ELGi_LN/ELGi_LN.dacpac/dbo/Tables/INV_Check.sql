CREATE TABLE [dbo].[INV_Check] (
    [comp]       INT             NULL,
    [WAR]        VARCHAR (100)   NULL,
    [item]       VARCHAR (100)   NULL,
    [stoc]       FLOAT (53)      NULL,
    [PVAL]       FLOAT (53)      NULL,
    [company]    INT             NULL,
    [T$cwar]     NVARCHAR (12)   NULL,
    [T$ITEM]     NVARCHAR (94)   NULL,
    [Qty]        NUMERIC (38)    NULL,
    [price]      NUMERIC (38, 6) NULL,
    [QtyMissing] INT             NULL
);


GO

