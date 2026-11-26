CREATE TABLE [dbo].[DTA_output_recommendation] (
    [RecommendationID] INT            IDENTITY (1, 1) NOT NULL,
    [SessionID]        INT            NOT NULL,
    [Recommendation]   NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([RecommendationID] ASC),
    FOREIGN KEY ([SessionID]) REFERENCES [dbo].[DTA_input] ([SessionID]) ON DELETE CASCADE
);


GO

CREATE NONCLUSTERED INDEX [DTA_output_recommendation_index]
    ON [dbo].[DTA_output_recommendation]([SessionID] ASC);


GO

