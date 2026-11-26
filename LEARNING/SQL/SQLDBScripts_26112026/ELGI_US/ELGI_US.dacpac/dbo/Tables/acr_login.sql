CREATE TABLE [dbo].[acr_login] (
    [id]           INT           IDENTITY (1, 1) NOT NULL,
    [username]     NVARCHAR (50) NULL,
    [password]     NVARCHAR (50) NULL,
    [isactive]     BIT           NULL,
    [customercode] NVARCHAR (50) NULL,
    [companycode]  NVARCHAR (50) NULL
);


GO

