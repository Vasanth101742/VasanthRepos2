CREATE TABLE [dbo].[SalesQtyForecast_Daywise] (
    [Organ]        VARCHAR (50)   NULL,
    [Item]         VARCHAR (50)   NULL,
    [Item_desc]    VARCHAR (200)  NULL,
    [EntryDate]    DATE           NULL,
    [IndexDate]    DATE           NULL,
    [Qty]          NUMERIC (7, 2) NULL,
    [ModelName]    VARCHAR (50)   NULL,
    [Elapsed_mins] FLOAT (53)     NULL
);


GO

