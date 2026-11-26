CREATE TABLE [dbo].[INTERIM_UNMATCHED] (
    [Company]   VARCHAR (30)  NULL,
    [Type]      VARCHAR (6)   NOT NULL,
    [T$LINK]    NVARCHAR (44) NULL,
    [T$LEAC]    VARCHAR (30)  NULL,
    [T$RBON]    VARCHAR (30)  NULL,
    [T$RBID]    VARCHAR (30)  NULL,
    [T$TTYP]    VARCHAR (30)  NULL,
    [T$DOCN]    VARCHAR (30)  NULL,
    [T$FYER]    VARCHAR (30)  NULL,
    [T$FPRD]    VARCHAR (30)  NULL,
    [Value]     FLOAT (53)    NULL,
    [leac_desc] NVARCHAR (60) NULL
);


GO

