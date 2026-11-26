CREATE TABLE [dbo].[tfacr201_Test] (
    [Import_Status]               NVARCHAR (1)  NULL,
    [Import_Code]                 NVARCHAR (1)  NULL,
    [Import_Message]              NVARCHAR (1)  NULL,
    [Company]                     SMALLINT      NULL,
    [Business_Partner]            NVARCHAR (50) NULL,
    [Invoice_to_BP]               NVARCHAR (50) NULL,
    [ttyp]                        TINYINT       NULL,
    [ninv]                        INT           NULL,
    [Schedule_Number]             TINYINT       NULL,
    [Due_Date]                    DATE          NULL,
    [Document_Date]               DATE          NULL,
    [Expected_Cash_Date]          DATE          NULL,
    [Receipt_Method]              TINYINT       NULL,
    [Transaction_Amount]          FLOAT (53)    NULL,
    [Amount_in_HC]                FLOAT (53)    NULL,
    [Received_Amount]             TINYINT       NULL,
    [Received_Amount_in_HC]       TINYINT       NULL,
    [Balance_in_Invoice_Currency] FLOAT (53)    NULL,
    [Balance_in_HC]               FLOAT (53)    NULL,
    [Balance_Anticipated]         FLOAT (53)    NULL,
    [Balance_Anticipated_in_HC]   FLOAT (53)    NULL
);


GO

