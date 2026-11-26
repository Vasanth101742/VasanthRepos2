CREATE TABLE [dbo].[Itemwise_Budget_bkp_30OCT2019] (
    [dpst]                    NUMERIC (5)     NULL,
    [date]                    VARCHAR (10)    NOT NULL,
    [target]                  NUMERIC (24, 8) NULL,
    [area]                    VARCHAR (3)     NULL,
    [item_code]               VARCHAR (16)    NULL,
    [qty]                     INT             NULL,
    [Budget_USD]              FLOAT (53)      NULL,
    [Budget_Foreign_Currency] FLOAT (53)      NULL
);


GO

