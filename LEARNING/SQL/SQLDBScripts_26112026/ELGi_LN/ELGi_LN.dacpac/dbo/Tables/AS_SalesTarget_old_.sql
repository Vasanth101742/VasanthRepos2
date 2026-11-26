CREATE TABLE [dbo].[AS_SalesTarget_old\] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [WeekName]  NCHAR (20)      NOT NULL,
    [FromDate]  DATE            NOT NULL,
    [ToDate]    DATE            NOT NULL,
    [Region]    NCHAR (10)      NOT NULL,
    [PlanValue] DECIMAL (18, 2) NOT NULL,
    [MonthYear] NVARCHAR (10)   NOT NULL
);


GO

