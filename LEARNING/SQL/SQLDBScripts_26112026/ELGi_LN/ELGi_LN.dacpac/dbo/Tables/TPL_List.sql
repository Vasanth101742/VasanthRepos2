CREATE TABLE [dbo].[TPL_List] (
    [TPL]             NVARCHAR (50)  NOT NULL,
    [prod_segment]    NVARCHAR (50)  NOT NULL,
    [prod_series]     NVARCHAR (50)  NOT NULL,
    [feature_variant] NVARCHAR (50)  NULL,
    [Capacity]        MONEY          NULL,
    [kW]              NVARCHAR (50)  NULL,
    [TPL_Description] NVARCHAR (100) NULL
);


GO

