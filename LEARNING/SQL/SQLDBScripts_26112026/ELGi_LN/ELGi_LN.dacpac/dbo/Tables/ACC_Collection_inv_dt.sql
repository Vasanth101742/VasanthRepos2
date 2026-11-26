CREATE TABLE [dbo].[ACC_Collection_inv_dt] (
    [company]     INT             NOT NULL,
    [trantyp]     NVARCHAR (6)    NULL,
    [invno]       INT             NOT NULL,
    [custno]      NVARCHAR (18)   NULL,
    [custname1]   NVARCHAR (70)   NULL,
    [docdt]       DATETIME        NULL,
    [collection]  NUMERIC (16, 2) NULL,
    [dpstcode]    VARCHAR (20)    NULL,
    [dpstname]    VARCHAR (100)   NULL,
    [description] VARCHAR (50)    NULL,
    [areacode]    NVARCHAR (8)    NULL,
    [areaname]    VARCHAR (50)    NULL,
    [zone]        VARCHAR (50)    NULL,
    [region]      VARCHAR (50)    NULL,
    [global]      VARCHAR (20)    NULL,
    [anptrantyp]  NVARCHAR (6)    NULL,
    [anpdocno]    INT             NULL,
    [cdocno]      INT             NOT NULL,
    [ctrantyp]    CHAR (3)        NOT NULL,
    [doctyp]      INT             NULL,
    [refr]        INT             NULL,
    [invdate]     DATETIME        NULL,
    [flag]        INT             NULL,
    [Duedate]     DATETIME        NULL
);


GO

