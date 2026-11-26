CREATE TABLE [dbo].[Acc_Advance_Others] (
    [custno]      NVARCHAR (9)  NULL,
    [custname1]   NVARCHAR (70) NULL,
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
    [area]        VARCHAR (50)  NULL,
    [dpst]        VARCHAR (50)  NULL,
    [description] VARCHAR (50)  NULL,
    [dpstname]    VARCHAR (50)  NULL,
    [areaname]    VARCHAR (50)  NULL,
    [zone]        VARCHAR (50)  NULL,
    [region]      VARCHAR (50)  NULL,
    [global]      VARCHAR (50)  NULL
);


GO

