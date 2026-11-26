CREATE TABLE [dbo].[TMP_subsidiaries_dashboard] (
    [T$CUNO]                   NVARCHAR (18) NULL,
    [T$ITEM]                   NVARCHAR (94) NULL,
    [PRODUCT]                  VARCHAR (100) NULL,
    [NAME]                     VARCHAR (100) NULL,
    [OTD]                      FLOAT (53)    NULL,
    [bcklog]                   VARCHAR (100) NULL,
    [NEWITEM]                  VARCHAR (100) NULL,
    [PLAN_DEL_DATE]            DATE          NULL,
    [saleorder_date]           DATE          NULL,
    [commitment_date]          DATE          NULL,
    [arival_date]              DATE          NULL,
    [NOOFTRIGGER]              INT           NULL,
    [NOOFSALESORDER_PROCESSED] INT           NULL,
    [DELQTY]                   INT           NOT NULL
);


GO

