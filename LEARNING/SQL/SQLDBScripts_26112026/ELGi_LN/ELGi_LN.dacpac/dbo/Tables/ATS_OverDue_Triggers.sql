CREATE TABLE [dbo].[ATS_OverDue_Triggers] (
    [company]     NVARCHAR (38) NULL,
    [LOT_NO]      NVARCHAR (38) NULL,
    [orno]        NVARCHAR (18) NULL,
    [ITEM]        NVARCHAR (94) NULL,
    [Description] NVARCHAR (60) NULL,
    [Tri_Dt]      DATE          NULL,
    [RPLT]        INT           NULL,
    [duedate]     DATE          NULL,
    [TYPE]        INT           NULL,
    [binqty]      FLOAT (53)    NULL,
    [sceduledqty] NVARCHAR (38) NULL,
    [DIVI]        NVARCHAR (38) NULL,
    [SUPERMARKET] VARCHAR (100) NULL,
    [DEPT]        NVARCHAR (38) NULL,
    [DEPARTMENT]  VARCHAR (50)  NULL,
    [SupplierNum] NVARCHAR (18) NULL,
    [NAMA]        NVARCHAR (70) NULL,
    [BUYR]        NVARCHAR (18) NULL,
    [empname]     NVARCHAR (50) NULL,
    [TYPE_DESC]   VARCHAR (50)  NULL,
    [PendingDays] INT           NULL,
    [TriggerType] VARCHAR (25)  NULL,
    [LGSC]        VARCHAR (25)  NULL,
    [DueTypeOrdr] INT           NULL,
    [DueType]     VARCHAR (50)  NULL,
    [DueSlabOrdr] INT           NULL,
    [DueSlab]     VARCHAR (50)  NULL
);


GO

