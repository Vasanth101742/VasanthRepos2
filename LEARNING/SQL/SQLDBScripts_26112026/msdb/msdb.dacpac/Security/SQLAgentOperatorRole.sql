CREATE ROLE [SQLAgentOperatorRole]
    AUTHORIZATION [dbo];


GO

ALTER ROLE [SQLAgentOperatorRole] ADD MEMBER [RSExecRole];


GO

ALTER ROLE [SQLAgentOperatorRole] ADD MEMBER [PolicyAdministratorRole];


GO

