CREATE TABLE [dbo].[ELGi_Production_Backlogs] (
    [company]       INT           NULL,
    [warehouse]     NVARCHAR (12) NULL,
    [item]          NVARCHAR (94) NULL,
    [itemdescr]     VARCHAR (50)  NULL,
    [Description]   VARCHAR (50)  NULL,
    [Prodorderno]   NVARCHAR (18) NULL,
    [date1]         DATETIME      NULL,
    [Planned_qty]   INT           NULL,
    [Released_qty]  INT           NULL,
    [Actual_qty]    INT           NULL,
    [WIP_qty]       INT           NOT NULL,
    [avg_bud_price] INT           NULL,
    [sls_price]     INT           NULL
);


GO

