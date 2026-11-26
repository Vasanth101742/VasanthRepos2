CREATE TABLE [dbo].[LN_TCCOM113] (
    [compnr]          BIGINT        NULL,
    [itbp]            NVARCHAR (9)  NULL,
    [comp]            BIGINT        NULL,
    [cofc]            NVARCHAR (6)  NULL,
    [buor]            FLOAT (53)    NULL,
    [buol]            FLOAT (53)    NULL,
    [obra]            FLOAT (53)    NULL,
    [obrl]            FLOAT (53)    NULL,
    [buin]            FLOAT (53)    NULL,
    [buil]            FLOAT (53)    NULL,
    [cryr]            BIGINT        NULL,
    [tovr_1]          FLOAT (53)    NULL,
    [tovr_2]          FLOAT (53)    NULL,
    [tovr_3]          FLOAT (53)    NULL,
    [tovr_1_1]        FLOAT (53)    NULL,
    [tovr_1_2]        FLOAT (53)    NULL,
    [tovr_1_3]        FLOAT (53)    NULL,
    [tovr_2_1]        FLOAT (53)    NULL,
    [tovr_2_2]        FLOAT (53)    NULL,
    [tovr_2_3]        FLOAT (53)    NULL,
    [tovr_3_1]        FLOAT (53)    NULL,
    [tovr_3_2]        FLOAT (53)    NULL,
    [tovr_3_3]        FLOAT (53)    NULL,
    [tovr_4_1]        FLOAT (53)    NULL,
    [tovr_4_2]        FLOAT (53)    NULL,
    [tovr_4_3]        FLOAT (53)    NULL,
    [itbp_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCCOM113_lookup]
    ON [dbo].[LN_TCCOM113]([compnr] ASC, [itbp] ASC, [comp] ASC, [cofc] ASC);


GO

