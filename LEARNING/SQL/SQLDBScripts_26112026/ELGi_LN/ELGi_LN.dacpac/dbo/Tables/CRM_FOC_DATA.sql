CREATE TABLE [dbo].[CRM_FOC_DATA] (
    [elgi_focid]                   UNIQUEIDENTIFIER NULL,
    [elgi_focnumber]               NVARCHAR (100)   NULL,
    [elgi_foctypename]             NVARCHAR (255)   NULL,
    [elgi_workorderid]             UNIQUEIDENTIFIER NULL,
    [msdyn_product]                UNIQUEIDENTIFIER NULL,
    [elgi_foc]                     UNIQUEIDENTIFIER NULL,
    [elgi_customerasset]           UNIQUEIDENTIFIER NULL,
    [elgi_itemcode]                NVARCHAR (100)   NULL,
    [productid]                    UNIQUEIDENTIFIER NULL,
    [itemDesc]                     NVARCHAR (100)   NULL,
    [workorderno]                  NVARCHAR (100)   NULL,
    [logdate]                      DATETIME         NULL,
    [msdyn_workorderid]            UNIQUEIDENTIFIER NULL,
    [elgi_serviceengineercomments] NVARCHAR (MAX)   NULL,
    [fabno]                        NVARCHAR (100)   NULL,
    [Model]                        NVARCHAR (100)   NULL,
    [elgi_productgroupname]        NVARCHAR (100)   NULL,
    [msdyn_customerassetid]        UNIQUEIDENTIFIER NULL,
    [elgi_dateofcommissioning]     DATETIME         NULL,
    [RCA]                          NVARCHAR (100)   NULL,
    [elgi_workordernumberid]       UNIQUEIDENTIFIER NULL,
    [Symptom]                      NVARCHAR (100)   NULL,
    [elgi_complaintidentified]     NVARCHAR (1000)  NULL,
    [elgi_fix]                     NVARCHAR (1000)  NULL,
    [msdyn_incidenttypename]       NVARCHAR (100)   NULL,
    [msdyn_workorder]              UNIQUEIDENTIFIER NULL
);


GO

