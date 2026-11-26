CREATE TABLE [dbo].[Itemwise_Budget] (
    [dpst]                    NUMERIC (5)     NULL,
    [date]                    VARCHAR (10)    NOT NULL,
    [target]                  NUMERIC (24, 8) NULL,
    [area]                    VARCHAR (50)    NULL,
    [item_code]               VARCHAR (50)    NULL,
    [qty]                     INT             NULL,
    [Budget_USD]              FLOAT (53)      NULL,
    [Budget_Foreign_Currency] FLOAT (53)      NULL
);


GO

