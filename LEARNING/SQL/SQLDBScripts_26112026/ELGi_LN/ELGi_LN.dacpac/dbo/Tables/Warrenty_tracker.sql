CREATE TABLE [dbo].[Warrenty_tracker] (
    [Log_Date]         DATE           NULL,
    [ccstrackno]       NVARCHAR (15)  NULL,
    [focno]            NVARCHAR (15)  NULL,
    [fabno]            NVARCHAR (100) NULL,
    [Model]            NVARCHAR (100) NULL,
    [Custname]         NVARCHAR (MAX) NULL,
    [partcode]         NVARCHAR (MAX) NULL,
    [Part_desc]        NVARCHAR (MAX) NULL,
    [Itemqty]          INT            NULL,
    [Item_price]       FLOAT (53)     NULL,
    [Mileage_Cost]     FLOAT (53)     NULL,
    [Labour_cost]      FLOAT (53)     NULL,
    [Misc_cost]        FLOAT (53)     NULL,
    [Qty]              INT            NULL,
    [Trips]            INT            NULL,
    [Freight_cost]     FLOAT (53)     NULL,
    [total_item_price] FLOAT (53)     NULL,
    [rno]              BIGINT         NULL,
    [new_Mileage_Cost] FLOAT (53)     NULL,
    [new_Labour_cost]  FLOAT (53)     NULL,
    [new_Misc_cost]    FLOAT (53)     NULL,
    [new_Qty]          INT            NULL,
    [new_Trips]        INT            NULL,
    [new_Freight_cost] FLOAT (53)     NULL,
    [total]            FLOAT (53)     NULL,
    [Approve_id]       VARCHAR (100)  NULL,
    [Status]           VARCHAR (100)  NULL
);


GO

