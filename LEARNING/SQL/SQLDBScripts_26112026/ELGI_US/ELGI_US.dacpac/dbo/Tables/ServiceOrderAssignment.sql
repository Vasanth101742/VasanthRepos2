CREATE TABLE [dbo].[ServiceOrderAssignment] (
    [company] NVARCHAR (255) NULL,
    [orgn]    BIGINT         NULL,
    [orgn_kw] NVARCHAR (255) NULL,
    [orno]    NVARCHAR (9)   NULL,
    [line]    BIGINT         NULL,
    [emno]    NVARCHAR (9)   NULL,
    [acln]    BIGINT         NULL,
    [stat_kw] NVARCHAR (255) NULL,
    [actm]    NVARCHAR (24)  NULL,
    [rjtm]    NVARCHAR (24)  NULL,
    [rejr]    NVARCHAR (6)   NULL,
    [astm]    NVARCHAR (24)  NULL,
    [aftm]    NVARCHAR (24)  NULL,
    [jctm]    NVARCHAR (24)  NULL,
    [pstm]    NVARCHAR (24)  NULL
);


GO

