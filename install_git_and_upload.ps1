# Скрипт для установки Git и загрузки кода на GitHub
# Запуск: правой кнопкой -> "Запустить с PowerShell"
# Или: powershell -ExecutionPolicy Bypass -File install_git_and_upload.ps1

# Установка кодировки UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Установка Git и загрузка на GitHub" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Переход в папку скрипта
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath
Write-Host "Рабочая папка: $scriptPath" -ForegroundColor Gray
Write-Host ""

# Проверка наличия Git
$gitInstalled = Get-Command git -ErrorAction SilentlyContinue

if (-not $gitInstalled) {
    Write-Host "[1/5] Git не установлен. Устанавливаю через winget..." -ForegroundColor Yellow
    
    # Попытка установить через winget
    $winget = Get-Command winget -ErrorAction SilentlyContinue
    if ($winget) {
        Write-Host "Устанавливаю Git через winget..." -ForegroundColor Yellow
        winget install --id Git.Git -e --source winget
        Write-Host "Git установлен! Перезапустите PowerShell и запустите скрипт снова." -ForegroundColor Green
        Write-Host "Или установите Git вручную: https://git-scm.com/download/win" -ForegroundColor Yellow
        pause
        exit
    } else {
        Write-Host "winget не найден. Установите Git вручную:" -ForegroundColor Red
        Write-Host "1. Откройте: https://git-scm.com/download/win" -ForegroundColor Yellow
        Write-Host "2. Скачайте и установите Git" -ForegroundColor Yellow
        Write-Host "3. Перезапустите PowerShell" -ForegroundColor Yellow
        Write-Host "4. Запустите этот скрипт снова" -ForegroundColor Yellow
        pause
        exit
    }
} else {
    Write-Host "[1/5] Git установлен: $($gitInstalled.Version)" -ForegroundColor Green
}

Write-Host "[2/5] Инициализация git репозитория..." -ForegroundColor Cyan
Set-Location $PSScriptRoot
git init
if ($LASTEXITCODE -ne 0) {
    Write-Host "ОШИБКА: Не удалось инициализировать git" -ForegroundColor Red
    pause
    exit
}

Write-Host "[3/5] Добавление файлов..." -ForegroundColor Cyan
git add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "ОШИБКА: Не удалось добавить файлы" -ForegroundColor Red
    pause
    exit
}

Write-Host "[4/5] Создание коммита..." -ForegroundColor Cyan
git commit -m "Initial commit: Modern Telegram shipping bot with OxaPay integration"
if ($LASTEXITCODE -ne 0) {
    Write-Host "ОШИБКА: Не удалось создать коммит" -ForegroundColor Red
    pause
    exit
}

Write-Host "[5/5] Настройка remote и загрузка..." -ForegroundColor Cyan
git remote remove origin 2>$null
git remote add origin https://github.com/bryanwax12/newbotcursor.git
git branch -M main

Write-Host ""
Write-Host "Загрузка на GitHub..." -ForegroundColor Yellow
Write-Host "ВНИМАНИЕ: Вам нужно будет ввести учетные данные GitHub" -ForegroundColor Yellow
Write-Host "Используйте Personal Access Token вместо пароля" -ForegroundColor Yellow
Write-Host ""

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "УСПЕХ! Код загружен на GitHub" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Репозиторий: https://github.com/bryanwax12/newbotcursor" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "ОШИБКА при загрузке" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "Возможные причины:" -ForegroundColor Yellow
    Write-Host "1. Неправильные учетные данные" -ForegroundColor Yellow
    Write-Host "2. Нужен Personal Access Token" -ForegroundColor Yellow
    Write-Host "3. Репозиторий не существует или нет доступа" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Создайте токен: https://github.com/settings/tokens" -ForegroundColor Cyan
}

pause
