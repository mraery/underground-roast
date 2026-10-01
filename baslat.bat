@echo off
title Underground Roast - Karanlik Barista
echo ===================================================
echo     Underground Roast: Karanlik Barista Baslatiliyor
echo ===================================================
echo.
cd /d "%~dp0"

echo 1. Yerel oyun sunucusu calistiriliyor (Port: 8085)...
start "Underground Roast Sunucusu" /min python -m http.server 8085 --directory build\web

echo 2. Masaustu Oyun Penceresi Aciliyor...
timeout /t 2 >nul

:: Oncelikle Chrome masaustu uygulama modunu dener (--app parametresiyle pencere gibi acar)
start "" chrome.exe --app="http://localhost:8085" --window-size=1280,780 2>nul
if %ERRORLEVEL% NEQ 0 (
    :: Chrome bulunamazsa varsayilan tarayici ile acar
    start http://localhost:8085
)

echo.
echo ===================================================
echo   Oyun Basariyla Acildi!
echo   Adres: http://localhost:8085
echo ===================================================
echo.
echo Oyunu kapatmak istediginizde bu pencereyi kapatabilirsiniz.
pause
