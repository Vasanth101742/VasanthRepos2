CREATE TABLE [dbo].[mb] (
    [YEAR]                NVARCHAR (8)   NULL,
    [Company]             INT            NOT NULL,
    [SOFC]                NVARCHAR (12)  NULL,
    [MITM]                NVARCHAR (94)  NULL,
    [SITM]                NVARCHAR (94)  NULL,
    [QANA]                FLOAT (53)     NULL,
    [MITM_desc]           VARCHAR (76)   NOT NULL,
    [SITM_desc]           VARCHAR (70)   NOT NULL,
    [KITM]                VARCHAR (13)   NULL,
    [PRIC]                FLOAT (53)     NULL,
    [IMPO]                NVARCHAR (38)  NULL,
    [Q1PR]                FLOAT (53)     NULL,
    [Q2PR]                FLOAT (53)     NULL,
    [Q3PR]                FLOAT (53)     NULL,
    [Q4PR]                FLOAT (53)     NULL,
    [PreBud]              FLOAT (53)     NULL,
    [BudMatCost]          FLOAT (53)     NULL,
    [CATG]                NVARCHAR (100) NULL,
    [SUBC]                NVARCHAR (100) NULL,
    [PricIncrease]        FLOAT (53)     NULL,
    [PricIncreasePercent] FLOAT (53)     NULL
);


GO

