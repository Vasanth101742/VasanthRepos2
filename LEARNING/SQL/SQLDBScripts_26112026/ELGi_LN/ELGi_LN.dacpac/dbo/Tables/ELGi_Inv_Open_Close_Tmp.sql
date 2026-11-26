CREATE TABLE [dbo].[ELGi_Inv_Open_Close_Tmp] (
    [COMPANY]         NVARCHAR (38) NULL,
    [CWAR]            NVARCHAR (12) NULL,
    [ITEM]            NVARCHAR (94) NULL,
    [Date1]           DATETIME      NULL,
    [ORNO]            NVARCHAR (18) NULL,
    [KOOR_R]          NVARCHAR (38) NULL,
    [QSTK_R]          FLOAT (53)    NULL,
    [QSKT_R]          FLOAT (53)    NULL,
    [KOOR_I]          VARCHAR (50)  NULL,
    [QSTK_I]          FLOAT (53)    NULL,
    [Datasource]      VARCHAR (50)  NULL,
    [item_desc]       VARCHAR (100) NULL,
    [R_Amnt]          FLOAT (53)    NULL,
    [SEQN]            FLOAT (53)    NULL,
    [INWP]            FLOAT (53)    NULL,
    [I_Amnt]          FLOAT (53)    NULL,
    [Rnk]             BIGINT        NULL,
    [Variant]         VARCHAR (255) NULL,
    [R_Amnt2]         FLOAT (53)    NULL,
    [R_Amnt3]         FLOAT (53)    NULL,
    [SERN]            NVARCHAR (38) NULL,
    [LGDT]            DATE          NULL,
    [KITM]            VARCHAR (20)  NULL,
    [R_Amnt4]         FLOAT (53)    NULL,
    [FrtRate]         FLOAT (53)    NULL,
    [I_Amnt2]         FLOAT (53)    NULL,
    [I_Amnt3]         FLOAT (53)    NULL,
    [I_Amnt4]         FLOAT (53)    NULL,
    [UOM]             VARCHAR (25)  NULL,
    [Domestic_Import] VARCHAR (25)  NULL
);


GO

