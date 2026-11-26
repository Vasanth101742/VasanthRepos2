CREATE TABLE [dbo].[GR_dealer_balance_History] (
    [id]               INT             NOT NULL,
    [AccName]          NVARCHAR (175)  NULL,
    [NickName]         NVARCHAR (100)  NULL,
    [AccNum]           NVARCHAR (100)  NULL,
    [Currency]         NVARCHAR (15)   NULL,
    [Balance]          NUMERIC (19, 2) NULL,
    [AvailableBalance] NUMERIC (19, 2) NULL,
    [ErrorMessage]     NVARCHAR (150)  NULL,
    [ErrorCode]        NVARCHAR (20)   NULL,
    [Response]         NVARCHAR (20)   NULL,
    [UpdatedOn]        DATETIME        NULL
);


GO

