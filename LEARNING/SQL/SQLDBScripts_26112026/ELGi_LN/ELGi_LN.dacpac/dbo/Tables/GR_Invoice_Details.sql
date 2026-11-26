CREATE TABLE [dbo].[GR_Invoice_Details] (
    [UNIQUE_ID]        INT             NOT NULL,
    [LocationId]       NVARCHAR (50)   NULL,
    [TenantId]         NVARCHAR (50)   NULL,
    [AccountingEntity] NVARCHAR (50)   NULL,
    [StatementDate]    DATE            NULL,
    [Dealer]           NVARCHAR (50)   NULL,
    [CompanyCode]      NVARCHAR (50)   NULL,
    [InvoiceType]      NVARCHAR (50)   NULL,
    [InvDoc]           NVARCHAR (50)   NULL,
    [InvDate]          DATE            NULL,
    [Currency]         NVARCHAR (50)   NULL,
    [InvAmt]           NUMERIC (18, 2) NULL,
    [DueDate]          DATE            NULL,
    [PaidAmt]          NUMERIC (18, 2) NULL,
    [BalanceAmt]       NUMERIC (18, 2) NULL,
    [AccNum]           NVARCHAR (100)  NULL,
    [DealerName]       NVARCHAR (100)  NULL,
    [InsertDate]       DATETIME        NULL,
    [RESPONSE]         NVARCHAR (175)  NULL,
    [UNIQUEID]         NVARCHAR (100)  NULL,
    [REQID]            NVARCHAR (100)  NULL,
    [STATUS]           NVARCHAR (100)  NULL,
    [ErrorMessage]     NVARCHAR (MAX)  NULL,
    [UTRNUMBER]        NVARCHAR (100)  NULL,
    [ErrorCode]        NVARCHAR (100)  NULL,
    [UpdatedOn]        DATETIME        NULL,
    [ln_ack]           INT             NULL,
    [ln_ack_dt]        DATETIME        NULL,
    [SentToICICI]      INT             NULL,
    [SentToICICI_On]   DATETIME        NULL
);


GO

