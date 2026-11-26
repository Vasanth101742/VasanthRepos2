CREATE TABLE [dbo].[LN_TFACP251] (
    [compnr]                                             BIGINT        NULL,
    [icom]                                               BIGINT        NULL,
    [ityp]                                               NVARCHAR (3)  NULL,
    [idoc]                                               BIGINT        NULL,
    [loco]                                               BIGINT        NULL,
    [shpm]                                               NVARCHAR (30) NULL,
    [otyp]                                               BIGINT        NULL,
    [orno]                                               NVARCHAR (9)  NULL,
    [pono]                                               BIGINT        NULL,
    [sqnb]                                               BIGINT        NULL,
    [rcno]                                               NVARCHAR (9)  NULL,
    [rseq]                                               BIGINT        NULL,
    [otyp_kw]                                            NVARCHAR (26) NULL,
    [ccur]                                               NVARCHAR (3)  NULL,
    [ifbp]                                               NVARCHAR (9)  NULL,
    [rate_1]                                             FLOAT (53)    NULL,
    [rate_2]                                             FLOAT (53)    NULL,
    [rate_3]                                             FLOAT (53)    NULL,
    [ratf_1]                                             BIGINT        NULL,
    [ratf_2]                                             BIGINT        NULL,
    [ratf_3]                                             BIGINT        NULL,
    [ratd]                                               NVARCHAR (40) NULL,
    [rtyp]                                               NVARCHAR (3)  NULL,
    [iamt]                                               FLOAT (53)    NULL,
    [iqan]                                               FLOAT (53)    NULL,
    [amth_1]                                             FLOAT (53)    NULL,
    [amth_2]                                             FLOAT (53)    NULL,
    [amth_3]                                             FLOAT (53)    NULL,
    [finl]                                               BIGINT        NULL,
    [finl_kw]                                            NVARCHAR (20) NULL,
    [pric]                                               BIGINT        NULL,
    [pric_kw]                                            NVARCHAR (20) NULL,
    [data]                                               NVARCHAR (40) NULL,
    [apry]                                               BIGINT        NULL,
    [aprp]                                               BIGINT        NULL,
    [dbmo]                                               BIGINT        NULL,
    [dbmo_kw]                                            NVARCHAR (20) NULL,
    [buex]                                               BIGINT        NULL,
    [buex_kw]                                            NVARCHAR (20) NULL,
    [imrf]                                               NVARCHAR (30) NULL,
    [pdif]                                               FLOAT (53)    NULL,
    [pdfd]                                               BIGINT        NULL,
    [pdfd_kw]                                            NVARCHAR (20) NULL,
    [shpm_otyp_orno_pono_sqnb_loco_rcno_rseq_ref_compnr] BIGINT        NULL,
    [ifbp_ref_compnr]                                    BIGINT        NULL,
    [deleted]                                            NCHAR (1)     NULL,
    [username]                                           NVARCHAR (8)  NULL,
    [timestamp]                                          DATETIME      NULL,
    [sequencenumber]                                     BIGINT        NULL,
    [dlDocumentDate]                                     NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFACP251_lookup]
    ON [dbo].[LN_TFACP251]([compnr] ASC, [icom] ASC, [ityp] ASC, [idoc] ASC, [loco] ASC, [shpm] ASC, [otyp] ASC, [orno] ASC, [pono] ASC, [sqnb] ASC, [rcno] ASC, [rseq] ASC);


GO

