CREATE TABLE [dbo].[Procedure_RunStatus] (
    [StoredProcedure] VARCHAR (24) NOT NULL,
    [Remarks]         VARCHAR (50) NULL,
    [StartTime]       DATETIME     NULL,
    [EndTime]         DATETIME     NULL,
    [Seconds]         INT          NULL,
    [Duration]        VARCHAR (71) NOT NULL
);


GO

