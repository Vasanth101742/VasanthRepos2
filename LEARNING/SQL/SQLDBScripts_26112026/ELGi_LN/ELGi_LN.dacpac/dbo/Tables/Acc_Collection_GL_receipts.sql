CREATE TABLE [dbo].[Acc_Collection_GL_receipts] (
    [company]    INT          NULL,
    [trantyp]    NVARCHAR (3) NULL,
    [invno]      INT          NULL,
    [custno]     NVARCHAR (9) NULL,
    [gl_receipt] FLOAT (53)   NULL,
    [docdt]      DATETIME     NULL,
    [dpst]       INT          NOT NULL,
    [area]       VARCHAR (3)  NOT NULL,
    [ctrantyp]   NVARCHAR (3) NULL,
    [cdocno]     INT          NULL,
    [anptrantyp] NVARCHAR (3) NULL,
    [anpdocno]   INT          NULL,
    [doctyp]     INT          NULL
);


GO

