@echo off
setlocal enabledelayedexpansion

rem Количество попыток пинга
set ATTEMPTS=3

rem Время ожидания ответа в миллисекундах
set TIMEOUT=350

rem Список DNS-серверов для проверки
set DNS_SERVERS=8.8.8.8 1.1.1.1 208.67.222.222 8.8.4.4 1.0.0.1 208.67.220.220 9.9.9.9 149.112.112.112 64.6.64.6 64.6.65.6 84.200.69.80 84.200.70.40 94.140.14.14 94.140.15.15 8.26.56.26 8.20.247.20 156.154.70.1 156.154.71.1 208.67.222.220 198.101.242.72 198.101.242.73

rem Переменная для хранения наилучшего пинга
set "BEST_PING=9999999"

rem Переменная для хранения наилучшего DNS-сервера
set "BEST_DNS="

rem Очистка DNS-кеша
ipconfig /flushdns

rem Очистка временных файлов в AppData
del /q /s "%APPDATA%\Temp\*.*"

rem Определение подключения к сети
for /f "tokens=3 delims=: " %%a in ('netsh interface show interface ^| find "Подключение"') do (
    set "CONNECTION=%%a"
)

rem Параллельная проверка пинга для каждого DNS-сервера с использованием PowerShell
for %%i in (%DNS_SERVERS%) do (
    (
        powershell.exe -Command "
            $result = Test-Connection -ComputerName %%i -Count %ATTEMPTS% -BufferSize 16 -Delay %TIMEOUT%
            if ($result -match 'Received = (\d+)') {
                $responseTime = ($result | Measure-Object -Property ResponseTime -Minimum).Minimum
                Write-Output 'Received:' + $matches[1] + ',ResponseTime:' + $responseTime
            }
        "
    ) | findstr /R "^Received:" > nul && (
        for /f "tokens=2,3 delims=,: " %%j in ('findstr /R "^Received:"') do (
            if %%k lss !BEST_PING! (
                set "BEST_PING=%%k"
                set "BEST_DNS=%%i"
            )
        )
    )
)

rem Вывод результатов
echo Наилучший DNS-сервер: !BEST_DNS! с пингом !BEST_PING! мс

rem Настройка DNS-сервера для IPv4
netsh interface ipv4 set dns "%CONNECTION%" static !BEST_DNS! primary

rem Отключение IPv6
netsh interface ipv6 set global state=disabled

rem Настройка правил брандмауэра для Roblox
set ruleName_outbound=rbxpingoptimizerroblox_outbound
set ruleName_inbound=rbxpingoptimizerroblox_inbound
set portRange=49152-65535
set protocol=UDP
set action=Allow
set profile=Domain,Private,Public

powershell -Command "New-NetFirewallRule -DisplayName '!ruleName_outbound!' -Direction Outbound -LocalPort !portRange! -Protocol !protocol! -Action !action! -Profile !profile!"
powershell -Command "New-NetFirewallRule -DisplayName '!ruleName_inbound!' -Direction Inbound -LocalPort !portRange! -Protocol !protocol! -Action !action! -Profile !profile!"
