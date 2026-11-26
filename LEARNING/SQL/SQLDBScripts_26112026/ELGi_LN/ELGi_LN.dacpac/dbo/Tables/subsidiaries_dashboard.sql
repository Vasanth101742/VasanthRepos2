CREATE TABLE [dbo].[subsidiaries_dashboard] (
    [company]                  NVARCHAR (38) NULL,
    [t$cuno]                   NVARCHAR (18) NULL,
    [t$item]                   NVARCHAR (94) NULL,
    [t$sord]                   NVARCHAR (18) NULL,
    [t$spos]                   NVARCHAR (38) NULL,
    [nooftrigger]              INT           NULL,
    [noofsalesorder_processed] INT           NULL,
    [PDNO]                     NVARCHAR (18) NULL,
    [firsttrigger]             VARCHAR (100) NULL,
    [product]                  VARCHAR (100) NULL,
    [name]                     VARCHAR (100) NULL,
    [plan_del_date]            DATE          NULL,
    [saleorder_date]           DATE          NULL,
    [commitment_date]          DATE          NULL,
    [arival_date]              DATE          NULL,
    [delqty]                   FLOAT (53)    NULL,
    [custcode]                 VARCHAR (100) NULL,
    [otd]                      FLOAT (53)    NULL,
    [bcklog]                   VARCHAR (100) NULL,
    [NEWITEM]                  VARCHAR (100) NULL
);


GO

