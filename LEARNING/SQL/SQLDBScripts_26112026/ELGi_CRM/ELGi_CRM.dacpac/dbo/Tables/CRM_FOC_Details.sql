CREATE TABLE [dbo].[CRM_FOC_Details] (
    [elgi_workorderid]       UNIQUEIDENTIFIER NULL,
    [elgi_focid]             UNIQUEIDENTIFIER NULL,
    [msdyn_customerassetid]  UNIQUEIDENTIFIER NULL,
    [msdyn_incidenttypename] NVARCHAR (100)   NULL,
    [IncidentDate]           DATETIME         NULL,
    [elgi_aonumber]          NVARCHAR (10)    NULL,
    [elgi_ordertypename]     NVARCHAR (255)   NULL,
    [invoiceid]              UNIQUEIDENTIFIER NULL,
    [elgi_focnumber]         NVARCHAR (100)   NULL,
    [elgi_foctypename]       NVARCHAR (255)   NULL,
    [elgi_customer]          UNIQUEIDENTIFIER NULL,
    [FOC_CreationDate]       DATETIME         NULL,
    [WO_CreationDate]        DATETIME         NULL,
    [workorderno]            NVARCHAR (100)   NULL,
    [Fabno]                  NVARCHAR (100)   NULL,
    [Model]                  NVARCHAR (100)   NULL,
    [Product]                NVARCHAR (100)   NULL,
    [CommissionDate]         DATETIME         NULL,
    [Symptom]                NVARCHAR (100)   NULL,
    [ProblemIdentified]      NVARCHAR (1000)  NULL,
    [Fix]                    NVARCHAR (1000)  NULL,
    [SE_Comments]            NVARCHAR (MAX)   NULL,
    [FOC_ModifiedDate]       DATETIME         NULL
);


GO

