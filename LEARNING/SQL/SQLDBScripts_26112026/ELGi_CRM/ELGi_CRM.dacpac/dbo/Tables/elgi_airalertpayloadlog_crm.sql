CREATE TABLE [dbo].[elgi_airalertpayloadlog_crm] (
    [createdby]                  UNIQUEIDENTIFIER NULL,
    [createdbyname]              NVARCHAR (MAX)   NULL,
    [createdbyyominame]          NVARCHAR (MAX)   NULL,
    [createdon]                  DATETIME2 (7)    NULL,
    [createdonbehalfby]          UNIQUEIDENTIFIER NULL,
    [createdonbehalfbyname]      NVARCHAR (MAX)   NULL,
    [createdonbehalfbyyominame]  NVARCHAR (MAX)   NULL,
    [elgi_airalertcreateddate]   NVARCHAR (MAX)   NULL,
    [elgi_airalertpayloadlogid]  UNIQUEIDENTIFIER NULL,
    [elgi_alerttype]             NVARCHAR (MAX)   NULL,
    [elgi_fabnumber]             NVARCHAR (MAX)   NULL,
    [elgi_faultmessage]          NVARCHAR (MAX)   NULL,
    [elgi_isemailsend]           NVARCHAR (MAX)   NULL,
    [elgi_name]                  NVARCHAR (MAX)   NULL,
    [elgi_payload]               NVARCHAR (MAX)   NULL,
    [elgi_username]              NVARCHAR (MAX)   NULL,
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

