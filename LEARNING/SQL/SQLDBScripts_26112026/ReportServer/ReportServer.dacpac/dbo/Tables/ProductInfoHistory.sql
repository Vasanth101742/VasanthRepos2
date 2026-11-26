CREATE TABLE [dbo].[ProductInfoHistory] (
    [DateTime]     DATETIME      DEFAULT (getdate()) NULL,
    [DbSchemaHash] VARCHAR (128) NOT NULL,
    [Sku]          VARCHAR (25)  NOT NULL,
    [BuildNumber]  VARCHAR (25)  NOT NULL,
    CONSTRAINT [IX_ProductInfoHistory_DateTime] UNIQUE NONCLUSTERED ([DateTime] ASC)
);


GO

