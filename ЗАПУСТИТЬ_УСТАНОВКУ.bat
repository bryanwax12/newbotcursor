@echo off
chcp 65001 >nul
echo ========================================
echo Загрузка проекта на GitHub
echo ========================================
echo.

cd /d "%~dp0"

echo Запускаю скрипт с автоматическим поиском Git...
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0git_upload_find.ps1"

pause

