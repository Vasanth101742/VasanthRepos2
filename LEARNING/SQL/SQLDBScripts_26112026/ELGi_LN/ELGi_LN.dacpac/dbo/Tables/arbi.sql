CREATE TABLE [dbo].[arbi] (
    [cmp]      NVARCHAR (50)   NULL,
    [cuno]     NVARCHAR (50)   NULL,
    [area]     NVARCHAR (50)   NULL,
    [dpst]     NVARCHAR (50)   NULL,
    [invpre]   NVARCHAR (50)   NULL,
    [invno]    NVARCHAR (50)   NULL,
    [docdt]    NVARCHAR (50)   NULL,
    [currency] NVARCHAR (50)   NULL,
    [invamt]   NUMERIC (28, 6) NULL,
    [recvamt]  NUMERIC (28, 6) NULL,
    [amtout]   NUMERIC (28, 6) NULL,
    [duedate]  NVARCHAR (50)   NULL,
    [docdd]    SMALLINT        NULL,
    [docmm]    SMALLINT        NULL,
    [docyy]    SMALLINT        NULL,
    [duedd]    SMALLINT        NULL,
    [duemm]    SMALLINT        NULL,
    [dueyy]    SMALLINT        NULL,
    [updt]     DATETIME        NULL
);


GO

