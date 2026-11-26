CREATE TABLE [dbo].[InventorySubsFact_History] (
    [COMPANY]           NVARCHAR (38) NULL,
    [CWAR]              NVARCHAR (12) NULL,
    [ITEM]              NVARCHAR (94) NULL,
    [ItemDescr]         VARCHAR (100) NULL,
    [TRDT]              DATETIME      NULL,
    [SEQN]              NVARCHAR (38) NULL,
    [INWP]              NVARCHAR (38) NULL,
    [QSKT]              FLOAT (53)    NULL,
    [Amnt]              FLOAT (53)    NULL,
    [Ageing]            VARCHAR (50)  NULL,
    [AgeingOrdr]        INT           NULL,
    [stock_955]         FLOAT (53)    NULL,
    [Cumulative_stk]    FLOAT (53)    NULL,
    [Remarks]           VARCHAR (50)  NULL,
    [OrderType]         INT           NULL,
    [QSTK]              INT           NULL,
    [IssueDate]         DATE          NULL,
    [Amnt2]             FLOAT (53)    NULL,
    [Amnt3]             FLOAT (53)    NULL,
    [CITG]              NVARCHAR (12) NULL,
    [CITG_desc]         NVARCHAR (60) NULL,
    [LedgerCode]        VARCHAR (20)  NULL,
    [LedgerDesc]        VARCHAR (50)  NULL,
    [IssueOrderType]    INT           NULL,
    [FrtRate]           FLOAT (53)    NULL,
    [Amnt4]             FLOAT (53)    NULL,
    [EntryDate]         DATETIME      NULL,
    [LatestReceiptDate] DATE          NULL,
    [TRDT2]             DATETIME      NULL
);


GO

