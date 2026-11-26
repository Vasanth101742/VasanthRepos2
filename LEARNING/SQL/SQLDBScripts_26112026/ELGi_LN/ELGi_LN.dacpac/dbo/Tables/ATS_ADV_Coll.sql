CREATE TABLE [dbo].[ATS_ADV_Coll] (
    [Company]      INT           NULL,
    [t_docd]       DATE          NULL,
    [t_ttyp]       NVARCHAR (6)  NULL,
    [t_ninv]       INT           NULL,
    [t_tdoc]       NVARCHAR (6)  NULL,
    [t_docn]       INT           NULL,
    [t_trec]       INT           NULL,
    [DPSTCode]     NVARCHAR (12) NULL,
    [DPSTName]     VARCHAR (100) NULL,
    [AreaCode]     VARCHAR (10)  NULL,
    [AreaName]     VARCHAR (50)  NULL,
    [ZONE]         VARCHAR (50)  NULL,
    [t_amth_1]     FLOAT (53)    NULL,
    [Description]  VARCHAR (50)  NULL,
    [Zone_ordr]    INT           NULL,
    [Recpt_Type]   VARCHAR (50)  NULL,
    [CustCode]     VARCHAR (50)  NULL,
    [CustName]     VARCHAR (150) NULL,
    [DPSTType]     VARCHAR (50)  NULL,
    [DPSTTypeOrdr] INT           NULL
);


GO

