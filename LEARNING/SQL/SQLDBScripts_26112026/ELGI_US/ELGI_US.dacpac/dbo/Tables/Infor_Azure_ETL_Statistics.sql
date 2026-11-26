CREATE TABLE [dbo].[Infor_Azure_ETL_Statistics] (
    [Jobid]             VARCHAR (20) NULL,
    [JobName]           VARCHAR (50) NULL,
    [TableName]         VARCHAR (50) NULL,
    [SourceRows]        INT          NULL,
    [StageRows]         INT          NULL,
    [DestRows]          INT          NULL,
    [ActualDataPercent] FLOAT (53)   NULL,
    [StartTime1]        DATETIME     NULL,
    [EndTime1]          DATETIME     NULL,
    [StartTime2]        DATETIME     NULL,
    [EndTime2]          DATETIME     NULL,
    [ETLDate]           DATE         NULL
);


GO

