CREATE TABLE [dbo].[foc_other_charge_details] (
    [focno]       NVARCHAR (15)  NULL,
    [engr_code]   NVARCHAR (10)  NULL,
    [charge_type] NVARCHAR (15)  NULL,
    [amount]      FLOAT (53)     NULL,
    [file_name]   NVARCHAR (MAX) NULL,
    [added_on]    DATETIME2 (0)  NULL,
    [confirm]     NVARCHAR (1)   NULL,
    [trackno]     NVARCHAR (15)  NULL,
    [firno]       NVARCHAR (15)  NULL,
    [session_id]  NVARCHAR (75)  NULL
);


GO

