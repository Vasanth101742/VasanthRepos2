CREATE TABLE [dbo].[bank_balance] (
    [COMPANY]  NVARCHAR (3)  NULL,
    [OTYP]     NVARCHAR (6)  NULL,
    [ODOC]     FLOAT (53)    NULL,
    [OLIN]     FLOAT (53)    NULL,
    [OCMP]     FLOAT (53)    NULL,
    [LEAC]     NVARCHAR (24) NULL,
    [DCDT]     DATETIME      NULL,
    [REFR]     NVARCHAR (64) NULL,
    [AMTH]     FLOAT (53)    NULL,
    [DBCR]     FLOAT (53)    NULL,
    [FPRD]     FLOAT (53)    NULL,
    [FYER]     FLOAT (53)    NULL,
    [CUNO]     NVARCHAR (18) NULL,
    [DATE]     DATETIME      NULL,
    [INTT]     FLOAT (53)    NULL,
    [FTYP]     NVARCHAR (6)  NULL,
    [FDOC]     FLOAT (53)    NULL,
    [CATG]     FLOAT (53)    NULL,
    [CONT]     FLOAT (53)    NULL,
    [CTYP]     NVARCHAR (6)  NULL,
    [CINV]     FLOAT (53)    NULL,
    [CORN]     FLOAT (53)    NULL,
    [CSRN]     FLOAT (53)    NULL,
    [TCSH]     FLOAT (53)    NULL,
    [TRAN]     FLOAT (53)    NULL,
    [DELE]     FLOAT (53)    NULL,
    [amnt]     FLOAT (53)    NULL,
    [ccur]     NVARCHAR (6)  NULL,
    [rate]     FLOAT (53)    NULL,
    [type]     INT           NULL,
    [fnd_leac] VARCHAR (12)  NULL
);


GO

