CREATE TABLE [dbo].[FG_Inventory] (
    [COMPANY]        NVARCHAR (38) NULL,
    [CWAR]           NVARCHAR (12) NULL,
    [ITEM]           NVARCHAR (94) NULL,
    [ItemDescr]      VARCHAR (100) NULL,
    [TRDT]           DATETIME      NULL,
    [SEQN]           NVARCHAR (38) NULL,
    [INWP]           NVARCHAR (38) NULL,
    [QSKT]           FLOAT (53)    NULL,
    [Amnt]           FLOAT (53)    NULL,
    [Ageing]         VARCHAR (50)  NULL,
    [AgeingOrdr]     INT           NULL,
    [stock_955]      FLOAT (53)    NULL,
    [Cumulative_stk] FLOAT (53)    NULL,
    [Remarks]        VARCHAR (50)  NULL,
    [PredictionType] VARCHAR (25)  NULL
);


GO

