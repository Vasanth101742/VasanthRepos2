CREATE TABLE [dbo].[StringMap_CRM] (
    [attributename]  NVARCHAR (MAX)   NULL,
    [attributevalue] INT              NULL,
    [displayorder]   INT              NULL,
    [langid]         INT              NULL,
    [objecttypecode] NVARCHAR (MAX)   NULL,
    [organizationid] UNIQUEIDENTIFIER NULL,
    [stringmapid]    UNIQUEIDENTIFIER NULL,
    [value]          NVARCHAR (MAX)   NULL,
    [versionnumber]  BIGINT           NULL
);


GO

