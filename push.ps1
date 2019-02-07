Write-Output "--- Compiling dashboard..."
Set-Location .\dashboard 
elm make elm\Main.elm elm\Model.elm elm\View.elm elm\TestResult\Model.elm --output wwwroot\js\main.js
dotnet build
Write-Output "--- Done"
Write-Output "--- Compiling canary..."
Set-Location ..\canary
dotnet build
Set-Location ..
Write-Output "--- Done! All looks good. Pushing..."
cf login -a api.run.pivotal.io
cf push