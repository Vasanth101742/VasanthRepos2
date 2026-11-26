CREATE TABLE [dbo].[ACR_Tmp4] (
    [company]      INT             NOT NULL,
    [CustNo]       NVARCHAR (18)   NULL,
    [Trantyp]      NVARCHAR (6)    NOT NULL,
    [invno]        INT             NOT NULL,
    [lineno]       INT             NOT NULL,
    [AmntHome]     NUMERIC (38, 2) NULL,
    [CurDiffAmnt]  NUMERIC (38, 2) NULL,
    [FDisAmntHome] NUMERIC (38, 2) NULL,
    [SDisAmntHome] NUMERIC (38, 2) NULL,
    [TDisAmntHome] NUMERIC (38, 2) NULL,
    [PayDiff]      NUMERIC (38, 2) NULL,
    [PayDiffHome]  NUMERIC (38, 2) NULL,
    [AmntInv]      NUMERIC (38, 4) NULL,
    [FdisAmntInv]  NUMERIC (38, 2) NULL,
    [SDisAmntInv]  NUMERIC (38, 2) NULL,
    [TDisAmntInv]  NUMERIC (38, 2) NULL,
    [PayDiffInv]   NUMERIC (38, 2) NULL,
    [BankCost]     NUMERIC (38, 2) NULL,
    [BankCostHome] NUMERIC (38, 2) NULL,
    [BalHome]      NUMERIC (38, 2) NULL,
    [balamnt]      NUMERIC (38, 2) NULL
);


GO

