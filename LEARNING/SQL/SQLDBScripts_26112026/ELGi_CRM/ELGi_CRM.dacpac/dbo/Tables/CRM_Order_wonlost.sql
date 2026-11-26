CREATE TABLE [dbo].[CRM_Order_wonlost] (
    [statuscodename]        NVARCHAR (255)   NULL,
    [opportunityid]         UNIQUEIDENTIFIER NULL,
    [elgi_enquiryid]        NVARCHAR (100)   NULL,
    [elgi_customervisitid]  NVARCHAR (100)   NULL,
    [elgi_losttoname]       NVARCHAR (255)   NULL,
    [elgi_reason]           INT              NULL,
    [elgi_reasonname]       NVARCHAR (255)   NULL,
    [elgi_buyingreasonname] NVARCHAR (255)   NULL
);


GO

