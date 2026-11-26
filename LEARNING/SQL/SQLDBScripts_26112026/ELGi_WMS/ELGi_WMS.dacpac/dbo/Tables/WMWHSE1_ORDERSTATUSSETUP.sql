CREATE TABLE [dbo].[WMWHSE1_ORDERSTATUSSETUP] (
    [SCHEMA_REFERENCE]  NVARCHAR (50)  NULL,
    [DELETED]           INT            NULL,
    [SERIALKEY]         BIGINT         NULL,
    [WHSEID]            NVARCHAR (30)  NULL,
    [SHOWSEQ]           BIGINT         NULL,
    [CODE]              NVARCHAR (3)   NULL,
    [DESCRIPTION]       NVARCHAR (30)  NULL,
    [EDITABLE]          NVARCHAR (1)   NULL,
    [ENABLED]           NVARCHAR (1)   NULL,
    [ORDERFLAG]         NVARCHAR (1)   NULL,
    [XORDERFLAG]        NVARCHAR (1)   NULL,
    [TRANSSHIPFLAG]     NVARCHAR (1)   NULL,
    [HEADERFLAG]        NVARCHAR (1)   NULL,
    [DETAILFLAG]        NVARCHAR (1)   NULL,
    [HEADERHISTORYFLAG] NVARCHAR (1)   NULL,
    [DETAILHISTORYFLAG] NVARCHAR (1)   NULL,
    [RULES]             NVARCHAR (255) NULL,
    [COMMENTS]          NVARCHAR (255) NULL,
    [ADDDATE]           NVARCHAR (40)  NULL,
    [ADDWHO]            NVARCHAR (256) NULL,
    [EDITDATE]          NVARCHAR (40)  NULL,
    [EDITWHO]           NVARCHAR (256) NULL,
    [dlDocumentDate]    NVARCHAR (40)  NULL
);


GO

