CREATE TABLE [dbo].[SalesQtyForecast_Daywise_Analysis] (
    [Organ]              VARCHAR (50)   NULL,
    [Item]               VARCHAR (50)   NULL,
    [Item_desc]          VARCHAR (200)  NULL,
    [EntryDate]          DATE           NULL,
    [IndexDate]          DATE           NULL,
    [Qty]                NUMERIC (7, 2) NULL,
    [ModelName]          VARCHAR (50)   NULL,
    [Elapsed_mins]       FLOAT (53)     NULL,
    [Rnk]                BIGINT         NULL,
    [DFUCode]            VARCHAR (50)   NULL,
    [ItemCategory]       VARCHAR (50)   NULL,
    [RRS_Classification] VARCHAR (50)   NULL
);


GO

