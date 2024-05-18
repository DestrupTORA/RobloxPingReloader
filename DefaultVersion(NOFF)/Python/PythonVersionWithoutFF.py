import os
from ping3 import ping

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

    # Настройка правил брандмауэра
    ruleName_outbound = "rbxpingoptimizerroblox_outbound"
    ruleName_inbound = "rbxpingoptimizerroblox_inbound"
    portRange = "49152-65535"
    protocol = "UDP"
    action = "Allow"
    profile = "Domain,Private,Public"

    os.system(f"powershell -Command \"New-NetFirewallRule -DisplayName '{ruleName_outbound}' -Direction Outbound -LocalPort {portRange} -Protocol {protocol} -Action {action} -Profile {profile}'\"")
    os.system(f"powershell -Command \"New-NetFirewallRule -DisplayName '{ruleName_inbound}' -Direction Inbound -LocalPort {portRange} -Protocol {protocol} -Action {action} -Profile {profile}'\"")
else:
    print("Не удалось определить наилучший DNS-сервер.")
