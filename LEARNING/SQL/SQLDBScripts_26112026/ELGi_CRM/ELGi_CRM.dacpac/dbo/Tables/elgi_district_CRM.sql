CREATE TABLE [dbo].[elgi_district_CRM] (
    [createdby]                  UNIQUEIDENTIFIER NULL,
    [createdbyname]              NVARCHAR (MAX)   NULL,
    [createdbyyominame]          NVARCHAR (MAX)   NULL,
    [createdon]                  DATETIME2 (7)    NULL,
    [createdonbehalfby]          UNIQUEIDENTIFIER NULL,
    [createdonbehalfbyname]      NVARCHAR (MAX)   NULL,
    [createdonbehalfbyyominame]  NVARCHAR (MAX)   NULL,
    [elgi_districtid]            UNIQUEIDENTIFIER NULL,
    [elgi_name]                  NVARCHAR (MAX)   NULL,
    [elgi_state]                 UNIQUEIDENTIFIER NULL,
    [elgi_statename]             NVARCHAR (MAX)   NULL,
    [importsequencenumber]       INT              NULL,
    [modifiedby]                 UNIQUEIDENTIFIER NULL,
    [modifiedbyname]             NVARCHAR (MAX)   NULL,
    [modifiedbyyominame]         NVARCHAR (MAX)   NULL,
    [modifiedon]                 DATETIME2 (7)    NULL,
    [modifiedonbehalfby]         UNIQUEIDENTIFIER NULL,
    [modifiedonbehalfbyname]     NVARCHAR (MAX)   NULL,
    [modifiedonbehalfbyyominame] NVARCHAR (MAX)   NULL,
    [overriddencreatedon]        DATETIME2 (7)    NULL,
    [ownerid]                    UNIQUEIDENTIFIER NULL,
    [owneridname]                NVARCHAR (MAX)   NULL,
    [owneridtype]                NVARCHAR (MAX)   NULL,
    [owneridyominame]            NVARCHAR (MAX)   NULL,
    [owningbusinessunit]         UNIQUEIDENTIFIER NULL,
    [owningteam]                 UNIQUEIDENTIFIER NULL,
    [owninguser]                 UNIQUEIDENTIFIER NULL,
    [statecode]                  INT              NULL,
    [statuscode]                 INT              NULL,
    [timezoneruleversionnumber]  INT              NULL,
    [utcconversiontimezonecode]  INT              NULL,
    [versionnumber]              BIGINT           NULL
);


GO

