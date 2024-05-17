# Ping Optimization for RobloxPingReloader

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

## License

This project is distributed under the [MIT License](LICENSE).
