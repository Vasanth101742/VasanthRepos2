CREATE TABLE [dbo].[ATS_Production_ALC] (
    [COMPANY]          NVARCHAR (38) NULL,
    [CWAR]             NVARCHAR (12) NULL,
    [MITM]             NVARCHAR (94) NULL,
    [ItemDescr]        VARCHAR (50)  NULL,
    [ProductGroup_MRP] VARCHAR (50)  NULL,
    [ProductionDate]   DATE          NULL,
    [WIP_Qty]          FLOAT (53)    NULL,
    [ClosedQty]        FLOAT (53)    NULL,
    [PDNO]             VARCHAR (25)  NULL
);


GO

