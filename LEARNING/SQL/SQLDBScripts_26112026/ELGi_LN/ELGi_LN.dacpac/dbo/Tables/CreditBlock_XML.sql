CREATE TABLE [dbo].[CreditBlock_XML] (
    [XMLValue]   XML  NULL,
    [CreateDate] DATE DEFAULT (getdate()) NULL,
    [SlNo]       INT  IDENTITY (1, 1) NOT NULL
);


GO

