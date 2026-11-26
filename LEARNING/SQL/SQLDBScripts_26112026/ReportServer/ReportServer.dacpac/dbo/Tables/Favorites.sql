CREATE TABLE [dbo].[Favorites] (
    [ItemID] UNIQUEIDENTIFIER NOT NULL,
    [UserID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Favorites] PRIMARY KEY NONCLUSTERED ([ItemID] ASC, [UserID] ASC),
    CONSTRAINT [FK_Favorites_Catalog] FOREIGN KEY ([ItemID]) REFERENCES [dbo].[Catalog] ([ItemID]),
    CONSTRAINT [FK_Favorites_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);


GO

CREATE CLUSTERED INDEX [IX_Favorites_UserID]
    ON [dbo].[Favorites]([UserID] ASC);


GO

