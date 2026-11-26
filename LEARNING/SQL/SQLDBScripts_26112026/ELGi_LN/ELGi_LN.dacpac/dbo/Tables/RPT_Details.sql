CREATE TABLE [dbo].[RPT_Details] (
    [Company]                          VARCHAR (20)   NULL,
    [Leac]                             VARCHAR (50)   NULL,
    [AMTH1]                            FLOAT (53)     NULL,
    [AMTH2]                            FLOAT (53)     NULL,
    [AMTH3]                            FLOAT (53)     NULL,
    [AMNT]                             FLOAT (53)     NULL,
    [TransactionCategory]              NVARCHAR (255) NULL,
    [Type_of_RPT_SEBI_Format]          NVARCHAR (255) NULL,
    [Details_of_other_RPT_SEBI_Format] NVARCHAR (255) NULL,
    [BPID]                             VARCHAR (50)   NULL,
    [BPName]                           NVARCHAR (100) NULL,
    [TransactionCategory_Order]        INT            NULL,
    [TransactionSubCategory_Order]     INT            NULL,
    [Type_of_RPT_SEBI_Format_Order]    FLOAT (53)     NULL,
    [TransactionSubCategory]           NVARCHAR (255) NULL,
    [FYER]                             NVARCHAR (38)  NULL,
    [FPRD]                             NVARCHAR (38)  NULL,
    [CalYear]                          VARCHAR (20)   NULL,
    [CalMonth]                         VARCHAR (20)   NULL,
    [MonthName]                        VARCHAR (20)   NULL,
    [Finperiod]                        VARCHAR (20)   NULL
);


GO

