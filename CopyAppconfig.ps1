Using module './AppdynamicsConfig.psm1'

$appdyConfig = [AppdynamicsConfig]::new("http://localhost:8080")

#$appdyConfig.GetConfigControllerAppConfig | ConvertTo-Json -Depth 15
#$appdyConfig.CopyConfigControllerAppConfig(94506170, 36 ,94506170, 49)
$appdyConfig.GetConfigControllers()

#controller Original
$apps = $appdyConfig.GetConfigApps(94506170) | Where-Object {$_.name -match "itau"} | ConvertTo-Json 

#controller Destino
$apps = $appdyConfig.GetConfigApps(2023422902) | Where-Object {$_.name -match "itau"} | ConvertTo-Json 

#LOGICA DE DE/PARA para chamar a copia do config

# Comando de copia ( CONTROLLER_ID_ORIGEM, CONTROLLER_APP_ID_ORIGEM , CONTROLLER_ID_DESTINO , CONTROLLER_APP_ID_DESTINO )
$appdyConfig.CopyConfigControllerAppConfigBT(94506170, 36 ,94506170, 49)