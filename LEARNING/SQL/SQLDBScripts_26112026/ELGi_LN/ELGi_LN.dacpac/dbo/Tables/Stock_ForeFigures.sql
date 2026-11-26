CREATE TABLE [dbo].[Stock_ForeFigures] (
    [COMPANY]      NVARCHAR (38) NULL,
    [CWAR]         NVARCHAR (12) NULL,
    [ITEM]         NVARCHAR (94) NULL,
    [rnk1]         BIGINT        NULL,
    [QHND]         FLOAT (53)    NULL,
    [Pur_month]    INT           NULL,
    [Pur_year]     INT           NULL,
    [rnk2]         BIGINT        NULL,
    [ToBe_ConsQty] FLOAT (53)    NULL,
    [RecvdQty]     FLOAT (53)    NULL,
    [Issue_month]  INT           NULL,
    [Issue_year]   INT           NULL,
    [rnk3]         BIGINT        NULL,
    [IssueQty]     FLOAT (53)    NULL
);


GO

