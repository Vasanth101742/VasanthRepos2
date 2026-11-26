CREATE TABLE [dbo].[Debtors_Consolidated_BAAN] (
    [global]           CHAR (20)       NULL,
    [description]      VARCHAR (35)    NULL,
    [Zone]             VARCHAR (30)    NULL,
    [InvAmntInHomeCur] DECIMAL (38, 2) NULL,
    [RecAmntHomeCur]   DECIMAL (38, 2) NULL,
    [BalAmntHomeCur]   DECIMAL (38, 6) NULL,
    [DueAmt]           DECIMAL (38, 6) NULL,
    [UnDueAmt]         DECIMAL (38, 6) NULL,
    [DueAmtHC30]       DECIMAL (38, 6) NULL,
    [DueAmtHC31_60]    DECIMAL (38, 6) NULL,
    [DueAmtHC61_90]    DECIMAL (38, 6) NULL,
    [DueAmtHC91_120]   DECIMAL (38, 6) NULL,
    [DueAmtHC121_150]  DECIMAL (38, 6) NULL,
    [DueAmtHC151_180]  DECIMAL (38, 6) NULL,
    [DueAmtHC181_365]  DECIMAL (38, 6) NULL,
    [DueAmtHC366_730]  DECIMAL (38, 6) NULL,
    [DueAmtHC731_1095] DECIMAL (38, 6) NULL,
    [DueAmtgt_1095]    DECIMAL (38, 6) NULL,
    [areaname]         VARCHAR (30)    NULL,
    [description1]     VARCHAR (13)    NOT NULL,
    [ordering1]        INT             NOT NULL,
    [zone1]            VARCHAR (30)    NULL
);


GO

