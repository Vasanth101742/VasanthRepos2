CREATE TABLE [dbo].[Creditors_Dup_Pay] (
    [SuppInvNo]     NVARCHAR (40)  NULL,
    [suppcode]      NVARCHAR (18)  NULL,
    [SuppName]      NVARCHAR (100) NULL,
    [PaidAmth]      FLOAT (53)     NULL,
    [InvCounts]     INT            NULL,
    [Condition]     INT            NOT NULL,
    [ConditionDesc] VARCHAR (100)  NULL,
    [SuppInvNo2]    VARCHAR (50)   NULL
);


GO

