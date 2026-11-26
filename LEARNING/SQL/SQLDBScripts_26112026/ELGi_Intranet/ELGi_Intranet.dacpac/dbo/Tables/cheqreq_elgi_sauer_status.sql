CREATE TABLE [dbo].[cheqreq_elgi_sauer_status] (
    [reqno]     INT            NULL,
    [appr_code] INT            NULL,
    [level]     FLOAT (53)     NULL,
    [status]    NVARCHAR (15)  NULL,
    [appr_date] DATETIME2 (0)  NULL,
    [appr_time] TIME (0)       NULL,
    [response]  NVARCHAR (MAX) NULL,
    [due]       NVARCHAR (1)   NULL
);


GO

