CREATE TABLE [dbo].[Integration_Ledger_Entries] (
    [Comp]       NVARCHAR (38)  NULL,
    [Ledger]     NVARCHAR (24)  NULL,
    [DBCR]       NVARCHAR (38)  NULL,
    [Type]       VARCHAR (6)    NOT NULL,
    [Date1]      DATETIME       NULL,
    [RBON]       NVARCHAR (34)  NULL,
    [RBID]       NVARCHAR (22)  NULL,
    [RPON]       NVARCHAR (38)  NULL,
    [Trantype]   NVARCHAR (6)   NULL,
    [DocNo]      NVARCHAR (38)  NULL,
    [PODT]       DATETIME       NULL,
    [Currency]   NVARCHAR (6)   NULL,
    [Detail1]    NVARCHAR (100) NULL,
    [Detail2]    NVARCHAR (100) NULL,
    [Detail3]    NVARCHAR (100) NULL,
    [Value]      FLOAT (53)     NULL,
    [FYER]       NVARCHAR (38)  NULL,
    [FPRD]       NVARCHAR (38)  NULL,
    [LINO]       NVARCHAR (38)  NULL,
    [LEAC_Descr] NVARCHAR (60)  NULL,
    [NUNI]       FLOAT (53)     NULL
);


GO

