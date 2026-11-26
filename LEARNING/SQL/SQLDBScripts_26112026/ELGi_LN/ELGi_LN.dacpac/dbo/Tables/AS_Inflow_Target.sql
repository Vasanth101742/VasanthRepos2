CREATE TABLE [dbo].[AS_Inflow_Target] (
    [ID]        INT             IDENTITY (1, 1) NOT NULL,
    [WeekName]  NVARCHAR (15)   NOT NULL,
    [FromDate]  DATE            NOT NULL,
    [ToDate]    DATE            NOT NULL,
    [MonthYear] NCHAR (10)      NOT NULL,
    [Region]    NVARCHAR (15)   NOT NULL,
    [Plan]      DECIMAL (18, 2) NOT NULL,
    [BdgTot]    DECIMAL (19, 2) DEFAULT ((0)) NULL
);


GO

