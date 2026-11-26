CREATE TABLE [dbo].[ACP_Consolidated] (
    [Company]             INT            NULL,
    [TranType]            NVARCHAR (6)   NULL,
    [InvNo]               INT            NULL,
    [SuppCode]            NVARCHAR (18)  NULL,
    [SuppName]            NVARCHAR (100) NULL,
    [InvAmth]             FLOAT (53)     NULL,
    [DueDate]             DATE           NULL,
    [DueAmth]             FLOAT (53)     NULL,
    [LastPaidDate]        DATE           NULL,
    [PaidAmth]            FLOAT (53)     NULL,
    [DueBalh]             FLOAT (53)     NULL,
    [PaymentDays]         INT            NULL,
    [PaymentCategory]     VARCHAR (50)   NULL,
    [PaymentCategoryOrdr] INT            NULL
);


GO

