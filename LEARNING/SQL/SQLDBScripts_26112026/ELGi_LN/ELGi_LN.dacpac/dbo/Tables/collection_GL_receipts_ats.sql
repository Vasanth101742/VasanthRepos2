CREATE TABLE [dbo].[collection_GL_receipts_ats] (
    [company]    INT          NULL,
    [Trantyp]    NVARCHAR (3) NULL,
    [InvNo]      INT          NULL,
    [CustNo]     NVARCHAR (9) NULL,
    [gl_receipt] FLOAT (53)   NULL,
    [DocDt]      DATETIME     NULL,
    [dpst]       INT          NOT NULL,
    [area]       VARCHAR (3)  NOT NULL,
    [CTranTyp]   NVARCHAR (3) NULL,
    [CDocNo]     INT          NULL,
    [AnpTranTyp] NVARCHAR (3) NULL,
    [AnpDocNo]   INT          NULL,
    [DocTyp]     INT          NULL
);


GO

