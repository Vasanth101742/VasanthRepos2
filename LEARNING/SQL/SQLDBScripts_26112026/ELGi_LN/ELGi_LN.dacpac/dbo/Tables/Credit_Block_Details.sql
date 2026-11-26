CREATE TABLE [dbo].[Credit_Block_Details] (
    [Company]     INT           NOT NULL,
    [ORNO]        NVARCHAR (18) NULL,
    [PONO]        NVARCHAR (38) NULL,
    [SQNB]        NVARCHAR (38) NULL,
    [CSQN]        NVARCHAR (38) NULL,
    [HREA]        NVARCHAR (6)  NULL,
    [DTBL]        DATETIME      NULL,
    [OPON]        NVARCHAR (38) NULL,
    [LOBL]        NVARCHAR (32) NULL,
    [DTRL]        DATETIME      NULL,
    [LORL]        NVARCHAR (32) NULL,
    [Area]        NVARCHAR (6)  NULL,
    [AreaName]    VARCHAR (50)  NULL,
    [Dpst]        NVARCHAR (12) NULL,
    [DPSTName]    VARCHAR (100) NULL,
    [BPID]        NVARCHAR (18) NULL,
    [CustName]    VARCHAR (100) NULL,
    [BPRT]        NVARCHAR (38) NULL,
    [RLTY]        NVARCHAR (38) NULL,
    [RLAM]        FLOAT (53)    NULL,
    [ERDT]        DATETIME      NULL,
    [PSTC]        NVARCHAR (20) NULL,
    [PHSN]        NVARCHAR (38) NULL,
    [REFCNTD]     NVARCHAR (38) NULL,
    [REFCNTU]     NVARCHAR (38) NULL,
    [CreditLimit] FLOAT (53)    NULL
);


GO

