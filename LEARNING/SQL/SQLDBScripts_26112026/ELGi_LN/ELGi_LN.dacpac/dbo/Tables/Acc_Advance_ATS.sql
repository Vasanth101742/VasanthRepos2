CREATE TABLE [dbo].[Acc_Advance_ATS] (
    [area]        VARCHAR (50)    NULL,
    [dpst]        VARCHAR (50)    NULL,
    [custno]      VARCHAR (50)    NULL,
    [custname1]   VARCHAR (150)   NULL,
    [trantyp]     VARCHAR (6)     NULL,
    [invno]       INT             NOT NULL,
    [docdt]       DATETIME        NULL,
    [collection]  NUMERIC (16, 2) NULL,
    [anptrantyp]  VARCHAR (6)     NULL,
    [anpdocno]    INT             NULL,
    [doctyp]      SMALLINT        NULL,
    [balamnt]     NUMERIC (16, 2) NULL,
    [refrence]    VARCHAR (100)   NULL,
    [company]     CHAR (10)       NULL,
    [areaname]    VARCHAR (30)    NULL,
    [zone]        CHAR (30)       NULL,
    [region]      CHAR (30)       NULL,
    [global]      CHAR (20)       NULL,
    [description] CHAR (35)       NULL,
    [dpstname]    CHAR (35)       NULL
);


GO

