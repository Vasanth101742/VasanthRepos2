CREATE TABLE [dbo].[WIP_Ageing] (
    [company]          NVARCHAR (38) NULL,
    [warehouse]        NVARCHAR (12) NULL,
    [item]             NVARCHAR (94) NULL,
    [itemdescr]        VARCHAR (50)  NULL,
    [Description]      VARCHAR (50)  NULL,
    [Prodorderno]      NVARCHAR (18) NULL,
    [date1]            DATE          NULL,
    [WIPPendingDays]   INT           NULL,
    [NationalHolidays] INT           NULL,
    [Days_in_WIP]      INT           NULL,
    [Esclvl1]          INT           NOT NULL,
    [Esclvl2]          INT           NOT NULL,
    [Escalationlevel]  INT           NULL,
    [rownum]           BIGINT        NULL,
    [Escl_Comments]    VARCHAR (50)  NULL,
    [FabNo]            NVARCHAR (60) NULL,
    [PlanDelDate]      DATE          NULL,
    [OTADate]          DATE          NULL,
    [WIP_Qty]          FLOAT (53)    NULL
);


GO

