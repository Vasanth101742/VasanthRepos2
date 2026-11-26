CREATE TABLE [dbo].[ActivityParty_CRM] (
    [activityid]                   UNIQUEIDENTIFIER NULL,
    [activitypartyid]              UNIQUEIDENTIFIER NULL,
    [addressused]                  NVARCHAR (MAX)   NULL,
    [addressusedemailcolumnnumber] INT              NULL,
    [donotemail]                   BIT              NULL,
    [donotfax]                     BIT              NULL,
    [donotphone]                   BIT              NULL,
    [donotpostalmail]              BIT              NULL,
    [effort]                       FLOAT (53)       NULL,
    [exchangeentryid]              NVARCHAR (MAX)   NULL,
    [instancetypecode]             INT              NULL,
    [ispartydeleted]               BIT              NULL,
    [ownerid]                      UNIQUEIDENTIFIER NULL,
    [owneridtype]                  NVARCHAR (MAX)   NULL,
    [owningbusinessunit]           UNIQUEIDENTIFIER NULL,
    [owninguser]                   UNIQUEIDENTIFIER NULL,
    [participationtypemask]        INT              NULL,
    [partyid]                      UNIQUEIDENTIFIER NULL,
    [partyidname]                  NVARCHAR (MAX)   NULL,
    [partyobjecttypecode]          NVARCHAR (MAX)   NULL,
    [resourcespecid]               UNIQUEIDENTIFIER NULL,
    [resourcespecidname]           NVARCHAR (MAX)   NULL,
    [scheduledend]                 DATETIME2 (7)    NULL,
    [scheduledstart]               DATETIME2 (7)    NULL,
    [unresolvedpartyname]          NVARCHAR (MAX)   NULL,
    [versionnumber]                BIGINT           NULL
);


GO

