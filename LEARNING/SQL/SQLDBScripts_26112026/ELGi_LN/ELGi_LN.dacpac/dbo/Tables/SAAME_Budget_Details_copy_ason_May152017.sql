CREATE TABLE [dbo].[SAAME_Budget_Details_copy_ason_May152017] (
    [dpst]         NUMERIC (5)   NULL,
    [tplnumbernew] VARCHAR (16)  NULL,
    [tplnumber]    VARCHAR (16)  NULL,
    [tplname]      VARCHAR (60)  NULL,
    [dates]        VARCHAR (10)  NULL,
    [bud_qty]      BIGINT        NULL,
    [bud_value]    BIGINT        NULL,
    [curr]         VARCHAR (3)   NULL,
    [region]       VARCHAR (150) NOT NULL,
    [areaname]     VARCHAR (30)  NULL,
    [user_names]   VARCHAR (250) NOT NULL,
    [curr_val]     BIGINT        NULL,
    [bud_values]   FLOAT (53)    NULL,
    [bud_price]    FLOAT (53)    NULL
);


GO

