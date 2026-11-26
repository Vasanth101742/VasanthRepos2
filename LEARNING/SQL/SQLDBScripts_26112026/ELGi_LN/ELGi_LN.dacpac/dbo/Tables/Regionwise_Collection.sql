CREATE TABLE [dbo].[Regionwise_Collection] (
    [Company]          INT            NULL,
    [TranType]         NVARCHAR (6)   NULL,
    [InvNo]            INT            NULL,
    [CustCode]         NVARCHAR (18)  NULL,
    [CustName]         NVARCHAR (100) NULL,
    [SalesOffice]      VARCHAR (20)   NULL,
    [SalesOfficeName]  VARCHAR (50)   NULL,
    [AreaCode]         VARCHAR (10)   NULL,
    [AreaName]         VARCHAR (50)   NULL,
    [Zone]             VARCHAR (50)   NULL,
    [EntryDate]        DATE           NULL,
    [DueDate]          DATE           NULL,
    [CustType]         VARCHAR (7)    NOT NULL,
    [Category]         VARCHAR (3)    NULL,
    [ZoneOrdr]         INT            NULL,
    [BusinessVertical] VARCHAR (11)   NULL,
    [RecvAmth]         FLOAT (53)     NULL,
    [VerticalOrdr]     INT            NULL,
    [Vertical]         VARCHAR (50)   NULL,
    [CalYear]          INT            NULL,
    [CalMonth]         INT            NULL,
    [Rnk1]             BIGINT         NULL,
    [AR]               FLOAT (53)     NULL,
    [Coll_Plan]        FLOAT (53)     NULL,
    [CategoryOrdr]     INT            NULL
);


GO

