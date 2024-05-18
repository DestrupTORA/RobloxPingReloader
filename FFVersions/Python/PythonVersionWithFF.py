import os
import json
from ping3 import ping, verbose_ping
from pingparsing import PingParsing

# Количество попыток пинга
ATTEMPTS = 3

# Время ожидания ответа в секундах
TIMEOUT = 0.35

# Список DNS-серверов для проверки
DNS_SERVERS = [
    "8.8.8.8", "1.1.1.1", "208.67.222.222", "8.8.4.4", "1.0.0.1",
    "208.67.220.220", "9.9.9.9", "149.112.112.112", "64.6.64.6",
    "64.6.65.6", "84.200.69.80", "84.200.70.40", "94.140.14.14",
    "94.140.15.15", "8.26.56.26", "8.20.247.20", "156.154.70.1",
    "156.154.71.1", "208.67.222.220", "198.101.242.72", "198.101.242.73"
]

# Переменная для хранения наилучшего пинга
best_ping = float('inf')

# Переменная для хранения наилучшего DNS-сервера
best_dns = None

# Проверка пинга для каждого DNS-сервера
for dns_server in DNS_SERVERS:
    avg_ping = ping(dns_server, timeout=TIMEOUT, unit="ms")
    if avg_ping is not None and avg_ping < best_ping:
        best_ping = avg_ping
        best_dns = dns_server

# Вывод результатов
if best_dns:
    print(f"Наилучший DNS-сервер: {best_dns} с пингом {best_ping} мс")

    # Настройка DNS-сервера для IPv4
    os.system(f"netsh interface ipv4 set dns name='primary' static {best_dns} primary")

    # Отключение IPv6
    os.system("netsh interface ipv6 set global state=disabled")

    # Создание файла ClientAppSettings.json и добавление настроек
    roblox_path = os.popen('reg query "HKCU\\SOFTWARE\\Roblox\\RobloxStudioBrowser\\roblox-player" /v InstallPath').read().split()[-1]
    if roblox_path:
        settings_path = os.path.join(roblox_path.strip(), "ClientSettings", "ClientAppSettings.json")
        settings = {
            "DFFlagDebugVisualizationImprovements": "True",
            "DFFlagDebugVisualizeAllPropertyChanges": "True",
             "DFFlagDebugVisualizationImprovements": "True",
             "DFFlagDebugVisualizeAllPropertyChanges": "True",
             "DFFlagDebugVisualizerTrackRotationPredictions": "True", 
             "DFFlagDebugEnableInterpolationVisualizer": "True",
             "FFlagEnableReportAbuseMenuRoactABTest2": "False",
             "FFlagEnableReportAbuseMenuRoact2": "False",
             "FFlagEnableReportAbuseMenuLayerOnV3": "False",
             "FFlagVoiceBetaBadge": "False",
             "FFlagTopBarUseNewBadge": "False",
             "FFlagEnableBetaBadgeLearnMore": "False",
             "FFlagBetaBadgeLearnMoreLinkFormview": "False",
             "FFlagControlBetaBadgeWithGuac": "False",
             "FStringVoiceBetaBadgeLearnMoreLink": "null",
             "FIntFullscreenTitleBarTriggerDelayMillis": "3600000",
             "DFFlagEnableDynamicHeadByDefault": "False",
             "FIntRobloxGuiBlurIntensity": "0",
             "DFIntConnectionMTUSize": "900",
             "FIntRakNetResendBufferArrayLength": "128",
             "FFlagOptimizeNetwork": "True",
             "FFlagOptimizeNetworkRouting": "True",
             "FFlagOptimizeNetworkTransport": "True",
             "FFlagOptimizeServerTickRate": "True",
             "DFIntServerPhysicsUpdateRate": "60",
             "DFIntServerTickRate": "60",
             "DFIntRakNetResendRttMultiple": "1",
             "DFIntRaknetBandwidthPingSendEveryXSeconds": "1",
             "DFIntOptimizePingThreshold": "50",
             "DFIntPlayerNetworkUpdateQueueSize": "20",
             "DFIntPlayerNetworkUpdateRate": "60",
             "DFIntNetworkPrediction": "120",
             "DFIntNetworkLatencyTolerance": "1",
             "DFIntMinimalNetworkPrediction": "0.1",
             "FFlagDebugDisableTelemetryEphemeralCounter": "True",
             "FFlagDebugDisableTelemetryEphemeralStat": "True",
             "FFlagDebugDisableTelemetryEventIngest": "True",
             "FFlagDebugDisableTelemetryPoint": "True",
             "FFlagDebugDisableTelemetryV2Counter": "True",
             "FFlagDebugDisableTelemetryV2Event": "True",
             "FFlagDebugDisableTelemetryV2Stat": "True",
             "FFlagDisablePostFx": "True",
             "DFIntMaxFrameBufferSize": "4",
             "FIntRenderShadowIntensity": "0",
             "FFlagCoreGuiTypeSelfViewPresent": "false",
             "FFlagMSRefactor5": "False",
             "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
             "DFIntTimestepArbiterThresholdCFLThou": "300",
             "FFlagAdServiceEnabled": "False",
             "FLogNetwork": "7",
             "FIntDefaultMeshCacheSizeMB": "256",
             "DFIntHttpCurlConnectionCacheSize": "134217728",
             "DFFlagHttpCacheCleanBasedOnMemory": "true",
             "DFFlagEnableHttpCacheForceRevalidate2": "false",
             "DFFlagQueueDataPingFromSendData": "true",
             "FFlagDontCreatePingJob": "true",
             "DFFlagEnablePerfAudioCollection": "false",
             "DFFlagEnablePerfDataCoreCategoryTimersCollection2": "false",
             "DFFlagEnablePerfDataCoreTimersCollection2": "false",
             "DFFlagEnablePerfDataCountersCollection": "false",
             "DFFlagEnablePerfDataGatherTelemetry2": "false",
             "DFFlagEnablePerfDataMemoryCategoriesCollection2": "false",
             "DFFlagEnablePerfDataMemoryCollection": "false",
             "DFFlagEnablePerfDataMemoryPressureCollection": "false",
             "DFFlagEnablePerfDataSubsystemTimersCollection2": "false",
             "DFFlagEnablePerfRenderStatsCollection2": "false",
             "DFFlagEnablePerfStatsCollection3": "false",
             "FFlagBrowserTrackerIdRequestUseWebId2": "false",
             "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
             "FFlagHandleAltEnterFullscreenManually":"False"
      }
        with open(settings_path, 'w') as f:
            json.dump(settings, f)
    else:
        print("Путь к папке Roblox не найден.")
else:
    print("Не удалось определить наилучший DNS-сервер.")

