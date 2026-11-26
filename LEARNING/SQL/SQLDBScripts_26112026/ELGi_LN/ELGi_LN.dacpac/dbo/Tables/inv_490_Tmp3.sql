CREATE TABLE [dbo].[inv_490_Tmp3] (
    [COMPANY]    NVARCHAR (38) NULL,
    [T$CWAR]     NVARCHAR (12) NULL,
    [T$ITEM]     NVARCHAR (94) NULL,
    [T$KOOR]     NVARCHAR (38) NULL,
    [T$TRDT]     DATETIME      NULL,
    [T$QSTK]     FLOAT (53)    NULL,
    [T$QSKT]     FLOAT (53)    NULL,
    [TransRnk]   BIGINT        NULL,
    [DerivedStk] INT           NOT NULL,
    [Cum_Stock]  FLOAT (53)    NULL,
    [stk2]       FLOAT (53)    NULL,
    [SEQN]       FLOAT (53)    NULL,
    [INWP]       FLOAT (53)    NULL,
    [Amnt]       FLOAT (53)    NULL,
    [Amnt2]      FLOAT (53)    NULL,
    [Amnt3]      FLOAT (53)    NULL,
    [FrtRate]    FLOAT (53)    NULL,
    [Amnt4]      FLOAT (53)    NULL
);


GO

