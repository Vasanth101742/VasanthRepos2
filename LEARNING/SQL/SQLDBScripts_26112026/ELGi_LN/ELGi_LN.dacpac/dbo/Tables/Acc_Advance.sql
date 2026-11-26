CREATE TABLE [dbo].[Acc_Advance] (
    [custno]      NVARCHAR (9)  NULL,
    [custname1]   NVARCHAR (35) NULL,
    [trantyp]     NVARCHAR (3)  NULL,
    [invno]       INT           NULL,
    [docdt]       DATETIME      NULL,
    [collection]  FLOAT (53)    NULL,
    [anptrantyp]  NVARCHAR (3)  NULL,
    [anpdocno]    INT           NULL,
    [doctyp]      INT           NULL,
    [balamnt]     FLOAT (53)    NULL,
    [refrence]    NVARCHAR (32) NULL,
    [company]     INT           NULL,
    [area]        VARCHAR (20)  NULL,
    [areaname]    VARCHAR (20)  NULL,
    [zone]        VARCHAR (20)  NULL,
    [region]      VARCHAR (20)  NULL,
    [global]      VARCHAR (20)  NULL,
    [dpst]        NVARCHAR (18) NULL,
    [dpstname]    VARCHAR (50)  NULL,
    [description] VARCHAR (50)  NULL
);


GO

