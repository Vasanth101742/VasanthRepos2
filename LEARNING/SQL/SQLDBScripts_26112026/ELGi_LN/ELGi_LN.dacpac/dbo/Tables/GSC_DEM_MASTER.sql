CREATE TABLE [dbo].[GSC_DEM_MASTER] (
    [3D Part Refer]                     NVARCHAR (255) NULL,
    [Item Code]                         NVARCHAR (255) NULL,
    [Description]                       NVARCHAR (255) NULL,
    [Supplier code]                     NVARCHAR (255) NULL,
    [Supplier Name]                     NVARCHAR (255) NULL,
    [Buyer Name]                        NVARCHAR (255) NULL,
    [District wise]                     NVARCHAR (255) NULL,
    [Region]                            NVARCHAR (255) NULL,
    [State]                             NVARCHAR (255) NULL,
    [Unit price]                        FLOAT (53)     NULL,
    [Revised_Procurement type]          NVARCHAR (255) NULL,
    [Revised Bin Qty_ ( 14th Dec 2022)] FLOAT (53)     NULL,
    [Slot]                              FLOAT (53)     NULL,
    [Bin Max]                           FLOAT (53)     NULL,
    [1#3 time slot]                     FLOAT (53)     NULL,
    [1#3 time bin value in Mn]          FLOAT (53)     NULL,
    [Bin Max + allocation]              FLOAT (53)     NULL,
    [Excess Stock]                      FLOAT (53)     NULL,
    [Excess stock value in Mn]          FLOAT (53)     NULL,
    [Month Demand]                      FLOAT (53)     NULL,
    [Lean / Non Lean]                   NVARCHAR (255) NULL,
    [Critical Part]                     NVARCHAR (255) NULL
);


GO

