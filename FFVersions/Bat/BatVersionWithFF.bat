@echo off
setlocal enabledelayedexpansion

rem Количество попыток пинга
set "ATTEMPTS=3"

rem Время ожидания ответа в миллисекундах
set "TIMEOUT=350"

rem Список DNS-серверов для проверки
set "DNS_SERVERS=8.8.8.8 1.1.1.1 208.67.222.222 8.8.4.4 1.0.0.1 208.67.220.220 9.9.9.9 149.112.112.112 64.6.64.6 64.6.65.6 84.200.69.80 84.200.70.40 94.140.14.14 94.140.15.15 8.26.56.26 8.20.247.20 156.154.70.1 156.154.71.1 208.67.222.220 198.101.242.72 198.101.242.73"

rem Переменная для хранения наилучшего пинга
set "BEST_PING=9999999"

rem Переменная для хранения наилучшего DNS-сервера
set "BEST_DNS="

rem Очистка DNS-кеша
ipconfig /flushdns

rem Очистка временных файлов в AppData
del /q /s "%APPDATA%\Temp\*.*"

rem Определение подключения к сети
for /f "tokens=3 delims=: " %%a in ('netsh interface show interface ^| find "Connected"') do (
    set "CONNECTION=%%a"
)

rem Проверка пинга для каждого DNS-сервера
for %%i in (%DNS_SERVERS%) do (
    (
        for /f "tokens=*" %%a in ('powershell.exe -Command "Test-Connection -ComputerName %%i -Count %ATTEMPTS% -BufferSize 16 -Delay %TIMEOUT% | Select-Object -ExpandProperty ResponseTime"') do (
            if %%a lss !BEST_PING! (
                set "BEST_PING=%%a"
                set "BEST_DNS=%%i"
            )
        )
    ) >nul 2>&1
)

rem Вывод результатов
if defined BEST_DNS (
    echo Наилучший DNS-сервер: !BEST_DNS! с пингом !BEST_PING! мс

    rem Настройка DNS-сервера для IPv4
    netsh interface ipv4 set dns name="%CONNECTION%" static !BEST_DNS! primary

    rem Отключение IPv6
    netsh interface ipv6 set global state=disabled

    rem Настройка правил брандмауэра
    set "ruleName_outbound=rbxpingoptimizerroblox_outbound"
    set "ruleName_inbound=rbxpingoptimizerroblox_inbound"
    set "portRange=49152-65535"
    set "protocol=UDP"
    set "action=Allow"
    set "profile=Domain,Private,Public"

    powershell -Command "New-NetFirewallRule -DisplayName '!ruleName_outbound!' -Direction Outbound -LocalPort !portRange! -Protocol !protocol! -Action !action! -Profile !profile!'"
    powershell -Command "New-NetFirewallRule -DisplayName '!ruleName_inbound!' -Direction Inbound -LocalPort !portRange! -Protocol !protocol! -Action !action! -Profile !profile!'"
else
    echo Не удалось определить наилучший DNS-сервер.
)

rem Определение пути к папке Roblox
set "ROBLOX_PATH="
for /f "tokens=2,*" %%i in ('reg query "HKCU\SOFTWARE\Roblox\RobloxStudioBrowser\roblox-player" /v InstallPath') do set "ROBLOX_PATH=%%j"

