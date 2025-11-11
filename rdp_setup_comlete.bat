@echo off
title RDP Setup Complete

:: Проверка прав админа
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ЗАПУСКАЙТЕ ОТ ИМЕНИ АДМИНИСТРАТОРА!
    pause
    exit /b
)

echo Устанавливаем RDP...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
netsh advfirewall firewall set rule group="remote desktop" new enable=Yes

echo.
echo ===== ВАШИ IP-АДРЕСА ДЛЯ ПОДКЛЮЧЕНИЯ =====
echo.
echo Локальные IP (для сети):
ipconfig | findstr "IPv4"

echo.
echo Имя компьютера: %COMPUTERNAME%
echo.

echo ===== КАК ПОДКЛЮЧАТЬСЯ =====
echo.
echo 1. ВНУТРИ СЕТИ: используйте IP выше или имя компьютера
echo 2. ИЗ ИНТЕРНЕТА: нужен внешний IP и проброс порта 3389
echo.
echo Команда для подключения: mstsc
echo.
pause
