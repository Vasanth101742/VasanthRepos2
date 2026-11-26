CREATE TABLE [dbo].[rca_analysis] (
    [rca_code]     NVARCHAR (10)   NULL,
    [ceyy]         NVARCHAR (1)    NULL,
    [slno]         INT             NULL,
    [subfailure]   NVARCHAR (500)  NULL,
    [potential]    NVARCHAR (500)  NULL,
    [resparea]     NVARCHAR (20)   NULL,
    [category]     NVARCHAR (10)   NULL,
    [vmethod]      NVARCHAR (1000) NULL,
    [vtype]        NVARCHAR (1)    NULL,
    [result]       NVARCHAR (1000) NULL,
    [usr_id]       NVARCHAR (10)   NULL,
    [entry_date]   DATETIME2 (0)   NULL,
    [confirmed]    NVARCHAR (1)    NULL,
    [session]      NVARCHAR (32)   NULL,
    [extcntl]      NVARCHAR (1000) NULL,
    [mod_design]   NVARCHAR (1000) NULL,
    [mod_process]  NVARCHAR (1000) NULL,
    [mod_supplier] NVARCHAR (1000) NULL,
    [mod_operator] NVARCHAR (1000) NULL,
    [mod_machine]  NVARCHAR (1000) NULL
);


GO

