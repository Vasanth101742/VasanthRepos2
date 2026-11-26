CREATE TABLE [dbo].[ats_collection_daywise_target] (
    [west_mkt_tgt]        FLOAT (53) NULL,
    [north_mkt_tgt]       FLOAT (53) NULL,
    [south_mkt_tgt]       FLOAT (53) NULL,
    [east_mkt_tgt]        FLOAT (53) NULL,
    [export_tgt]          FLOAT (53) NULL,
    [west_aftersale_tgt]  FLOAT (53) NULL,
    [north_aftersale_tgt] FLOAT (53) NULL,
    [south_aftersale_tgt] FLOAT (53) NULL,
    [east_aftersale_tgt]  FLOAT (53) NULL,
    [date]                DATETIME   NOT NULL
);


GO

