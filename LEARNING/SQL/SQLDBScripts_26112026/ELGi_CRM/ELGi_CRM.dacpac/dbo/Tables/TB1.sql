CREATE TABLE [dbo].[TB1] (
    [parentsystemuserid]        UNIQUEIDENTIFIER NULL,
    [systemuserid]              UNIQUEIDENTIFIER NULL,
    [fullname]                  NVARCHAR (200)   NULL,
    [employeeid]                NVARCHAR (100)   NULL,
    [positionidname]            NVARCHAR (100)   NULL,
    [isdisabledname]            NVARCHAR (255)   NULL,
    [level]                     INT              NULL,
    [territoryidname]           NVARCHAR (200)   NULL,
    [businessunitidname]        NVARCHAR (160)   NULL,
    [elgi_businessverticalname] NVARCHAR (255)   NULL,
    [address1_city]             NVARCHAR (128)   NULL,
    [internalemailaddress]      NVARCHAR (100)   NULL
);


GO

