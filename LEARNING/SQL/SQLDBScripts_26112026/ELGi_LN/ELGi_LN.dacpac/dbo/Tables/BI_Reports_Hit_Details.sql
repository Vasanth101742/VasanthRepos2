CREATE TABLE [dbo].[BI_Reports_Hit_Details] (
    [policyid]       UNIQUEIDENTIFIER NOT NULL,
    [itemid]         UNIQUEIDENTIFIER NOT NULL,
    [Name]           NVARCHAR (425)   COLLATE Latin1_General_100_CI_AS_KS_WS NOT NULL,
    [TimeStart]      DATETIME         NULL,
    [TimeEnd]        DATETIME         NULL,
    [TimeProcessing] INT              NULL,
    [TimeRendering]  INT              NULL,
    [Status]         NVARCHAR (40)    COLLATE Latin1_General_100_CI_AS_KS_WS NULL,
    [UserName]       NVARCHAR (260)   COLLATE Latin1_General_100_CI_AS_KS_WS NULL
);


GO

