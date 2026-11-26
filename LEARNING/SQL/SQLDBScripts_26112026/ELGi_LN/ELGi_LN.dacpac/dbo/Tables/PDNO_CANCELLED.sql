CREATE TABLE [dbo].[PDNO_CANCELLED] (
    [DATE]         DATETIME       NULL,
    [COMPANY]      INT            NULL,
    [ITEMCODE]     NVARCHAR (94)  NULL,
    [ITEM_DESC]    NVARCHAR (120) NULL,
    [PDNO]         NVARCHAR (18)  NULL,
    [AssemblyLine] VARCHAR (150)  NULL,
    [USER]         NVARCHAR (50)  NULL,
    [QRDR]         FLOAT (53)     NULL,
    [DEM]          VARCHAR (20)   NULL,
    [RDLD]         DATE           NULL
);


GO

