CREATE TABLE [dbo].[elgi_Production_details_BOM] (
    [company]          NVARCHAR (38) NULL,
    [warehouse]        NVARCHAR (12) NULL,
    [item]             NVARCHAR (94) NULL,
    [itemdescr]        VARCHAR (50)  NULL,
    [Description]      VARCHAR (50)  NULL,
    [Prodorderno]      NVARCHAR (18) NULL,
    [date1]            DATE          NULL,
    [osta]             INT           NULL,
    [Planned_qty]      INT           NULL,
    [Released_qty]     INT           NULL,
    [SITM]             NVARCHAR (94) NULL,
    [EFDT]             DATETIME      NULL,
    [BAPR]             FLOAT (53)    NULL,
    [PredictionType]   VARCHAR (50)  NULL,
    [pdnoRnk]          INT           NULL,
    [Prod_Allocation]  FLOAT (53)    NULL,
    [InvQty]           FLOAT (53)    NULL,
    [InvValue]         FLOAT (53)    NULL,
    [KITM]             INT           NULL,
    [Sales_Allocation] FLOAT (53)    NULL,
    [SITM_Qty]         FLOAT (53)    NULL,
    [InvRnk]           INT           NULL,
    [Opening_InvQty]   FLOAT (53)    NULL,
    [Opening_InvValue] FLOAT (53)    NULL,
    [Pend_Trigger_Qty] FLOAT (53)    NULL,
    [SITM_Value]       FLOAT (53)    NULL,
    [SITM_Desc]        VARCHAR (50)  NULL
);


GO

