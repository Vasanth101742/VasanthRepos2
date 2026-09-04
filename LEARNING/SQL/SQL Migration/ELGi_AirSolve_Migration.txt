sqlpackage `
    /Action:Extract `
    /SourceConnectionString:"Server=10.50.0.4;Database= ELGi_AirSolve;User ID=sa;Password=ElgiP0w3r@20#23;Encrypt=True;TrustServerCertificate=True" `
    /TargetFile:"C:\SQLDevOps\ELGi_AirSolve" `
    /p:ExtractTarget=SchemaObjectType


dotnet new sqlproj `
    -n ELGi_AirSolve `
    -o C:\SQLDevOps\ELGi_AirSolve


dotnet build C:\SQLDevOps\ELGi_AirSolve\ELGi_AirSolve.sqlproj
