CREATE TABLE [dbo].[Shipment_Details] (
    [compnr]   BIGINT         NULL,
    [ShipDate] DATETIME2 (7)  NULL,
    [shpm]     NVARCHAR (9)   NULL,
    [trnr]     NVARCHAR (255) NULL,
    [carr]     NVARCHAR (255) NULL,
    [Carrier]  NVARCHAR (255) NULL,
    [invnum]   NVARCHAR (255) NULL,
    [SO]       NVARCHAR (9)   NULL,
    [SOLin]    BIGINT         NULL,
    [PONum]    NVARCHAR (255) NULL,
    [CustNum]  NVARCHAR (9)   NULL,
    [Item]     NVARCHAR (255) NULL,
    [Type]     BIGINT         NULL,
    [Desc]     NVARCHAR (255) NULL,
    [qidl]     NVARCHAR (76)  NULL,
    [damt]     NVARCHAR (76)  NULL,
    [odat]     DATETIME2 (7)  NULL
);


GO

