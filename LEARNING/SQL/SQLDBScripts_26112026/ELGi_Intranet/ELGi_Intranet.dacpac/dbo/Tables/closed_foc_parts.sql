CREATE TABLE [dbo].[closed_foc_parts] (
    [ccstrackno]      NVARCHAR (15)  NULL,
    [focno]           NVARCHAR (15)  NULL,
    [item_code]       NVARCHAR (MAX) NULL,
    [item_desc]       NVARCHAR (MAX) NULL,
    [item_used]       INT            NULL,
    [item_req]        INT            NULL,
    [price_type]      NVARCHAR (50)  NULL,
    [item_price]      FLOAT (53)     NULL,
    [total_value]     FLOAT (53)     NULL,
    [foc_recommend]   NVARCHAR (10)  NULL,
    [apprvl_id]       NVARCHAR (MAX) NULL,
    [appr_id]         NVARCHAR (20)  NULL,
    [vendor_claim_vc] BIT            NULL,
    [vc_added_by]     NVARCHAR (15)  NULL,
    [vc_added_on]     DATETIME2 (0)  NULL,
    [vc_quality_appr] BIT            NULL,
    [vc_qlty_appr_by] NVARCHAR (15)  NULL,
    [vc_qlty_appr_on] DATETIME2 (0)  NULL,
    [confirm]         NVARCHAR (1)   NULL,
    [session_id]      NVARCHAR (60)  NULL,
    [added_on]        DATETIME2 (0)  NULL
);


GO

