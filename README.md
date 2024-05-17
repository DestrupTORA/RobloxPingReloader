<h1 align="center"><img src="https://github.com/DestrupTORA/RobloxPingReloader/assets/157624868/92fa1b1b-d5a9-4391-a063-e5aa85afabf2" alt="0eeeb19633422b1241f4306419a0f15f39d58de9" width="100">


# RobloxPingReloader

This project is designed to optimize the network parameters and behavior of the Roblox application using a script in the Batch language (bat) and the `ClientAppSettings.json` settings file.

## How it Works

The `.bat` script does the following:

1. Determines the best DNS server by measuring ping to different DNS servers.
2. Sets the best DNS server for your Internet connection.
3. Disables IPv6 for network connection.
4. Creates firewall rules for the Roblox application.

The `ClientAppSettings.json` file contains settings to optimize the network settings and behavior of the Roblox application.

## Usage

1. Run the `RobloxPingReloader.bat` file as an administrator.
2. Wait for the script to complete execution.
3. Restart the Roblox application.

## Important

- **SmartScreen warnings** may occur when running the `RobloxPingReloader.bat` file. This is because Windows protects your computer from potentially harmful files. You can ensure the integrity of the code by reviewing it before executing it.
<div style="text-align: center;">
    <img src="https://github.com/DestrupTORA/RobloxPingReloader/assets/157624868/b28034ce-4cb6-4322-9f45-63f1367331c9" width="600"> 
</div>

<div style="text-align: center;">
    <img src="https://github.com/DestrupTORA/RobloxPingReloader/assets/157624868/02dba065-18b9-42f2-a86f-378501eaf786" width="600">
</div>

## License
This project is distributed under the [MIT License](LICENSE).

![Снимок экрана 2024-05-17 161654](https://github.com/DestrupTORA/RobloxPingReloader/assets/157624868/fcd28727-e6b5-4189-9485-c470a6d54025)

## FF (Fast-Flags) for those who have not downloaded the version with a built-in fast flag
## How to use FastFlags without Bloxtrap:
###### You can also do Roblox Studio
1. **Navigate to your Roblox Installation directory. Typically found at `%localappdata%\Roblox\Versions\` for Windows or `C:\Program Files (x86)\Roblox\Versions`.**
2. **Identify the folder `version-xxxxxxxxxxxxxxxx` ~~containing `RobloxPlayerBeta.exe`~~ You can do this for Roblox Studio too.**
3. **Create a new folder named `ClientSettings`. Inside this folder, place the file `ClientAppSettings.json`.**
4. **Paste the JSON into `ClientAppSettings.json`. (You can utilize ChatGPT to format multiple JSONs for clarity if needed)**
5. **Save and your good to go!**
###### Do note that after roblox updates you have to paste in your fflags again.

- Might improve ping:

```json
{
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

