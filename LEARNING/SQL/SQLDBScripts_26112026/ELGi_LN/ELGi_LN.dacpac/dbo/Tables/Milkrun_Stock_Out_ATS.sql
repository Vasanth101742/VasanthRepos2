CREATE TABLE [dbo].[Milkrun_Stock_Out_ATS] (
    [ITEM]         NVARCHAR (94) NULL,
    [Trig_Dt]      CHAR (30)     NULL,
    [Exp_DT]       CHAR (30)     NULL,
    [RPLT]         NVARCHAR (38) NULL,
    [SUPP]         NVARCHAR (18) NULL,
    [DIVI]         NVARCHAR (38) NULL,
    [BUYR]         NVARCHAR (18) NULL,
    [QTY]          NVARCHAR (38) NULL,
    [ID]           INT           NULL,
    [SUPERMARKET]  VARCHAR (100) NULL,
    [DEPARTMENT]   NCHAR (15)    NULL,
    [DEPT]         NVARCHAR (38) NULL,
    [group_leader] VARCHAR (1)   NOT NULL,
    [NAMA]         NVARCHAR (70) NULL,
    [Description]  NVARCHAR (60) NULL,
    [empname]      NVARCHAR (50) NULL,
    [Stock_DT]     CHAR (30)     NULL,
    [LOT_NO]       NVARCHAR (38) NULL,
    [company]      NVARCHAR (38) NULL,
    [status]       VARCHAR (1)   NOT NULL,
    [itemcount]    INT           NULL,
    [SLOQ]         NVARCHAR (38) NULL
);


GO

