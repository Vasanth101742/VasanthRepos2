CREATE TABLE [dbo].[Lean_Stock_Out_History] (
    [company]      NVARCHAR (38) NULL,
    [ITEM]         NVARCHAR (94) NULL,
    [Trig_Dt]      DATETIME      NULL,
    [Exp_DT]       DATE          NULL,
    [DUDT]         DATETIME      NULL,
    [RPLT]         NVARCHAR (38) NULL,
    [SUPP]         NVARCHAR (18) NULL,
    [DIVI]         NVARCHAR (38) NULL,
    [BUYR]         NVARCHAR (18) NULL,
    [QTY]          NVARCHAR (38) NULL,
    [SOPS]         INT           NULL,
    [SUPERMARKET]  VARCHAR (100) NULL,
    [DEPARTMENT]   NCHAR (15)    NULL,
    [DEPT]         NVARCHAR (38) NULL,
    [group_leader] VARCHAR (50)  NULL,
    [NAMA]         NVARCHAR (70) NULL,
    [Description]  VARCHAR (100) NULL,
    [empname]      NVARCHAR (50) NULL,
    [Stock_DT]     DATE          NULL,
    [LOT_NO]       NVARCHAR (38) NULL,
    [SOPS_DESC]    VARCHAR (50)  NULL,
    [Trig_Flag]    BIT           NULL,
    [Stock_Flag]   BIT           NULL,
    [EntryDate]    DATETIME      NULL
);


GO

