CREATE TABLE [dbo].[ATS_OverDue_Triggers_Tmp1] (
    [TYPE]                           VARCHAR (13)  NULL,
    [Tri_Dt]                         DATE          NULL,
    [RPLT]                           INT           NULL,
    [No_of_nat_holidays]             INT           NULL,
    [duedate]                        DATE          NULL,
    [duedate_excluding_all_holidays] DATETIME      NULL,
    [Exp_Dt]                         DATE          NULL,
    [no_of_days]                     INT           NULL,
    [PendingDays]                    INT           NULL,
    [DIVI]                           NVARCHAR (38) NULL,
    [DEPT]                           NVARCHAR (38) NULL,
    [binqty]                         NVARCHAR (38) NULL,
    [sceduledqty]                    NVARCHAR (38) NULL,
    [DEPARTMENT]                     VARCHAR (50)  NULL,
    [SUPERMARKET]                    VARCHAR (100) NULL,
    [BUYR]                           NVARCHAR (18) NULL,
    [empname]                        NVARCHAR (50) NULL,
    [SupplierNum]                    NVARCHAR (18) NULL,
    [NAMA]                           NVARCHAR (70) NULL,
    [ID]                             INT           NULL,
    [ITEM]                           NVARCHAR (94) NULL,
    [Description]                    NVARCHAR (60) NULL,
    [LOT_NO]                         NVARCHAR (38) NULL,
    [orno]                           NVARCHAR (18) NULL,
    [company]                        NVARCHAR (38) NULL
);


GO

