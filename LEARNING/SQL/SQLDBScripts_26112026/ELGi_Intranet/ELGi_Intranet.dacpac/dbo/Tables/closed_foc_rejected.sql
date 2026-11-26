CREATE TABLE [dbo].[closed_foc_rejected] (
    [trackno]  NVARCHAR (15)  NULL,
    [firno]    NVARCHAR (15)  NULL,
    [focno]    NVARCHAR (15)  NULL,
    [date_rej] DATETIME2 (0)  NULL,
    [pre_levl] BIGINT         NULL,
    [rej_levl] BIGINT         NULL,
    [rej_id]   NVARCHAR (MAX) NULL,
    [rej_comm] NVARCHAR (MAX) NULL,
    [rej_ip]   NVARCHAR (MAX) NULL
);


GO

