CREATE TABLE [dbo].[US_GR_CRM_PRODUCT] (
    [id]               INT             NULL,
    [create_uid]       INT             NULL,
    [create_date]      DATETIME2 (6)   NULL,
    [write_date]       DATETIME2 (6)   NULL,
    [write_uid]        INT             NULL,
    [ean13]            NVARCHAR (13)   NULL,
    [color]            INT             NULL,
    [image]            VARBINARY (MAX) NULL,
    [price_extra]      NUMERIC (28, 6) NULL,
    [default_code]     NVARCHAR (64)   NULL,
    [name_template]    NVARCHAR (128)  NULL,
    [active]           VARCHAR (5)     NULL,
    [variants]         NVARCHAR (64)   NULL,
    [image_medium]     VARBINARY (MAX) NULL,
    [image_small]      VARBINARY (MAX) NULL,
    [product_tmpl_id]  INT             NULL,
    [price_margin]     NUMERIC (28, 6) NULL,
    [track_outgoing]   VARCHAR (5)     NULL,
    [track_incoming]   VARCHAR (5)     NULL,
    [valuation]        NVARCHAR (255)  NULL,
    [track_production] VARCHAR (5)     NULL,
    [hr_expense_ok]    VARCHAR (5)     NULL
);


GO

