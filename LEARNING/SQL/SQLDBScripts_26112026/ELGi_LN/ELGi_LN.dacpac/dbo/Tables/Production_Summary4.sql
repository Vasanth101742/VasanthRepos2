CREATE TABLE [dbo].[Production_Summary4] (
    [company]          NVARCHAR (38) NULL,
    [warehouse]        NVARCHAR (12) NULL,
    [item]             NVARCHAR (94) NULL,
    [itemdescr]        VARCHAR (50)  NULL,
    [Description]      VARCHAR (50)  NULL,
    [EntryDate]        DATE          NULL,
    [Opening_Plan]     FLOAT (53)    NULL,
    [Opening_Release]  FLOAT (53)    NULL,
    [Opening_WIP]      FLOAT (53)    NULL,
    [Opening_FG]       FLOAT (53)    NULL,
    [FTM_Plan]         FLOAT (53)    NULL,
    [MTD_Plan]         FLOAT (53)    NULL,
    [MTD_Release]      FLOAT (53)    NULL,
    [MTD_WIP]          FLOAT (53)    NULL,
    [MTD_Closing]      FLOAT (53)    NULL,
    [MTD_Sales]        FLOAT (53)    NULL,
    [Current_FG]       FLOAT (53)    NULL,
    [EntryMonth]       INT           NULL,
    [EntryYear]        INT           NULL,
    [Rno_WH]           INT           NULL,
    [Rno_Item]         INT           NULL,
    [MTD_Backlog]      FLOAT (53)    NULL,
    [Avg_Sales_Amt]    FLOAT (53)    NULL,
    [LastUpdatedDate]  DATE          NULL,
    [FTM_Balance_Plan] FLOAT (53)    NULL,
    [Rno_Item2]        INT           NULL,
    [Prod_Allocation]  FLOAT (53)    NULL,
    [Future_Plan]      FLOAT (53)    NULL,
    [Sales_Allocation] FLOAT (53)    NULL
);


GO

