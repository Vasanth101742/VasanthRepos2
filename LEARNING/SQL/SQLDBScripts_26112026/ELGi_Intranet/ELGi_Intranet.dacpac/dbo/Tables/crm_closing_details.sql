CREATE TABLE [dbo].[crm_closing_details] (
    [trackno]      NVARCHAR (15)  NULL,
    [item_code]    NVARCHAR (47)  NULL,
    [item_desc]    NVARCHAR (60)  NULL,
    [actiontaken]  INT            NULL,
    [warranty]     INT            NULL,
    [old_itemcode] NVARCHAR (MAX) NULL
);


GO

