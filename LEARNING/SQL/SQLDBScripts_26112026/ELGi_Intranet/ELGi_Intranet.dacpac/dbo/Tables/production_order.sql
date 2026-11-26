CREATE TABLE [dbo].[production_order] (
    [pdno]   INT           NULL,
    [pddt]   DATETIME2 (0) NULL,
    [icode]  NVARCHAR (16) NULL,
    [idesc]  NVARCHAR (30) NULL,
    [fabno]  NVARCHAR (10) NULL,
    [lotno]  INT           NULL,
    [aeslno] NVARCHAR (20) NULL,
    [meslno] NVARCHAR (20) NULL
);


GO

