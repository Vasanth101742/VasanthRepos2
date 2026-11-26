CREATE TABLE [dbo].[DTA_reports_partitionscheme] (
    [PartitionSchemeID]         INT            IDENTITY (1, 1) NOT NULL,
    [PartitionFunctionID]       INT            NOT NULL,
    [PartitionSchemeName]       [sysname]      NOT NULL,
    [PartitionSchemeDefinition] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([PartitionSchemeID] ASC),
    FOREIGN KEY ([PartitionFunctionID]) REFERENCES [dbo].[DTA_reports_partitionfunction] ([PartitionFunctionID]) ON DELETE CASCADE
);


GO

CREATE NONCLUSTERED INDEX [DTA_reports_partitionscheme_index]
    ON [dbo].[DTA_reports_partitionscheme]([PartitionFunctionID] ASC);


GO

