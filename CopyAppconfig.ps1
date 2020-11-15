Using module './AppdynamicsConfig.psm1'

$appdyConfig = [AppdynamicsConfig]::new("http://localhost:8080")

#$appdyConfig.GetConfigControllers()
#$appdyConfig.GetConfigControllerAppConfig | ConvertTo-Json -Depth 15
#$appdyConfig.CopyConfigControllerAppConfig(94506170, 36 ,94506170, 49)

$srcController = 1953890731
$destController = 1953890731

#controller Original
$apps = $appdyConfig.GetConfigApps($srcController) | Where-Object {$_.name -match "itau-"}  

#controller Destino
$apps2 = $appdyConfig.GetConfigApps($destController) | Where-Object {$_.name -match "itau-"} 

foreach ($app in $apps) {
    $appName = $app.name
    $dest = $apps2 | Where-Object {$_.name -eq $appName} 
    if ($null -ne $dest) {
        Write-Host "$appName Match - Copia da controller $srcController e app "$app.id" para controller $destController e app "$dest.id
        $appdyConfig.CopyConfigControllerAppConfigBT($srcController, $app.id ,$destController, $dest.id)
    }
    else {
        Write-Host "$appName Not Match - Erro na Copia da controller $srcController e app "$app.id" para controller $destController"
    }
}

#LOGICA DE DE/PARA para chamar a copia do config



# Comando de copia ( CONTROLLER_ID_ORIGEM, CONTROLLER_APP_ID_ORIGEM , CONTROLLER_ID_DESTINO , CONTROLLER_APP_ID_DESTINO )
#$appdyConfig.CopyConfigControllerAppConfigBT(94506170, 36 ,94506170, 49)