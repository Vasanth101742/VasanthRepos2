CREATE TABLE [dbo].[collaboration_items] (
    [Item_Code]                NVARCHAR (150) NULL,
    [Item_Description]         NVARCHAR (150) NULL,
    [Net_Unconstraint_Demand]  NVARCHAR (150) NULL,
    [Supplier_Constraint]      NVARCHAR (150) NULL,
    [Supplier_Name]            NVARCHAR (150) NULL,
    [Buyer_Name]               NVARCHAR (150) NULL,
    [Lean_NonLean]             NVARCHAR (150) NULL,
    [Product_Type]             NVARCHAR (150) NULL,
    [Stock_As_On_Date]         NVARCHAR (150) NULL,
    [Allocation_As_On_Date]    NVARCHAR (150) NULL,
    [Pending_Trigger_Qty]      NVARCHAR (150) NULL,
    [R_58_Demand]              NVARCHAR (150) NULL,
    [Avg_Consumption_3_months] NVARCHAR (150) NULL,
    [Total_bin_size_Bin_Slot]  NVARCHAR (150) NULL
);


GO

