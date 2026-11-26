CREATE TABLE [dbo].[CRM_IAS_to_LN] (
    [EnquiryID]                  VARCHAR (200) NULL,
    [ItemCode]                   VARCHAR (94)  NULL,
    [quantity]                   FLOAT (53)    NULL,
    [priceperunit]               FLOAT (53)    NULL,
    [elgi_dealerengineer_Code]   VARCHAR (18)  NULL,
    [elgi_dealerengineer_Mobile] VARCHAR (64)  NULL,
    [SalesOffice]                VARCHAR (12)  NULL,
    [OrderStatus]                FLOAT (53)    NULL,
    [OrderType]                  VARCHAR (6)   NULL,
    [OrderSeries]                VARCHAR (16)  NULL,
    [UpdatedDate]                DATETIME      NULL,
    [Account_ID]                 VARCHAR (40)  NULL,
    [BPID]                       VARCHAR (18)  NULL,
    [RMR1]                       VARCHAR (200) NULL,
    [RMR2]                       VARCHAR (200) NULL,
    [RMR3]                       VARCHAR (60)  NULL,
    [RMR4]                       VARCHAR (60)  NULL,
    [SQNB]                       INT           NULL,
    [ORNO]                       VARCHAR (18)  NULL,
    [PONO]                       INT           NULL,
    [Posted]                     INT           NULL,
    [CWAR]                       VARCHAR (12)  NULL,
    [cwoc]                       VARCHAR (12)  NULL,
    [lnpr]                       FLOAT (53)    NULL,
    [odat]                       DATE          NULL
);


GO

