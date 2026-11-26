CREATE TABLE [dbo].[OPEN_COMPLAINT_CALLS_DRM] (
    [obligation]                NVARCHAR (255)   NULL,
    [Owner]                     NVARCHAR (200)   NULL,
    [msdyn_customerasset]       UNIQUEIDENTIFIER NULL,
    [msdyn_workorderid]         UNIQUEIDENTIFIER NULL,
    [ownerid]                   UNIQUEIDENTIFIER NULL,
    [Symptom]                   NVARCHAR (100)   NULL,
    [Branch]                    NVARCHAR (160)   NULL,
    [Vertical]                  NVARCHAR (255)   NULL,
    [tracking_No]               NVARCHAR (100)   NULL,
    [Customer]                  NVARCHAR (160)   NULL,
    [FabNo]                     NVARCHAR (100)   NULL,
    [Call_Logged_Date]          DATETIME         NULL,
    [First_visit_Date]          DATETIME         NULL,
    [Next_visit_Date]           DATETIME         NULL,
    [Over_Due_Hours]            INT              NULL,
    [Over_Due_Group]            VARCHAR (14)     NULL,
    [Dealer]                    NVARCHAR (160)   NULL,
    [Call_Type]                 NVARCHAR (100)   NULL,
    [Call_Status]               NVARCHAR (255)   NULL,
    [Logged_By]                 NVARCHAR (200)   NULL,
    [Comm_date]                 DATE             NULL,
    [service_engineer_comments] NVARCHAR (MAX)   NULL,
    [Product_Group]             NVARCHAR (100)   NULL,
    [Product_Sub_group]         NVARCHAR (100)   NULL,
    [Product_Model]             NVARCHAR (100)   NULL,
    [Zone]                      NVARCHAR (200)   NULL
);


GO

