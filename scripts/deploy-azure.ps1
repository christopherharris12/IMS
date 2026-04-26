param(
    [Parameter(Mandatory = $false)]
    [string]$ResourceGroup = "ims-rg",

    [Parameter(Mandatory = $false)]
    [string]$Location = "eastus",

    [Parameter(Mandatory = $false)]
    [string]$PlanName = "ims-plan",

    [Parameter(Mandatory = $false)]
    [string]$AppName = "ims-demo-unique123",

    [Parameter(Mandatory = $false)]
    [string]$Sku = "B1"
)

$ErrorActionPreference = "Stop"

Write-Host "Building Spring Boot jar..." -ForegroundColor Cyan
.\mvnw.cmd clean package -DskipTests

if (-not (Test-Path ".\target\ims-0.0.1-SNAPSHOT.jar")) {
    throw "Jar not found at .\\target\\ims-0.0.1-SNAPSHOT.jar"
}

Write-Host "Creating/ensuring Azure resource group..." -ForegroundColor Cyan
az group create --name $ResourceGroup --location $Location | Out-Null

Write-Host "Creating/ensuring Linux App Service plan..." -ForegroundColor Cyan
az appservice plan create --name $PlanName --resource-group $ResourceGroup --sku $Sku --is-linux | Out-Null

Write-Host "Creating/ensuring web app..." -ForegroundColor Cyan
az webapp create --resource-group $ResourceGroup --plan $PlanName --name $AppName --runtime "JAVA|17-java17" | Out-Null

Write-Host "Deploying jar..." -ForegroundColor Cyan
az webapp deploy --resource-group $ResourceGroup --name $AppName --src-path ".\target\ims-0.0.1-SNAPSHOT.jar" --type jar | Out-Null

$liveUrl = "https://$AppName.azurewebsites.net/login"
Write-Host "Deployment complete." -ForegroundColor Green
Write-Host "Live URL: $liveUrl" -ForegroundColor Green
