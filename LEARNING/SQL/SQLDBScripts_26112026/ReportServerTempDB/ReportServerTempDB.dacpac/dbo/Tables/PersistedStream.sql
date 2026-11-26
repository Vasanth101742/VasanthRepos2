CREATE TABLE [dbo].[PersistedStream] (
    [SessionID]      VARCHAR (32)   NOT NULL,
    [Index]          INT            NOT NULL,
    [Content]        IMAGE          NULL,
    [Name]           NVARCHAR (260) NULL,
    [MimeType]       NVARCHAR (260) NULL,
    [Extension]      NVARCHAR (260) NULL,
    [Encoding]       NVARCHAR (260) NULL,
    [Error]          NVARCHAR (512) NULL,
    [RefCount]       INT            NOT NULL,
    [ExpirationDate] DATETIME       NOT NULL,
    CONSTRAINT [PK_PersistedStream] PRIMARY KEY CLUSTERED ([SessionID] ASC, [Index] ASC)
);


GO

