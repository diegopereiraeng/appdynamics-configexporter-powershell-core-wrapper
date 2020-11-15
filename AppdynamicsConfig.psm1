class AppdynamicsConfig {
    
    [ValidatePattern("^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*(\.[a-z]{2,5})*(:[0-9]{1,5})?(\/.*)?$")]
    [string]$baseurlconfig
    [bool]$debug = $FALSE
    $session
    $headers = [System.Collections.Generic.Dictionary[[String],[String]]]::new()
    #$configurl = "http://localhost:8080"
    # 
    [string]$Help
    #[System.Collections.Generic.Dictionary[AppdynamicsAPI, string]] $AppdynamicsAPIs
    
    AppdynamicsConfig ([String]$baseurlconfig) {
        # Seta Base URL
        $this.baseurlconfig = $baseurlconfig
        # Set Default Headers
        $this.headers.Add('Content-Type','application/json;charset=UTF-8')
        $this.headers.Add('Accept',"application/json, text/plain, */*")
        $this.headers.Add('Accept-Encoding','gzip, deflate, br')
        $this.headers.Add('Accept-Language','en-US,en;q=0.9')
        $this.headers.Add('Sec-Fetch-Mode','cors')
    }
    
 
    [System.Object[]] GetConfigControllers (){
        $url = $this.baseurlconfig+"/api/controllers"

        try
        {
            $responseData = Invoke-WebRequest -Uri $url -Headers $this.headers -Method Get -ContentType 'application/json' -UseBasicParsing
            $content = $responseData.content
            $controllers = ($content | ConvertFrom-Json)
            #[xml]$apps = $content
            return $controllers
        }
        catch
        {
            $StatusCode = $_.Exception.Response.StatusCode.value__
            $source = "GetConfigControllers"
            $this.Log($source,"ERROR",$_.Exception.Response)
            #$this.Log($source,"ERROR","Body: $body")
            $this.Log($source,"ERROR",$_.Exception.Message)
            $this.Log($source,"ERROR","Error getting controllers : $StatusCode")
            $this.Log($source,"ERROR",$url)
            return @()
        }
        return @()

    }
    [System.Object[]] GetConfigApps ($controller){
        $url = $this.baseurlconfig+"/api/controllers/$controller/applications"

        try
        {
            $responseData = Invoke-WebRequest -Uri $url -Headers $this.headers -Method Get -ContentType 'application/json' -UseBasicParsing
            $content = $responseData.content
            $apps = ($content | ConvertFrom-Json)
            #[xml]$apps = $content
            return $apps
        }
        catch
        {
            $StatusCode = $_.Exception.Response.StatusCode.value__
            $source = "GetConfigControllers"
            $this.Log($source,"ERROR",$_.Exception.Response)
            #$this.Log($source,"ERROR","Body: $body")
            $this.Log($source,"ERROR",$_.Exception.Message)
            $this.Log($source,"ERROR","Error getting controller apps : $StatusCode")
            $this.Log($source,"ERROR",$url)
            return @()
        }
        return @()

    }
    [System.Object[]] CopyConfigControllerAppConfig ([Int64]$srcController , [Int64]$srcApp , [Int64]$tdestController , [Int64]$destApp){
        $url = $this.baseurlconfig+"/api/rest/app-config"
        $body = '{
                    "srcControllerId":'+$srcController+' ,
                    "destControllerId":'+$tdestController+' ,
                    "srcApplicationId":'+$srcApp+',
                    "destApplicationId":'+$destApp+',
                    "configNames":[
                        "TRANSACTION_DETECTION",
                        "CUSTOM_ENTRY_POINTS",
                        "BACKEND_DETECTION",
                        "CUSTOM_EXIT_POINTS",
                        "INFORMATION_POINTS",
                        "HEALTH_RULES",
                        "ACTIONS",
                        "POLICIES",
                        "DATA_COLLECTORS",
                        "CALL_GRAPH_SETTINGS",
                        "ERROR_DETECTION",
                        "EUM_CONFIGS",
                        "JMX_RULES",
                        "BT_CONFIG",
                        "APPAGENT_PROPERTIES",
                        "SERVICE_ENDPOINT_DETECTION",
                        "SLOW_TRANSACTION_THRESHOLDS",
                        "CONFIG20_SCOPES",
                        "CONFIG20_RULES",
                        "EUM_APP_INTEGRATION",
                        "EUM_SYNTHETIC_JOBS",
                        "EUM_BROWSER_CONFIG",
                        "EUM_MOBILE_CONFIG",
                        "METRIC_BASELINES",
                        "DB_COLLECTORS",
                        "SERVICE_AVAILABILITY_MONITORING",
                        "ASYNC_CONFIG",
                        "TIER_TRANSACTION_DETECTION",
                        "TIER_CUSTOM_ENTRY_POINTS",
                        "TIER_BACKEND_DETECTION",
                        "TIER_CUSTOM_EXIT_POINTS",
                        "TIER_SERVICE_ENDPOINTS",
                        "TIER_APPAGENT_PROPERTIES",
                        "TIER_SERVICE_ENDPOINT_DETECTION",
                        "NODE_APPAGENT_PROPERTIES"
                    ],
                    "properties":{
                    "overwrite": true,
                    "createTier": true
                    }
                }'
        try
        {
            $responseData = Invoke-WebRequest -Uri $url -Headers $this.headers -Method Post -Body $body -ContentType 'application/json' -UseBasicParsing
            $content = $responseData.content
            $apps = ($content | ConvertFrom-Json)
            #[xml]$apps = $content
            return $apps
        }
        catch
        {
            $StatusCode = $_.Exception.Response.StatusCode.value__
            $source = "GetConfigControllers"
            $this.Log($source,"ERROR",$_.Exception.Response)
            #$this.Log($source,"ERROR","Body: $body")
            $this.Log($source,"ERROR",$_.Exception.Message)
            $this.Log($source,"ERROR","Error getting controller apps : $StatusCode")
            $this.Log($source,"ERROR",$url)
            return @()
        }
        return @()

    }

    [System.Object[]] CopyConfigControllerAppConfigBT ([Int64]$srcController , [Int64]$srcApp , [Int64]$tdestController , [Int64]$destApp){
        $url = $this.baseurlconfig+"/api/rest/app-config"
        $body = '{
                    "srcControllerId":'+$srcController+' ,
                    "destControllerId":'+$tdestController+' ,
                    "srcApplicationId":'+$srcApp+',
                    "destApplicationId":'+$destApp+',
                    "configNames":[
                        "CONFIG20_SCOPES",
                        "CONFIG20_RULES"
                    ],
                    "properties":{
                    "overwrite": true,
                    "createTier": true
                    }
                }'
        try
        {
            $responseData = Invoke-WebRequest -Uri $url -Headers $this.headers -Method Post -Body $body -ContentType 'application/json' -UseBasicParsing
            $content = $responseData.content
            $apps = ($content | ConvertFrom-Json)
            #[xml]$apps = $content
            return $apps
        }
        catch
        {
            $StatusCode = $_.Exception.Response.StatusCode.value__
            $source = "GetConfigControllers"
            $this.Log($source,"ERROR",$_.Exception.Response)
            #$this.Log($source,"ERROR","Body: $body")
            $this.Log($source,"ERROR",$_.Exception.Message)
            $this.Log($source,"ERROR","Error getting controller apps : $StatusCode")
            $this.Log($source,"ERROR",$url)
            return @()
        }
        return @()

    }

    [System.Object[]] GetConfigControllerAppConfig ([Int64]$srcController , [Int64]$srcApp , [Int64]$tdestController , [Int64]$destApp){
        $url = $this.baseurlconfig+"/api/rest/app-config"
        
        try
        {
            $responseData = Invoke-WebRequest -Uri $url -Headers $this.headers -Method Get  -ContentType 'application/json' -UseBasicParsing
            $content = $responseData.content
            $apps = ($content | ConvertFrom-Json)
            #[xml]$apps = $content
            return $apps
        }
        catch
        {
            $StatusCode = $_.Exception.Response.StatusCode.value__
            $source = "GetConfigControllers"
            $this.Log($source,"ERROR",$_.Exception.Response)
            #$this.Log($source,"ERROR","Body: $body")
            $this.Log($source,"ERROR",$_.Exception.Message)
            $this.Log($source,"ERROR","Error getting controller apps : $StatusCode")
            $this.Log($source,"ERROR",$url)
            return @()
        }
        return @()

    }

    Log ($source,$severity,$message){
        $log = "AppdynamicsConfig.log"

        
        if (($this.debug) -OR $severity -ne "DEBUG") {
            if (((Get-Item $log).length/1MB) -gt 5){
            
                Copy-Item $log -Destination ($log+".0") -Force -Confirm
                Remove-Item $log
            }
            (Get-Date -Format "yyyy-MM-dd HH:mm:ss")+" - "+$severity+" - "+$source+" - "+$message | Out-File -Append -FilePath $log    
        }
        
    }

}