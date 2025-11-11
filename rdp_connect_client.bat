@echo off
title RDP Connection Client

echo #################################################
echo # Клиент подключения по RDP                    #
echo #################################################
echo.

set /p server="Введите IP адрес или имя сервера: "
set /p port="Введите порт [3389]: "
if "%port%"=="" set port=3389
set /p username="Введите имя пользователя: "

echo.
echo Подключение к %server%:%port%...
echo Имя пользователя: %username%
echo.

:: Подключение через mstsc
mstsc /v:%server%:%port% /admin

echo.
echo Подключение завершено.
pause
