CREATE TABLE [dbo].[alc_abnormality_month] (
    [alcmth_id]  INT             NULL,
    [pline]      DECIMAL (38)    NULL,
    [metrics]    NVARCHAR (5)    NULL,
    [abmonth]    DECIMAL (38)    NULL,
    [abyear]     DECIMAL (38)    NULL,
    [updated_by] NVARCHAR (10)   NULL,
    [updated_on] DATETIME2 (0)   NULL,
    [justify]    NVARCHAR (1000) NULL,
    [assembly]   NVARCHAR (15)   NULL
);


GO

