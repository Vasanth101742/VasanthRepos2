CREATE TABLE [dbo].[DTA_reports_partitionfunction] (
    [PartitionFunctionID]         INT            IDENTITY (1, 1) NOT NULL,
    [DatabaseID]                  INT            NOT NULL,
    [PartitionFunctionName]       [sysname]      NOT NULL,
    [PartitionFunctionDefinition] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([PartitionFunctionID] ASC),
    FOREIGN KEY ([DatabaseID]) REFERENCES [dbo].[DTA_reports_database] ([DatabaseID]) ON DELETE CASCADE
);


GO

CREATE NONCLUSTERED INDEX [DTA_reports_partitionfunction_index]
    ON [dbo].[DTA_reports_partitionfunction]([DatabaseID] ASC);


GO

