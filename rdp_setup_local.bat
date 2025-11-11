@echo off
setlocal enabledelayedexpansion
title Настройка RDP на локальном ПК

:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ЗАПУСТИТЕ ОТ ИМЕНИ АДМИНИСТРАТОРА!
    pause
    exit /b 1
)

echo =========================================
echo    Настройка RDP на локальном ПК
echo =========================================
echo.

:: 1. Включение RDP
echo [1/4] Включаем RDP сервер...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

:: 2. Открытие порта в брандмауэре
echo [2/4] Настраиваем брандмауэр...
netsh advfirewall firewall set rule group="remote desktop" new enable=Yes

:: 3. Добавление текущего пользователя в RDP группу
echo [3/4] Настраиваем права пользователя...
for /f "tokens=2 delims=" %%I in ('whoami') do set current_user=%%I
net localgroup "Remote Desktop Users" %current_user% /add

:: 4. Дополнительные настройки безопасности
echo [4/4] Применяем дополнительные настройки...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 1 /f

echo.
echo =========================================
echo    Настройка завершена успешно!
echo =========================================
echo.
pause
