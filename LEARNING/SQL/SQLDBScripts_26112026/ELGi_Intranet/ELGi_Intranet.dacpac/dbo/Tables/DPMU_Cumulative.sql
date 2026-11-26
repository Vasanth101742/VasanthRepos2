CREATE TABLE [dbo].[DPMU_Cumulative] (
    [TO_BE_MAPPED_AS]     NVARCHAR (25)  NULL,
    [Productgroup1]       NVARCHAR (255) NULL,
    [Productgroup2]       NVARCHAR (255) NULL,
    [Finyear]             INT            NULL,
    [Finmonth]            INT            NULL,
    [Calyear]             INT            NULL,
    [CalMonth]            INT            NULL,
    [Finperiod]           VARCHAR (20)   NULL,
    [FinperiodName]       VARCHAR (20)   NULL,
    [Fabno_counts]        INT            NULL,
    [Trackno_counts]      INT            NULL,
    [Fabno_Counts_Cum]    INT            NULL,
    [Trackno_counts_Cum]  INT            NULL,
    [Fabno_Counts_Cum2]   INT            NULL,
    [Trackno_counts_Cum2] INT            NULL,
    [Fabno_Counts_Cum3]   INT            NULL,
    [Trackno_counts_Cum3] INT            NULL
);


GO

