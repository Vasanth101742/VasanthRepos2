CREATE TABLE [dbo].[FG_Inventory_Details] (
    [COMPANY]     NVARCHAR (38) NULL,
    [CWAR]        NVARCHAR (12) NULL,
    [Vertical]    VARCHAR (50)  NULL,
    [ITEM]        NVARCHAR (94) NULL,
    [ItemDescr]   VARCHAR (100) NULL,
    [TRDT]        DATETIME      NULL,
    [QSKT]        FLOAT (53)    NULL,
    [Amnt]        FLOAT (53)    NULL,
    [Amnt_Mn]     FLOAT (53)    NULL,
    [INVType]     VARCHAR (50)  NULL,
    [CompName]    VARCHAR (50)  NULL,
    [Ageing]      INT           NULL,
    [OrderDate]   DATE          NULL,
    [OrderNum]    NVARCHAR (18) NULL,
    [PositionNum] INT           NULL,
    [CustCode]    NVARCHAR (18) NULL,
    [CustName]    VARCHAR (100) NULL,
    [PDNO]        NVARCHAR (18) NULL,
    [MSER]        NVARCHAR (60) NULL,
    [FG_BLK]      VARCHAR (3)   NULL,
    [QA_BLK]      VARCHAR (3)   NULL,
    [Rnk1]        INT           NULL,
    [LastRunDate] DATE          NULL,
    [SEQN]        NVARCHAR (38) NULL,
    [INWP]        NVARCHAR (38) NULL,
    [Description] VARCHAR (50)  NULL
);


GO

