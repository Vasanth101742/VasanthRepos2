CREATE TABLE [dbo].[OpenOrder] (
    [PONum]       NVARCHAR (255) NULL,
    [CustNum]     NVARCHAR (9)   NULL,
    [Item]        NVARCHAR (255) NULL,
    [Type]        BIGINT         NULL,
    [Desc]        NVARCHAR (255) NULL,
    [CustName]    NVARCHAR (255) NULL,
    [OrderDate]   DATETIME2 (7)  NULL,
    [OrderNum]    NVARCHAR (9)   NULL,
    [PosNum]      BIGINT         NULL,
    [SeqNum]      BIGINT         NULL,
    [ShipConstrt] BIGINT         NULL,
    [OrderedQTY]  NVARCHAR (76)  NULL,
    [RequestDate] DATETIME2 (7)  NULL,
    [PlannedDate] DATETIME2 (7)  NULL,
    [UnitPrice]   NVARCHAR (76)  NULL,
    [PendQTY]     NVARCHAR (76)  NULL,
    [ExtPrice]    NVARCHAR (76)  NULL,
    [compnr]      BIGINT         NULL
);


GO

