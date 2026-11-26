CREATE TABLE [dbo].[Regionwise_Collection_Plan] (
    [colplanid] INT           NULL,
    [industype] NVARCHAR (15) NULL,
    [region]    NVARCHAR (10) NULL,
    [custype]   NVARCHAR (8)  NULL,
    [od_ar]     FLOAT (53)    NULL,
    [od_pl]     FLOAT (53)    NULL,
    [ftm_ar]    FLOAT (53)    NULL,
    [ftm_pl]    FLOAT (53)    NULL,
    [nd_ar]     FLOAT (53)    NULL,
    [nd_pl]     FLOAT (53)    NULL,
    [monthy]    NVARCHAR (5)  NULL,
    [yearr]     NVARCHAR (5)  NULL,
    [frmdt]     DATETIME      NULL,
    [todt]      DATETIME      NULL,
    [updateby]  NVARCHAR (10) NULL,
    [updateon]  DATETIME      NULL,
    [status]    NVARCHAR (5)  NULL
);


GO

