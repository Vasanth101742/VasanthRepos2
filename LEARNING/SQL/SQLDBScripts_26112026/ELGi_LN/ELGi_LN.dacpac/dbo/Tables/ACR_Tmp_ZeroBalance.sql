CREATE TABLE [dbo].[ACR_Tmp_ZeroBalance] (
    [invdate]  DATE         NULL,
    [COMPANY]  INT          NULL,
    [trantyp]  NVARCHAR (6) NULL,
    [invno]    INT          NULL,
    [currency] NVARCHAR (6) NULL,
    [invamt]   FLOAT (53)   NULL,
    [invamti]  FLOAT (53)   NULL,
    [paidamt]  FLOAT (53)   NULL,
    [paidamti] FLOAT (53)   NULL,
    [Balamti]  FLOAT (53)   NULL,
    [Balamt]   FLOAT (53)   NULL,
    [Custno]   VARCHAR (50) NULL
);


GO

