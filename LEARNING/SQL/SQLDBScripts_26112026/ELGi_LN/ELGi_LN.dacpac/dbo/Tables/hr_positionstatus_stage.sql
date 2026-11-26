CREATE TABLE [dbo].[hr_positionstatus_stage] (
    [SlNo]                         FLOAT (53)     NULL,
    [PositionNo]                   NVARCHAR (255) NULL,
    [PositionDescription]          NVARCHAR (255) NULL,
    [Band]                         NVARCHAR (255) NULL,
    [Location]                     NVARCHAR (255) NULL,
    [Region]                       NVARCHAR (255) NULL,
    [Function]                     NVARCHAR (255) NULL,
    [Department]                   NVARCHAR (255) NULL,
    [Source]                       NVARCHAR (255) NULL,
    [New_or_Replacement]           NVARCHAR (255) NULL,
    [Left_or_Transferred_Emp_Name] NVARCHAR (255) NULL,
    [Left_or_Transferred_EmpNo]    NVARCHAR (255) NULL,
    [MPR_Requester]                NVARCHAR (255) NULL,
    [MPR_Status]                   NVARCHAR (255) NULL,
    [Position_Status]              NVARCHAR (255) NULL,
    [StartDate]                    DATETIME       NULL,
    [PlannedSLA_days]              FLOAT (53)     NULL,
    [EndDate]                      DATETIME       NULL,
    [DOJ_DOT]                      DATETIME       NULL,
    [ActualSLA_days]               FLOAT (53)     NULL,
    [Recruiter]                    NVARCHAR (255) NULL,
    [EmpNo]                        FLOAT (53)     NULL,
    [NewJoineeName]                NVARCHAR (255) NULL,
    [DOJ_DOT1]                     DATETIME       NULL,
    [OfferedCTC]                   NVARCHAR (255) NULL,
    [BudgetedCTC]                  FLOAT (53)     NULL,
    [DataLoadDate]                 DATE           NULL
);


GO

