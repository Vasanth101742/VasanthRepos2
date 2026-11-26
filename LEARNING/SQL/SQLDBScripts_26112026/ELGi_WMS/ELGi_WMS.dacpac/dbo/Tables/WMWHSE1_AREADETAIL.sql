CREATE TABLE [dbo].[WMWHSE1_AREADETAIL] (
    [SCHEMA_REFERENCE] NVARCHAR (50)  NULL,
    [DELETED]          INT            NULL,
    [SERIALKEY]        BIGINT         NULL,
    [WHSEID]           NVARCHAR (30)  NULL,
    [AREAKEY]          NVARCHAR (10)  NULL,
    [PUTAWAYZONE]      NVARCHAR (10)  NULL,
    [ADDDATE]          NVARCHAR (40)  NULL,
    [ADDWHO]           NVARCHAR (256) NULL,
    [EDITDATE]         NVARCHAR (40)  NULL,
    [EDITWHO]          NVARCHAR (256) NULL,
    [dlDocumentDate]   NVARCHAR (40)  NULL
);


GO

