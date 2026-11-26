CREATE PROCEDURE [dbo].[SetConfigurationInfoValue]
@ConfigValue ntext,
@ConfigName nvarchar (260)
AS

UPDATE [dbo].[ConfigurationInfo]
SET [Value] = @ConfigValue
WHERE [Name] = @ConfigName

GO

