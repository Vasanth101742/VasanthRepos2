CREATE TABLE [dbo].[Inventory_History] (
    [COMPANY]       NVARCHAR (38) NULL,
    [InvTypeOrder]  FLOAT (53)    NULL,
    [INVType]       VARCHAR (50)  NULL,
    [VerticalOrder] FLOAT (53)    NULL,
    [Vertical]      VARCHAR (50)  NULL,
    [CompName]      VARCHAR (50)  NULL,
    [TargetDays]    FLOAT (53)    NULL,
    [Amnt4]         FLOAT (53)    NULL,
    [CalYear]       INT           NULL,
    [CalMonth]      INT           NULL,
    [FinYear]       INT           NULL,
    [FinMonth]      INT           NULL,
    [Sales_Amount]  FLOAT (53)    NULL,
    [ActualDays]    FLOAT (53)    NULL
);


GO

