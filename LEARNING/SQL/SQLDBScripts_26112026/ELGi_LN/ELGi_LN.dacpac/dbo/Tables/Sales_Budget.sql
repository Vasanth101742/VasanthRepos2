CREATE TABLE [dbo].[Sales_Budget] (
    [Dpst]                    VARCHAR (10)   NULL,
    [Date]                    DATETIME       NULL,
    [Target]                  FLOAT (53)     NULL,
    [Area]                    NVARCHAR (255) NULL,
    [SaleType]                INT            NULL,
    [HoTarget]                FLOAT (53)     NULL,
    [organ]                   VARCHAR (20)   NULL,
    [productgrp]              VARCHAR (25)   NULL,
    [Budget_USD]              FLOAT (53)     NULL,
    [Budget_Foreign_Currency] FLOAT (53)     NULL
);


GO

