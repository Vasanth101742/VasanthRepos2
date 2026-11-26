CREATE TABLE [dbo].[Creditors_Dup_Pay_Details] (
    [SuppInvNo]     NVARCHAR (40)  NULL,
    [SuppCode]      NVARCHAR (18)  NULL,
    [SuppName]      NVARCHAR (100) NULL,
    [Company]       INT            NULL,
    [DocDate]       DATE           NULL,
    [DocType]       NVARCHAR (6)   NULL,
    [DocNo]         INT            NULL,
    [DueDate]       DATE           NULL,
    [PaidDate]      DATE           NULL,
    [PaidDocType]   NVARCHAR (6)   NULL,
    [PaidDocNo]     INT            NULL,
    [PaidAmth]      FLOAT (53)     NULL,
    [rownum]        BIGINT         NULL,
    [Condition]     INT            NULL,
    [ConditionDesc] VARCHAR (100)  NULL,
    [SuppInvNo2]    VARCHAR (50)   NULL,
    [CalYear]       INT            NULL,
    [CalMonth]      INT            NULL,
    [Month_Name]    VARCHAR (20)   NULL,
    [FinYear]       INT            NULL,
    [FinMonth]      INT            NULL
);


GO

