CREATE TABLE [dbo].[USINVOCIE_JSON] (
    [Compnr]      NVARCHAR (10)   NULL,
    [ninv]        NVARCHAR (30)   NULL,
    [docd]        DATE            NULL,
    [itbp]        NVARCHAR (15)   NULL,
    [trec]        NVARCHAR (10)   NULL,
    [ccur]        NVARCHAR (3)    NULL,
    [amti]        DECIMAL (19, 2) NULL,
    [line]        NVARCHAR (5)    NULL,
    [rate_1]      DECIMAL (19, 2) NULL,
    [prod]        NVARCHAR (3)    NULL,
    [Year]        NVARCHAR (5)    NULL,
    [dued]        DATE            NULL,
    [nama]        NVARCHAR (250)  NULL,
    [bpid]        NVARCHAR (30)   NULL,
    [createddate] DATETIME2 (7)   DEFAULT (getdate()) NULL,
    [Ageing]      NVARCHAR (20)   NULL,
    [AgeingOrder] NVARCHAR (5)    NULL,
    [DueType]     NVARCHAR (20)   NULL,
    [Slno]        INT             IDENTITY (1, 1) NOT NULL,
    [DocStatus]   NVARCHAR (3)    DEFAULT ('O') NULL
);


GO

