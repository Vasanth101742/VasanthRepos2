CREATE TABLE [dbo].[qms_result_monitoring] (
    [rca_code]         NVARCHAR (10)  NULL,
    [slno]             INT            NULL,
    [characterization] NVARCHAR (MAX) NULL,
    [defect_character] NVARCHAR (MAX) NULL,
    [design_file]      NVARCHAR (100) NULL,
    [usr_id]           NVARCHAR (10)  NULL,
    [entry_date]       DATETIME2 (0)  NULL
);


GO

