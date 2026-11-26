CREATE TABLE [dbo].[Existing_ELGi_Customers] (
    [elgi_fabricationnumber]          NVARCHAR (MAX)   NULL,
    [elgi_lockindealer]               UNIQUEIDENTIFIER NULL,
    [accountid]                       UNIQUEIDENTIFIER NULL,
    [accountnumber]                   NVARCHAR (MAX)   NULL,
    [name]                            NVARCHAR (MAX)   NULL,
    [elgi_accounttypename]            NVARCHAR (25)    NULL,
    [elgi_productgroupname]           NVARCHAR (MAX)   NULL,
    [elgi_productsubgroupname]        NVARCHAR (MAX)   NULL,
    [msdyn_productname]               NVARCHAR (MAX)   NULL,
    [createdon]                       DATETIME2 (7)    NULL,
    [elgi_dateofcommissioning]        DATETIME2 (7)    NULL,
    [elgi_cityname]                   NVARCHAR (MAX)   NULL,
    [territoryidname]                 NVARCHAR (MAX)   NULL,
    [elgi_industrysize]               VARCHAR (50)     NULL,
    [elgi_industryname]               NVARCHAR (MAX)   NULL,
    [elgi_customerclassificationname] NVARCHAR (50)    NULL,
    [elgi_customergroupname]          NVARCHAR (50)    NULL,
    [elgi_isreferencename]            NVARCHAR (50)    NULL,
    [elgi_keycustomername]            NVARCHAR (10)    NULL,
    [elgi_oemcustomername]            NVARCHAR (50)    NULL,
    [Engineer]                        NVARCHAR (MAX)   NULL,
    [BusinessVertical]                VARCHAR (50)     NULL,
    [elgi_rsmname]                    VARCHAR (50)     NULL,
    [Rowno]                           INT              NULL,
    [elgi_lineofbusinessname]         VARCHAR (100)    NULL,
    [elgi_erpcustomercode]            NVARCHAR (100)   NULL
);


GO

