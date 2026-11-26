CREATE TABLE [dbo].[Ledger_details] (
    [OriginalCompany]     NVARCHAR (38) NULL,
    [TransactionType]     NVARCHAR (6)  NULL,
    [TranTypeDescription] NVARCHAR (60) NULL,
    [Document]            NVARCHAR (38) NULL,
    [DocumentDate]        DATETIME      NULL,
    [LedgerAccount]       NVARCHAR (24) NULL,
    [LedgerDescription]   NVARCHAR (60) NULL,
    [TransReference]      NVARCHAR (64) NULL,
    [Currency]            NVARCHAR (6)  NULL,
    [CurRate]             NVARCHAR (38) NULL,
    [Debit_Credit]        VARCHAR (20)  NULL,
    [Amount]              FLOAT (53)    NULL,
    [BusinessPartner]     NVARCHAR (18) NULL,
    [BusinessPartnerName] NVARCHAR (70) NULL,
    [TransCategory]       VARCHAR (18)  NULL,
    [TRANCode]            NVARCHAR (38) NULL,
    [TRANDesc]            VARCHAR (20)  NULL,
    [FYER]                VARCHAR (10)  NULL,
    [FPRD]                VARCHAR (10)  NULL
);


GO

