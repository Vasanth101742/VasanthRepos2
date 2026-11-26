CREATE TABLE [dbo].[LogSizeAlert] (
    [DatabaseName] [sysname]       NOT NULL,
    [LogSizeGB]    DECIMAL (18, 2) NULL,
    [AlertTime]    DATETIME        DEFAULT (getdate()) NULL
);


GO

