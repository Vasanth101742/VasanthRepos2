CREATE TABLE [dbo].[BOM_Sales_Details_Temp1] (
    [Region]   VARCHAR (6)     NULL,
    [compnr]   BIGINT          NULL,
    [InvDate]  DATE            NULL,
    [idat2]    DATETIME        NULL,
    [tran]     NVARCHAR (3)    NULL,
    [idoc]     BIGINT          NULL,
    [orno]     NVARCHAR (9)    NULL,
    [pono]     BIGINT          NULL,
    [Rnk1]     BIGINT          NULL,
    [ItemCode] NVARCHAR (4000) NULL,
    [ItemDesc] NVARCHAR (60)   NULL,
    [dqua]     FLOAT (53)      NULL,
    [amti]     FLOAT (53)      NULL,
    [pric]     FLOAT (53)      NULL,
    [sitm]     NVARCHAR (47)   NULL,
    [qibm]     DECIMAL (12, 6) NULL,
    [FinYear]  VARCHAR (25)    NULL,
    [FinMonth] VARCHAR (25)    NULL,
    [ccur]     NVARCHAR (10)   NULL,
    [amth_1]   FLOAT (53)      NULL
);


GO

