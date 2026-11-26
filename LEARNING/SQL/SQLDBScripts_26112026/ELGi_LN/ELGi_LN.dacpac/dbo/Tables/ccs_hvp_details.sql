CREATE TABLE [dbo].[ccs_hvp_details] (
    [trackno]                       NVARCHAR (15) NULL,
    [added_on]                      DATETIME      NULL,
    [added_by]                      NVARCHAR (9)  NULL,
    [part_name]                     NVARCHAR (75) NULL,
    [defective_ae]                  NVARCHAR (75) NULL,
    [replaced_ae]                   NVARCHAR (75) NULL,
    [returned_ae]                   NVARCHAR (75) NULL,
    [failure_trend_ae]              NVARCHAR (75) NULL,
    [defective_mot]                 NVARCHAR (75) NULL,
    [replaced_mot]                  NVARCHAR (75) NULL,
    [returned_mot]                  NVARCHAR (75) NULL,
    [failure_trend_mot]             NVARCHAR (75) NULL,
    [vendor_warr_mot]               NVARCHAR (75) NULL,
    [defective_mot_repair]          NVARCHAR (75) NULL,
    [defective_mot_analysis]        NVARCHAR (75) NULL,
    [defective_cool]                NVARCHAR (75) NULL,
    [replaced_cool]                 NVARCHAR (75) NULL,
    [cooler_location]               NVARCHAR (75) NULL,
    [defective_vfd]                 NVARCHAR (75) NULL,
    [replaced_vfd]                  NVARCHAR (75) NULL,
    [vendor_ccs_track_vfd]          NVARCHAR (75) NULL,
    [def_shipp_repair_vfd]          NVARCHAR (75) NULL,
    [vendor_warranty_vfd]           NVARCHAR (75) NULL,
    [def_vfd_repair_status]         NVARCHAR (75) NULL,
    [defective_vfd_analysis_report] NVARCHAR (75) NULL
);


GO

