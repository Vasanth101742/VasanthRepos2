CREATE TABLE [dbo].[OpeningOB] (
    [Region]       NVARCHAR (50) NOT NULL,
    [MonthYear]    DATETIME2 (7) NOT NULL,
    [OpeningOB]    FLOAT (53)    NOT NULL,
    [ProductGroup] NVARCHAR (50) NULL,
    [ItemCategory] NVARCHAR (50) NULL
);


GO

