CREATE TABLE [dbo].[DTA_reports_index] (
    [IndexID]            INT             IDENTITY (1, 1) NOT NULL,
    [TableID]            INT             NOT NULL,
    [IndexName]          [sysname]       NOT NULL,
    [IsClustered]        BIT             DEFAULT ((0)) NOT NULL,
    [IsUnique]           BIT             DEFAULT ((0)) NOT NULL,
    [IsHeap]             BIT             DEFAULT ((1)) NOT NULL,
    [IsExisting]         BIT             DEFAULT ((1)) NOT NULL,
    [IsFiltered]         BIT             DEFAULT ((0)) NOT NULL,
    [Storage]            FLOAT (53)      NOT NULL,
    [NumRows]            BIGINT          NOT NULL,
    [IsRecommended]      BIT             DEFAULT ((0)) NOT NULL,
    [RecommendedStorage] FLOAT (53)      NOT NULL,
    [PartitionSchemeID]  INT             NULL,
    [SessionUniquefier]  INT             NULL,
    [FilterDefinition]   NVARCHAR (1024) NOT NULL,
    PRIMARY KEY CLUSTERED ([IndexID] ASC),
    FOREIGN KEY ([TableID]) REFERENCES [dbo].[DTA_reports_table] ([TableID]) ON DELETE CASCADE
);


GO

CREATE NONCLUSTERED INDEX [DTA_reports_indexindex2]
    ON [dbo].[DTA_reports_index]([PartitionSchemeID] ASC);


GO

CREATE NONCLUSTERED INDEX [DTA_reports_indexindex]
    ON [dbo].[DTA_reports_index]([TableID] ASC);


GO

