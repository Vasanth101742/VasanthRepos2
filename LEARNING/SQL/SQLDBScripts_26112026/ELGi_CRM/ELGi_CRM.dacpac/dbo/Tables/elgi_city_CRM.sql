CREATE TABLE [dbo].[elgi_city_CRM] (
    [createdby]                  UNIQUEIDENTIFIER NULL,
    [createdbyname]              NVARCHAR (MAX)   NULL,
    [createdbyyominame]          NVARCHAR (MAX)   NULL,
    [createdon]                  DATETIME2 (7)    NULL,
    [createdonbehalfby]          UNIQUEIDENTIFIER NULL,
    [createdonbehalfbyname]      NVARCHAR (MAX)   NULL,
    [createdonbehalfbyyominame]  NVARCHAR (MAX)   NULL,
    [elgi_citycode]              NVARCHAR (MAX)   NULL,
    [elgi_cityid]                UNIQUEIDENTIFIER NULL,
    [elgi_name]                  NVARCHAR (MAX)   NULL,
    [elgi_state]                 UNIQUEIDENTIFIER NULL,
    [elgi_statename]             NVARCHAR (MAX)   NULL,
    [elgi_statetext]             NVARCHAR (MAX)   NULL,
    [importsequencenumber]       INT              NULL,
    [modifiedby]                 UNIQUEIDENTIFIER NULL,
    [modifiedbyname]             NVARCHAR (MAX)   NULL,
    [modifiedbyyominame]         NVARCHAR (MAX)   NULL,
    [modifiedon]                 DATETIME2 (7)    NULL,
    [modifiedonbehalfby]         UNIQUEIDENTIFIER NULL,
    [modifiedonbehalfbyname]     NVARCHAR (MAX)   NULL,
    [modifiedonbehalfbyyominame] NVARCHAR (MAX)   NULL,
    [organizationid]             UNIQUEIDENTIFIER NULL,
    [organizationidname]         NVARCHAR (MAX)   NULL,
    [overriddencreatedon]        DATETIME2 (7)    NULL,
    [statecode]                  INT              NULL,
    [statuscode]                 INT              NULL,
    [timezoneruleversionnumber]  INT              NULL,
    [utcconversiontimezonecode]  INT              NULL,
    [versionnumber]              BIGINT           NULL
);


GO

