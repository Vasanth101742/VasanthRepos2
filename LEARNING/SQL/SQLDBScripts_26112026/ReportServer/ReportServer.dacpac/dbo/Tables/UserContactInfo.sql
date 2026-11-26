CREATE TABLE [dbo].[UserContactInfo] (
    [UserID]              UNIQUEIDENTIFIER NOT NULL,
    [DefaultEmailAddress] NVARCHAR (256)   NULL,
    CONSTRAINT [FK_UserContactInfo_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);


GO

