CREATE TABLE [dbo].[Stock_Report] (
    [coast]        NVARCHAR (20)      NULL,
    [compnr]       INT                NULL,
    [mrp_date]     DATE               NULL,
    [alpha]        NVARCHAR (500)     NULL,
    [major_cat]    NVARCHAR (50)      NULL,
    [item_num]     NVARCHAR (50)      NULL,
    [gl_tbl]       NVARCHAR (50)      NULL,
    [available]    DECIMAL (18, 2)    NULL,
    [bp]           NVARCHAR (50)      NULL,
    [orno]         NVARCHAR (50)      NULL,
    [pono]         INT                NULL,
    [ponb]         INT                NULL,
    [asnr]         NVARCHAR (50)      NULL,
    [asn_line]     INT                NULL,
    [PromiseDate]  DATE               NULL,
    [hp]           NVARCHAR (50)      NULL,
    [gp]           NVARCHAR (50)      NULL,
    [se]           NVARCHAR (50)      NULL,
    [pr]           NVARCHAR (50)      NULL,
    [sc]           NVARCHAR (50)      NULL,
    [ct]           NVARCHAR (50)      NULL,
    [vt]           NVARCHAR (50)      NULL,
    [site]         NVARCHAR (50)      NULL,
    [source]       NVARCHAR (50)      NULL,
    [cwar]         NVARCHAR (50)      NULL,
    [Ttype]        NVARCHAR (20)      NULL,
    [NoOfWeek]     NVARCHAR (20)      NULL,
    [DateTime_EST] DATETIMEOFFSET (7) NULL,
    [short]        INT                NULL,
    [ColorCode]    INT                NULL,
    [InsertDate]   DATETIME           DEFAULT (getdate()) NULL
);


GO

