CREATE TABLE [dbo].[pcr_risk] (
    [sno]                INT            NULL,
    [pcr_id]             NVARCHAR (30)  NULL,
    [status]             INT            NULL,
    [created_at]         DATETIME2 (0)  NULL,
    [created_by]         INT            NULL,
    [type_of_risk]       NVARCHAR (20)  NULL,
    [risk]               NVARCHAR (MAX) NULL,
    [opportunity]        NVARCHAR (MAX) NULL,
    [severity]           INT            NULL,
    [occurrence]         INT            NULL,
    [score]              INT            NULL,
    [risk_accept]        NVARCHAR (50)  NULL,
    [existing_control]   NVARCHAR (MAX) NULL,
    [mitigation_control] NVARCHAR (MAX) NULL,
    [responsiblity]      INT            NULL,
    [target_date]        DATETIME2 (0)  NULL,
    [risk_status]        NVARCHAR (20)  NULL,
    [severity_closed]    INT            NULL,
    [occurrence_closed]  INT            NULL,
    [score_closed]       INT            NULL,
    [risk_accept_closed] NVARCHAR (50)  NULL
);


GO

