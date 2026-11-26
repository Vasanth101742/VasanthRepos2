CREATE TABLE [dbo].[Collection_Stage3] (
    [company]     INT           NULL,
    [trantyp]     NVARCHAR (3)  NULL,
    [invno]       INT           NULL,
    [custno]      NVARCHAR (9)  NULL,
    [custname1]   NVARCHAR (35) NULL,
    [docdt]       DATETIME      NULL,
    [collection]  FLOAT (53)    NULL,
    [dpstcode]    VARCHAR (20)  NULL,
    [dpstname]    VARCHAR (100) NULL,
    [description] VARCHAR (50)  NULL,
    [areacode]    NVARCHAR (4)  NULL,
    [areaname]    VARCHAR (50)  NULL,
    [zone]        VARCHAR (50)  NULL,
    [region]      VARCHAR (50)  NULL,
    [global]      VARCHAR (20)  NULL,
    [anptrantyp]  NVARCHAR (3)  NULL,
    [anpdocno]    INT           NULL,
    [cdocno]      INT           NULL,
    [ctrantyp]    NVARCHAR (3)  NULL,
    [doctyp]      INT           NULL,
    [refr]        INT           NOT NULL
);


GO

