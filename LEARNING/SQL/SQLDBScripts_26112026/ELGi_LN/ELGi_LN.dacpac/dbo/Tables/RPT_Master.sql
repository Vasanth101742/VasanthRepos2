CREATE TABLE [dbo].[RPT_Master] (
    [SNO]                              FLOAT (53)     NULL,
    [TransactionCategory_Order]        INT            NULL,
    [TransactionCategory]              NVARCHAR (255) NULL,
    [TransactionSubCategory_Order]     INT            NULL,
    [TransactionSubCategory]           NVARCHAR (255) NULL,
    [Type_of_RPT_SEBI_Format_Order]    FLOAT (53)     NULL,
    [Type_of_RPT_SEBI_Format]          NVARCHAR (255) NULL,
    [Details_of_other_RPT_SEBI_Format] NVARCHAR (255) NULL,
    [GL_Sub_level]                     FLOAT (53)     NULL,
    [GL_RANGE_FROM]                    NVARCHAR (255) NULL,
    [GL_RANGE_TO]                      NVARCHAR (255) NULL,
    [Remarks]                          NVARCHAR (255) NULL,
    [EffectiveFrom]                    DATE           NULL,
    [EffectiveTo]                      DATE           NULL
);


GO

