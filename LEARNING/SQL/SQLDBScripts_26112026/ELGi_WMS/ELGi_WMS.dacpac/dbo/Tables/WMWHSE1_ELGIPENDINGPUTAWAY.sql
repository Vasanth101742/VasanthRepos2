CREATE TABLE [dbo].[WMWHSE1_ELGIPENDINGPUTAWAY] (
    [SKU]              NVARCHAR (50) NULL,
    [DESCR]            NVARCHAR (60) NULL,
    [FROMLOC]          NVARCHAR (50) NULL,
    [FROMID]           NVARCHAR (50) NULL,
    [QTY]              FLOAT (53)    NULL,
    [DATE]             NVARCHAR (40) NULL,
    [referencetype]    NVARCHAR (64) NULL,
    [RECEIPTKEY]       NVARCHAR (50) NULL,
    [DEMANDSKU]        NVARCHAR (30) NULL,
    [TOLOC]            NVARCHAR (25) NULL,
    [TOID]             NVARCHAR (25) NULL,
    [locationcategory] NVARCHAR (10) NULL
);


GO

