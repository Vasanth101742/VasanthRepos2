CREATE TABLE [dbo].[inv_490_Tmp2] (
    [COMPANY]    NVARCHAR (38) NULL,
    [T$CWAR]     NVARCHAR (12) NULL,
    [T$ITEM]     NVARCHAR (94) NULL,
    [ItemDescr]  INT           NULL,
    [T$TRDT]     DATETIME      NULL,
    [T$SEQN]     NVARCHAR (38) NULL,
    [T$INWP]     NVARCHAR (38) NULL,
    [T$QSTK]     FLOAT (53)    NULL,
    [T$QSKT]     FLOAT (53)    NULL,
    [T$KOOR]     NVARCHAR (38) NULL,
    [DerivedStk] INT           NOT NULL,
    [Amnt]       FLOAT (53)    NULL,
    [Amnt2]      INT           NULL,
    [Amnt3]      INT           NULL,
    [TransRnk]   INT           NULL
);


GO

