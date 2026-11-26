CREATE TABLE [dbo].[invoice] (
    [ID]                   INT           IDENTITY (1, 1) NOT NULL,
    [companycode]          NVARCHAR (50) NULL,
    [transaction_type]     NVARCHAR (50) NULL,
    [invoice_no]           NVARCHAR (50) NULL,
    [sold_to_partner_code] NVARCHAR (50) NULL,
    [sold_to_partner_name] NVARCHAR (50) NULL,
    [ship_to_partner_code] NVARCHAR (50) NULL,
    [ship_to_partner_name] NVARCHAR (50) NULL,
    [invoice_amount]       NVARCHAR (50) NULL,
    [currency]             NVARCHAR (50) NULL,
    [country]              NVARCHAR (50) NULL,
    [createdon]            NVARCHAR (50) NULL,
    [refnumber]            NVARCHAR (50) NULL,
    [paymentstatus]        NVARCHAR (50) NULL
);


GO

