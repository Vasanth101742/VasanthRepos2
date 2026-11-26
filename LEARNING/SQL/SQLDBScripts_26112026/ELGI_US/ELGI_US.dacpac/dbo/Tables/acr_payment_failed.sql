CREATE TABLE [dbo].[acr_payment_failed] (
    [compnr]          INT            NULL,
    [ttyp]            VARCHAR (50)   NULL,
    [ninv]            NVARCHAR (50)  NULL,
    [line]            NVARCHAR (50)  NULL,
    [itbp]            VARCHAR (50)   NULL,
    [ccur]            VARCHAR (50)   NULL,
    [rate_1]          NVARCHAR (50)  NULL,
    [docd]            NVARCHAR (50)  NULL,
    [prod]            NVARCHAR (50)  NULL,
    [year]            NVARCHAR (50)  NULL,
    [InAmth]          FLOAT (53)     NULL,
    [PaidAmth]        FLOAT (53)     NULL,
    [OutstandingAmth] FLOAT (53)     NULL,
    [BPName]          NVARCHAR (254) NULL,
    [id]              INT            IDENTITY (1, 1) NOT NULL,
    [payment_status]  INT            NULL,
    [refnumber]       NVARCHAR (150) NULL,
    [payment_date]    DATETIME       NULL,
    [paypal_id]       NVARCHAR (200) NULL,
    [dued]            DATETIME       NULL,
    [initiated_date]  DATETIME       NULL
);


GO

