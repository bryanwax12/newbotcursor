# Простой скрипт для загрузки на GitHub (без установки Git)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Загрузка проекта на GitHub" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Переход в папку скрипта
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

# Проверка Git
$gitInstalled = Get-Command git -ErrorAction SilentlyContinue
if (-not $gitInstalled) {
    Write-Host "ОШИБКА: Git не установлен!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Установите Git:" -ForegroundColor Yellow
    Write-Host "1. Откройте: https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host "2. Скачайте и установите" -ForegroundColor Yellow
    Write-Host "3. Перезапустите PowerShell" -ForegroundColor Yellow
    Write-Host "4. Запустите скрипт снова" -ForegroundColor Yellow
    pause
    exit
}

Write-Host "Git найден: $($gitInstalled.Version)" -ForegroundColor Green
Write-Host ""

# Инициализация
Write-Host "[1/5] Инициализация git..." -ForegroundColor Cyan
git init
if ($LASTEXITCODE -ne 0) { Write-Host "Ошибка инициализации" -ForegroundColor Red; pause; exit }

# Добавление файлов
Write-Host "[2/5] Добавление файлов..." -ForegroundColor Cyan
git add .
if ($LASTEXITCODE -ne 0) { Write-Host "Ошибка добавления файлов" -ForegroundColor Red; pause; exit }

# Коммит
Write-Host "[3/5] Создание коммита..." -ForegroundColor Cyan
git commit -m "Initial commit: Telegram shipping bot"
if ($LASTEXITCODE -ne 0) { Write-Host "Ошибка создания коммита" -ForegroundColor Red; pause; exit }

# Remote
Write-Host "[4/5] Настройка remote..." -ForegroundColor Cyan
git remote remove origin 2>$null
git remote add origin https://github.com/bryanwax12/newbotcursor.git
git branch -M main

# Push
Write-Host "[5/5] Загрузка на GitHub..." -ForegroundColor Cyan
Write-Host ""
Write-Host "ВНИМАНИЕ: Используйте Personal Access Token вместо пароля!" -ForegroundColor Yellow
Write-Host "Создайте токен: https://github.com/settings/tokens" -ForegroundColor Yellow
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
    Write-Host "ОШИБКА при загрузке" -ForegroundColor Red
    Write-Host "Проверьте учетные данные или используйте Personal Access Token" -ForegroundColor Yellow
}

pause

