CREATE TABLE [dbo].[Production_ALC] (
    [company]          NVARCHAR (38) NULL,
    [warehouse]        NVARCHAR (12) NULL,
    [item]             NVARCHAR (94) NULL,
    [itemdescr]        VARCHAR (50)  NULL,
    [Description]      VARCHAR (50)  NULL,
    [Prodorderno]      NVARCHAR (18) NULL,
    [PlannedDt]        DATE          NULL,
    [ReleaseDt]        DATE          NULL,
    [WIPDt]            DATE          NULL,
    [ActualDt]         DATE          NULL,
    [DaysDiff]         INT           NULL,
    [NationalHolidays] INT           NULL,
    [ALCDays]          INT           NULL,
    [ALCPercentage]    INT           NULL
);


GO

