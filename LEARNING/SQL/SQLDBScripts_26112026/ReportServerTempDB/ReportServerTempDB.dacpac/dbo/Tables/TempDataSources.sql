CREATE TABLE [dbo].[TempDataSources] (
    [DSID]                                 UNIQUEIDENTIFIER NOT NULL,
    [ItemID]                               UNIQUEIDENTIFIER NOT NULL,
    [Name]                                 NVARCHAR (260)   NULL,
    [Extension]                            NVARCHAR (260)   NULL,
    [Link]                                 UNIQUEIDENTIFIER NULL,
    [CredentialRetrieval]                  INT              NULL,
    [Prompt]                               NTEXT            NULL,
    [ConnectionString]                     IMAGE            NULL,
    [OriginalConnectionString]             IMAGE            NULL,
    [OriginalConnectStringExpressionBased] BIT              NULL,
    [UserName]                             IMAGE            NULL,
    [Password]                             IMAGE            NULL,
    [Flags]                                INT              NULL,
    [Version]                              INT              NOT NULL,
    CONSTRAINT [PK_DataSource] PRIMARY KEY CLUSTERED ([DSID] ASC),
    CONSTRAINT [FK_DataSourceItemID] FOREIGN KEY ([ItemID]) REFERENCES [dbo].[TempCatalog] ([TempCatalogID])
);


GO

CREATE NONCLUSTERED INDEX [IX_DataSourceItemID]
    ON [dbo].[TempDataSources]([ItemID] ASC);


GO

