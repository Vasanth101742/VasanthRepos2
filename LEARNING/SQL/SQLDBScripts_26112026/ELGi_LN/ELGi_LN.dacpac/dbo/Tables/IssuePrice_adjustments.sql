CREATE TABLE [dbo].[IssuePrice_adjustments] (
    [COMPANY]   NVARCHAR (38) NULL,
    [T$CWAR]    NVARCHAR (12) NULL,
    [T$ITEM]    NVARCHAR (94) NULL,
    [T$TRDT]    DATETIME      NULL,
    [T$SEQN]    NVARCHAR (38) NULL,
    [T$INWP]    NVARCHAR (38) NULL,
    [T$CTDT]    DATETIME      NULL,
    [T$QSTK]    FLOAT (53)    NULL,
    [VPDT]      DATETIME      NULL,
    [AMNT$1]    FLOAT (53)    NULL,
    [QSTK_R]    FLOAT (53)    NULL,
    [Adj_Price] FLOAT (53)    NULL
);


GO

