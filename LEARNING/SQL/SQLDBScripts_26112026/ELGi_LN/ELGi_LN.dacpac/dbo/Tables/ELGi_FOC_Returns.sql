CREATE TABLE [dbo].[ELGi_FOC_Returns] (
    [company]       INT           NULL,
    [saleordertype] NVARCHAR (6)  NULL,
    [orderno]       NVARCHAR (9)  NULL,
    [trantype]      NVARCHAR (3)  NULL,
    [invoice]       INT           NULL,
    [custcode]      NVARCHAR (9)  NULL,
    [item]          NVARCHAR (47) NULL,
    [sales_amount]  FLOAT (53)    NULL
);


GO