if defined ROBLOX_PATH (
    rem Создание папки ClientSettings и файла ClientAppSettings.json
    mkdir "%ROBLOX_PATH%\ClientSettings" > nul 2>&1

    rem Создание файла ClientAppSettings.json и добавление настроек
    (
        echo {
        echo    "DFFlagDebugVisualizationImprovements": "True",
        echo    "DFFlagDebugVisualizeAllPropertyChanges": "True",
        echo    "DFFlagDebugVisualizerTrackRotationPredictions": "True",
        echo    "DFFlagDebugEnableInterpolationVisualizer": "True",
        echo    "FFlagEnableReportAbuseMenuRoactABTest2": "False",
        echo    "FFlagEnableReportAbuseMenuRoact2": "False",
        echo    "FFlagEnableReportAbuseMenuLayerOnV3": "False",
        echo    "FFlagVoiceBetaBadge": "False",
        echo    "FFlagTopBarUseNewBadge": "False",
        echo    "FFlagEnableBetaBadgeLearnMore": "False",
        echo    "FFlagBetaBadgeLearnMoreLinkFormview": "False",
        echo    "FFlagControlBetaBadgeWithGuac": "False",
        echo    "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo    "FIntFullscreenTitleBarTriggerDelayMillis": "3600000",
        echo    "DFFlagEnableDynamicHeadByDefault": "False",
        echo    "FIntRobloxGuiBlurIntensity": "0",
        echo    "DFIntConnectionMTUSize": "900",
        echo    "FIntRakNetResendBufferArrayLength": "128",
        echo    "FFlagOptimizeNetwork": "True",
        echo    "FFlagOptimizeNetworkRouting": "True",
        echo    "FFlagOptimizeNetworkTransport": "True",
        echo    "FFlagOptimizeServerTickRate": "True",
        echo    "DFIntServerPhysicsUpdateRate": "60",
        echo    "DFIntServerTickRate": "60",
        echo    "DFIntRakNetResendRttMultiple": "1",
        echo    "DFIntRaknetBandwidthPingSendEveryXSeconds": "1",
        echo    "DFIntOptimizePingThreshold": "50",
        echo    "DFIntPlayerNetworkUpdateQueueSize": "20",
        echo    "DFIntPlayerNetworkUpdateRate": "60",
        echo    "DFIntNetworkPrediction": "120",
        echo    "DFIntNetworkLatencyTolerance": "1",
        echo    "DFIntMinimalNetworkPrediction": "0.1",
        echo    "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo    "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo    "FFlagDebugDisableTelemetryEventIngest": "True",
        echo    "FFlagDebugDisableTelemetryPoint": "True",
        echo    "FFlagDebugDisableTelemetryV2Counter": "True",
        echo    "FFlagDebugDisableTelemetryV2Event": "True",
        echo    "FFlagDebugDisableTelemetryV2Stat": "True",
        echo    "FFlagDisablePostFx": "True",
        echo    "DFIntMaxFrameBufferSize": "4",
        echo    "FIntRenderShadowIntensity": "0",
        echo    "FFlagCoreGuiTypeSelfViewPresent": "false",
        echo    "FFlagMSRefactor5": "False",
        echo    "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo    "DFIntTimestepArbiterThresholdCFLThou": "300",
        echo    "FFlagAdServiceEnabled": "False",
        echo    "FLogNetwork": "7",
        echo    "FIntDefaultMeshCacheSizeMB": "256",
        echo    "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo    "DFFlagHttpCacheCleanBasedOnMemory": "true",
        echo    "DFFlagEnableHttpCacheForceRevalidate2": "false",
        echo    "DFFlagQueueDataPingFromSendData": "true",
        echo    "FFlagDontCreatePingJob": "true",
        echo    "DFFlagEnablePerfAudioCollection": "false",
        echo    "DFFlagEnablePerfDataCoreCategoryTimersCollection2": "false",
        echo    "DFFlagEnablePerfDataCoreTimersCollection2": "false",
        echo    "DFFlagEnablePerfDataCountersCollection": "false",
        echo    "DFFlagEnablePerfDataGatherTelemetry2": "false",
        echo    "DFFlagEnablePerfDataMemoryCategoriesCollection2": "false",
        echo    "DFFlagEnablePerfDataMemoryCollection": "false",
        echo    "DFFlagEnablePerfDataMemoryPressureCollection": "false",
        echo    "DFFlagEnablePerfDataSubsystemTimersCollection2": "false",
        echo    "DFFlagEnablePerfRenderStatsCollection2": "false",
        echo    "DFFlagEnablePerfStatsCollection3": "false",
        echo    "FFlagBrowserTrackerIdRequestUseWebId2": "false",
        echo    "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0"
        echo }
    ) > "%ROBLOX_PATH%\ClientSettings\ClientAppSettings.json"
) else (
    echo Путь к папке Roblox не найден.
)