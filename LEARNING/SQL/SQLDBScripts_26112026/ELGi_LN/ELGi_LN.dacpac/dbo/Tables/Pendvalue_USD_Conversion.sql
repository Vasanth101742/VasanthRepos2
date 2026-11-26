CREATE TABLE [dbo].[Pendvalue_USD_Conversion] (
    [Company]      INT           NULL,
    [ordertype]    NVARCHAR (6)  NULL,
    [OrderNum]     NVARCHAR (18) NULL,
    [PositionNum]  INT           NULL,
    [currency]     VARCHAR (10)  NULL,
    [OrderDate]    DATETIME      NULL,
    [PendQty]      FLOAT (53)    NULL,
    [DelQty]       FLOAT (53)    NULL,
    [Value]        FLOAT (53)    NULL,
    [BCUR]         NVARCHAR (6)  NULL,
    [CCUR]         NVARCHAR (6)  NULL,
    [STDT]         DATETIME      NULL,
    [RATE]         FLOAT (53)    NULL,
    [DaysDiff]     INT           NULL,
    [Rnk]          BIGINT        NULL,
    [value_in_USD] FLOAT (53)    NULL
);


GO

